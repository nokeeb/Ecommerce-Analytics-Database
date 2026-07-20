import psycopg2
import pandas as pd
from pathlib import Path
import os
from dotenv import load_dotenv
from psycopg2.extras import execute_values

def main():
    conn=None
    cur=None
    try:
        BASE_DIR=Path(__file__).resolve().parent.parent
        load_dotenv(BASE_DIR / '.env')

        db_password=os.getenv('PG_PASSWORD','changeme')
        #Create a file named '.env' inside the ROOT PROJECT DIRECTORY, and set (just write the line:) PG_PASSWORD=your_postgres_password


        # Connecting to the database
        conn=psycopg2.connect(
            dbname='ecommerce_analytics',
            user='postgres',
            password=db_password,
            host='localhost'
        ) #you should change this according to your database configuration
        #loading and cleaning datasets
        customers_df=pd.read_csv(BASE_DIR/'data'/'processed'/'customer_df.csv')
        clean_customer_df=customers_df.drop_duplicates(subset='customer_id')
        products_df=pd.read_csv(BASE_DIR/'data'/'processed'/'products_df.csv')
        clean_products_df=products_df.drop_duplicates(subset='product_id')
        orders_df=pd.read_csv(BASE_DIR/'data'/'processed'/'orders_df.csv')
        clean_orders_df=orders_df.drop_duplicates(subset='order_id')
        order_items_df=pd.read_csv(BASE_DIR/'data'/'processed'/'order_item_df.csv')
        
        #checking FK integrity
        customer_ids=set(clean_customer_df['customer_id'])
        invalid_orders=clean_orders_df[~clean_orders_df['customer_id'].isin(customer_ids)]
        print('Number of invalid orders:',invalid_orders.shape[0])
        product_ids=set(clean_products_df['product_id'])
        invalid_items_products=order_items_df[~order_items_df['product_id'].isin(product_ids)]
        print('Number of invalid order items(invalid product):',invalid_items_products.shape[0])
        order_ids=set(clean_orders_df['order_id'])
        invalid_items_orders=order_items_df[~order_items_df['order_id'].isin(order_ids)]
        print('Number of invalid order items(invalid order):',invalid_items_orders.shape[0])

        
        
        cur=conn.cursor()
        print('Starting CREATE and INSERT operations, this might take a couple of minutes..')
        cur.execute("""DROP SCHEMA IF EXISTS ecommerce CASCADE""")
        cur.execute("""CREATE SCHEMA ecommerce""")
        cur.execute("""DROP TABLE IF EXISTS ecommerce.customers CASCADE""")
        cur.execute("""CREATE TABLE IF NOT EXISTS ecommerce.customers
                    (
                    customer_id text  NOT NULL,
                    city text  NOT NULL,
                    state text  NOT NULL,
                    customer_name text  NOT NULL,
                    
                    
                    CONSTRAINT customers_pkey PRIMARY KEY (customer_id)
                    )""")
        customers=list(clean_customer_df[['customer_id','customer_city','customer_state','customer_name']].itertuples(index=False,name=None))
        execute_values(cur,"""INSERT INTO ecommerce.customers(customer_id,city,state,customer_name) VALUES %s""",customers)



        cur.execute("""DROP TABLE IF EXISTS ecommerce.orders CASCADE""")
        cur.execute("""CREATE TABLE IF NOT EXISTS ecommerce.orders
                    (
                    order_id TEXT NOT NULL,
                    customer_id TEXT NOT NULL,
                    order_date TIMESTAMP NOT NULL,
                    CONSTRAINT order_id_PK PRIMARY KEY(order_id),
                    CONSTRAINT customer_id_FK FOREIGN KEY(customer_id) REFERENCES ecommerce.customers(customer_id)
                    
                    )""")
        orders=list(clean_orders_df[['order_id','customer_id','order_date']].itertuples(index=False,name=None))
        execute_values(cur,"""INSERT INTO ecommerce.orders(order_id,customer_id,order_date) VALUES %s""",orders)
            
        
        

        cur.execute("""DROP TABLE IF EXISTS ecommerce.products CASCADE""")
        cur.execute("""CREATE TABLE IF NOT EXISTS ecommerce.products
                    (
                    product_id TEXT NOT NULL,
                    product_name TEXT NOT NULL,
                    category TEXT NOT NULL,
                    price NUMERIC(10,2) NOT NULL,
                    CONSTRAINT product_id_PK PRIMARY KEY(product_id)
                    
                    
                    )""")
        clean_products_df['product_price']=clean_products_df['product_price'].astype(float).round(2)
        products=list(clean_products_df[['product_id','product_category','product_name','product_price']].itertuples(index=False,name=None))
        execute_values(cur,"""INSERT INTO ecommerce.products(product_id,product_name,category,price) VALUES %s""",products)

            
        cur.execute("""DROP TABLE IF EXISTS ecommerce.order_items CASCADE """)
        cur.execute("""CREATE TABLE IF NOT EXISTS ecommerce.order_items
                    (
                    order_item_id INT NOT NULL GENERATED ALWAYS AS IDENTITY,
                    order_id TEXT NOT NULL,
                    product_id TEXT NOT NULL,
                    quantity INT NOT NULL,
                    CONSTRAINT order_item_id_PK PRIMARY KEY(order_item_id),
                    CONSTRAINT order_id_FK FOREIGN KEY(order_id) REFERENCES ecommerce.orders(order_id),
                    CONSTRAINT product_id_FK FOREIGN KEY(product_id) REFERENCES ecommerce.products(product_id)
                    )""")
        order_items_df['quantity']=order_items_df['quantity'].astype(int)
        order_items=list(order_items_df[['order_id','product_id','quantity']].itertuples(index=False,name=None))
        execute_values(cur,"""INSERT INTO ecommerce.order_items(order_id,product_id,quantity) VALUES %s""",order_items)


        conn.commit()
        print("Insert done! You can now proceed with database operations.")
    except Exception as e:
        print(f"Error occured:{e}")
        if conn:
            conn.rollback()
    finally:
        if cur:
            cur.close()
        if conn:
            conn.close()
if __name__=='__main__':
    main()
