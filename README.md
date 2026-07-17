# Ecommerce-Analytics-Database
Analysis of parts of Brazilian E-Commerce Public Dataset by Olist.Was slighy modified (added product name through Faker Python library)

# What was done
The first step was getting rid of data that was not needed such as seller data(focus is on orders and customers in this project),
as well as stuff like product name/description length.Pandas was used to clean the dataset.

Through the data-generator.py script which can be found in the src folder, we fill the database with the required data through
performing SQL commands using the psycopg2 library

I have checked manually in PostgreSQL for nulls, duplicates and FK integrity.If you wish to check for yourself, you can find the queries in sql/checks.sql

# Database model
