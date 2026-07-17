# Ecommerce-Analytics-Database
Analysis of parts of Brazilian E-Commerce Public Dataset by Olist.Was slighy modified (added product name through Faker Python library)

# What was done
The first step was getting rid of data that was not needed such as seller data(focus is on orders and customers in this project),
as well as stuff like product name/description length.Pandas was used to clean the dataset.

Through the data-generator.py script which can be found in the src folder, we fill the database with the required data through
performing SQL commands using the psycopg2 library

After that I manually go through the checks.sql file inside the sql folder to check for nulls,duplicates and to check FK integrity

# Simple queries
Can be found in sql/queries_basic.sql

Top 10 customers by consumption - helps us see the most loyal customers

Top 10 products by revenue - taking a look at the top products

Number of orders by customer - looking at the most active customers, also useful for comparison with top 10 customers by consumption

Average order value - can be useful for future estimations

Number of orders by month - helps us with predicting trends

# Database model 
<img width="1382" height="687" alt="ER_diagram" src="https://github.com/user-attachments/assets/5b833407-5fed-427e-b9e7-28e9151a537a" />
