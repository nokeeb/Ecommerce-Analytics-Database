import psycopg2
from faker import Faker
from pathlib import Path
import pandas as pd
import random

def main():
    BASE_DIR=Path(__file__).resolve().parent
    #Connecting to the database
    conn=psycopg2.connect(
        dbname='Ecommerce Analytics',
        user='postgres',
        password='samni',
        host='localhost'
    )
    fake=Faker()
    imported_df=pd.read_csv(BASE_DIR/'olist_products_dataset.csv')
    products_df=pd.DataFrame()
    products_df['product_id']=imported_df['product_id']
    products_df['product_category']=imported_df['product_category_name']
    product_name=pd.Series()
    product_price=pd.Series()
    categories=["Laptop","USB","Phone","PC","Headphones"]
    for i in range(0,products_df.shape[0]):
        product_name.loc[i]=fake.word().capitalize()+ " " +fake.random_element(categories)
        product_price=random.Random()

    # customer_df=pd.DataFrame()
    # customer_df['customer_id']=imported_df['customer_unique_id']
    # customer_df['customer_city']=imported_df['customer_city']
    # customer_df['customer_state']=imported_df['customer_state']
    # customer_name=pd.Series()
    # print(customer_df)
    # for i in range(0,customer_df.shape[0]):
    #     customer_name.loc[i]=fake.name()

    # customer_df['customer_name']=customer_name
    # customer_df.to_csv(BASE_DIR/'customer_df.csv')
    
    # print('INFO:',customer_df.info())
    # print('DESCRIBE:',customer_df.describe())
    # print('ISNULL:',customer_df[customer_df.isnull().any(axis=1)])
    # print('DUPES:',customer_df.where(customer_df.duplicated()))


    # cur=conn.cursor()
    # # cur.execute('''
    # #             SELECT * FROM schema''')
    # # db_version=cur.fetchone()
    # print(db_version)
if __name__=='__main__':
    main()