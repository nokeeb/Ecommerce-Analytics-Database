import psycopg2
import os
from pathlib import Path
from dotenv import load_dotenv

db_password=os.getenv('PG_PASSWORD','changeme')
conn=psycopg2.connect(
    dbname='postgres',
    user='postgres',
    password=db_password,
    host='localhost'

)
conn.autocommit=True
cur=conn.cursor()
cur.execute("DROP DATABASE IF EXISTS ecommerce_analytics")
cur.execute("CREATE DATABASE ecommerce_analytics")
print('Database created.Or already existed')
cur.close()
conn.close()