import psycopg2
import pandas as pd
from pathlib import Path


def main():
    BASE_DIR=Path(__file__).resolve().parent

    # Connecting to the database
    conn=psycopg2.connect(
        dbname='Ecommerce Analytics',
        user='postgres',
        password='samni',
        host='localhost'
    )
    
    order_item_df=pd.read_csv(BASE_DIR/'order_item_df.csv')
    clean_df=order_item_df.drop_duplicates(subset='order_item_id')
    
    cur=conn.cursor()
    for i in range(clean_df.shape[0]):
        cur.execute("""
            INSERT INTO schema.order_items(customer_id, customer_name, city, state)
            VALUES (%s, %s, %s, %s)
        """, (
            clean_df['customer_id'].iloc[i],
            clean_df['customer_name'].iloc[i],
            clean_df['customer_city'].iloc[i],
            clean_df['customer_state'].iloc[i]
        ))
    conn.commit()
    
    
    
if __name__=='__main__':
    main()