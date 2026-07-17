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
-Top products (by revenue,by number of orders etc..)
-Top customers(by consumption, by number of orders..)
-Monthly order trend
-Average number of orders, average order values

# Examples of results
Top 10 customers (id,name) by consumption(total money spent)

      customer_id                   |    customer_name           |  consumption

"06f52edb5666757a552cc099a5bce4a5"	|    "Alyssa Wagner"	     |   "$5,820.00"
"cfe44a707ebf4a1d8072f98871cf4682"	|    "John Cobb"	         |   "$2,976.00"
"bda9e79a0f077587fd9f4528974324fd"	|    "Benjamin Collins"	     |   "$2,940.00"
"7288276c67d797e67a2bc2322ee575e1"	|    "Gina Powell"	         |   "$2,697.00"
"66c87d25828d3391f31eb04e585eaedd"	|    "Troy Lewis"	         |   "$2,349.00"
"f27d584311a18ce82b2ead2bd8a63366"	|    "Jill Mccoy"	         |   "$2,306.00"
"51378a8908cdc12c6545fdf842383c97"	|    "Trevor Rangel"	     |   "$2,064.00"
"23be4b5b1e9add3f80da9607e9de5775"	|    "Stephanie Campbell"    |   "$2,046.00"
"d91da6adf28c3ef0597453b582f68e66"	|    "Sarah Carpenter"	     |   "$2,016.00"
"8ac3644a8ccfcd2bbbfb1a1a77ab7201"	|    "Katie Walker"	         |   "$1,909.00"


Top 5 orders (id) by revenue

            order_id                     revenue

"8272b63d03f5f79c56e9e4120aec44ef"	 |    5820
"3a213fcdfe7d98be74ea0dc05a8b31ae"	 |    2976
"37ee401157a3a0b28c9c6d0ed8c3b24b"	 |    2940
"428a2f660dc84138d969ccd69a0ab6d5"	 |    2697
"7f2c22c54cbae55091a09a9653fd2b8a"	 |    2349

Many more queries you can check for yourself :)

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

``pip install -r requirements.txt``