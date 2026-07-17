# Ecommerce-Analytics-Database
Analysis of parts of Brazilian E-Commerce Public Dataset by Olist.Was slighy modified (added product name through Faker Python library)

# What was done
The first step was getting rid of data that was not needed such as seller data(focus is on orders and customers in this project),
as well as stuff like product name/description length.Pandas was used to clean the dataset.

Through the data-generator.py script which can be found in the ``src`` folder, we fill the database with the required data through
performing SQL commands using the ``psycopg2`` library

I have checked manually in PostgreSQL for nulls, duplicates and FK integrity.If you wish to check for yourself, you can find the queries in ``sql/checks.sql``

Then comes the analysis part..
# Simple queries
Can be found in sql/queries_basic.sql

Top 10 customers by consumption - helps us see the most loyal customers

Top 10 products by revenue - taking a look at the top products

Number of orders by customer - looking at the most active customers, also useful for comparison with top 10 customers by consumption

Average order value - can be useful for future estimations

Number of orders by month - helps us with predicting trends

# Database model 
<img width="1382" height="687" alt="ER_diagram" src="https://github.com/user-attachments/assets/5b833407-5fed-427e-b9e7-28e9151a537a" />

Relationships: 
1 Customer can make several orders. 1 Order belongs to 1 customer
1 Order can have several order items.1 order item belongs to 1 order
1 Product can be an order item several times.1 Order item can be only 1 product.

# Business questions

Analysis of e-commerce is needed.So i took a look at stuff such as:
-What products are the most ordered, what products bring the most revenue...

-What customers spend the most, what customers have the most orders..

-How does the number of orders change on a monthly basis

-Average number of orders, average order values


# Examples of results
Top 10 customers (id,name) by consumption(total money spent)

-----Top 10 customers by consumption

```sql
SELECT  c.customer_id AS ID ,c.customer_name AS Name ,SUM(p.price*oi.quantity) 
FROM schema.customers AS c
JOIN schema.orders AS o ON o.customer_id=c.customer_id
JOIN schema.order_items AS oi ON oi.order_id=o.order_id
JOIN schema.products AS p ON p.product_id=oi.product_id
GROUP BY c.customer_id,c.customer_name,o.order_id
ORDER BY 3 DESC
LIMIT 10;
```

<img width="582" height="365" alt="image" src="https://github.com/user-attachments/assets/b90a61fa-48f4-4ed3-8bbe-9e54181c48d0" />





Top 5 orders (id) by revenue
```sql
SELECT o.order_id,SUM(oi.quantity*p.price::numeric) FROM schema.orders AS o
JOIN schema.order_items AS oi ON oi.order_id=o.order_id
JOIN schema.products AS p ON p.product_id=oi.product_id
GROUP BY o.order_id
ORDER BY 2 DESC
LIMIT 5;
```


<img width="409" height="208" alt="image" src="https://github.com/user-attachments/assets/788d5f34-6505-46a1-897b-e6dcfe187a5d" />


Many more queries you can check in
```sql
sql/advanced.sql  
sql/checks.sql  
sql/joins.sql  
sql/performance.sql  
sql/queries.sql  
sql/views.sql
```
# SQL techniques
-DDL (Create,Insert) -> data-generator.py

-Simple queries -> checks.sql & queries.sql

-Joins (inner,left)

-Group by, order by, having

-Advanced concepts such as CTEs and window functions -> advanced.sql

-Views -> views.sql

-EXPLAIN ANALYZE before and after indexes -> performance.sql


# Installation
Run command:
```bash
git clone https://github.com/nokeeb/crypto-data-pipeline.git4
```
# Requirements
Run command:
``pip install -r requirements.txt``

## Database configuration

This project does not store the PostgreSQL password in source code.

Before running the Python scripts, set the `PG_PASSWORD` environment variable locally.

Example:

### Windows PowerShell
```powershell
$env:PG_PASSWORD="your_postgres_password"
python src\load_data.py
```

### Linux / macOS
```bash
export PG_PASSWORD="your_postgres_password"
python src/load_data.py
```

OR creating a file named ``.env`` and writing inside it:

PG_PASSWORD="your_postgres_password"
