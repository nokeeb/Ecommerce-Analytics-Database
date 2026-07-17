import psycopg2
import pandas as pd
from pathlib import Path
import os
from dotenv import load_dotenv

def main():
    BASE_DIR=Path(__file__).resolve().parent.parent
    load_dotenv(BASE_DIR / '.env')

    db_password=os.getenv('PG_PASSWORD','changeme')
    #Create a file named '.env' inside the ROOT PROJECT DIRECTORY, and set (just write the line:) PG_PASSWORD=your_postgres_password


    # Connecting to the database
    conn=psycopg2.connect(
        dbname='Ecommerce Analytics',
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
    cur.execute("""DROP SCHEMA IF EXISTS schema""")
    cur.execute("""CREATE SCHEMA schema"""
    cur.execute("""DROP TABLE IF EXISTS schema.customers CASCADE""")
    cur.execute("""CREATE TABLE IF NOT EXISTS schema.customers
                (
                customer_id text  NOT NULL,
                customer_name text  NOT NULL,
                city text  NOT NULL,
                state text  NOT NULL,
                CONSTRAINT customers_pkey PRIMARY KEY (customer_id)
                )""")
    for i in range(clean_customer_df.shape[0]):
        cur.execute("""
            INSERT INTO schema.customers(customer_id, customer_name, city, state)
            VALUES (%s, %s, %s, %s)
        """, (
            clean_customer_df['customer_id'].iloc[i],
            clean_customer_df['customer_name'].iloc[i],
            clean_customer_df['customer_city'].iloc[i],
            clean_customer_df['customer_state'].iloc[i]
        ))


    cur.execute("""DROP TABLE IF EXISTS schema.orders CASCADE""")
    cur.execute("""CREATE TABLE IF NOT EXISTS schema.orders
                (
                order_id TEXT NOT NULL,
                customer_id TEXT NOT NULL,
                order_date TIMESTAMP NOT NULL,
                CONSTRAINT order_id_PK PRIMARY KEY(order_id),
                CONSTRAINT customer_id_FK FOREIGN KEY(customer_id) REFERENCES schema.customers(customer_id)
                
                )""")
    for i in range (clean_orders_df.shape[0]):
        cur.execute("""INSERT INTO schema.orders(order_id,customer_id,order_date) VALUES (%s,%s,%s)""",
                    
        (clean_orders_df['order_id'].iloc[i],clean_orders_df['customer_id'].iloc[i],clean_orders_df['order_date'].iloc[i])
                    )
        
    
    

    cur.execute("""DROP TABLE IF EXISTS schema.products CASCADE""")
    cur.execute("""CREATE TABLE IF NOT EXISTS schema.products
                (
                product_id TEXT NOT NULL,
                product_name TEXT NOT NULL,
                category TEXT NOT NULL,
                price MONEY NOT NULL,
                CONSTRAINT product_id_PK PRIMARY KEY(product_id)
                
                
                )""")
    for i in range (clean_products_df.shape[0]):
        product_price=int(clean_products_df['product_price'].iloc[i])
        cur.execute("""INSERT INTO schema.products(product_id,product_name,category,price) VALUES (%s,%s,%s,%s)"""
                    ,(clean_products_df['product_id'].iloc[i],clean_products_df['product_name'].iloc[i],
                    clean_products_df['product_category'].iloc[i],product_price)
                    )
    cur.execute("""DROP TABLE IF EXISTS schema.order_items CASCADE """)
    cur.execute("""CREATE TABLE IF NOT EXISTS schema.order_items
                (
                order_item_id INT NOT NULL GENERATED ALWAYS AS IDENTITY,
                order_id TEXT NOT NULL,
                product_id TEXT NOT NULL,
                quantity INT NOT NULL,
                CONSTRAINT order_item_id_PK PRIMARY KEY(order_item_id),
                CONSTRAINT order_id_FK FOREIGN KEY(order_id) REFERENCES schema.orders(order_id),
                CONSTRAINT product_id_FK FOREIGN KEY(product_id) REFERENCES schema.products(product_id)
                )""")
    for i in range(order_items_df.shape[0]):
        quantity=int(order_items_df['quantity'].iloc[i])
        cur.execute("""INSERT INTO schema.order_items(order_id,product_id,quantity) VALUES (%s,%s,%s)""",
                    (order_items_df['order_id'].iloc[i],
                    order_items_df['product_id'].iloc[i],quantity))

    conn.commit()
    print("Insert done! You can now proceed with database operations.")
if __name__=='__main__':
    main()
