# Ecommerce-Analytics-Database
<!-- Answering question -->

# What was done
The first step was getting rid of data that was not needed such as seller data(focus is on orders and customers in this project),
as well as stuff like product name/description length.Pandas was used to clean the dataset.

Through the data-generator.py script which can be found in the src folder, we fill the database with the required data through
performing SQL commands using the psycopg2 library

After that I manually go through the checks.sql file inside the sql folder to check for nulls,duplicates and to check FK integrity
