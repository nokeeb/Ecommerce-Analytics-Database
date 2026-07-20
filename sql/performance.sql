--before indexes
EXPLAIN ANALYZE SELECT * FROM ecommerce.orders AS o
WHERE (o.order_date>='2017-01-01' AND o.order_date<='2017-12-31')
AND o.customer_id = '8d50f5eadf50201ccdcedfb9e2ac8455'

DROP INDEX IF EXISTS ecommerce.order_date_and_customer_idx;
CREATE INDEX order_date_and_customer_idx ON ecommerce.orders(order_date,customer_id);

--after indexes
EXPLAIN ANALYZE SELECT * FROM ecommerce.orders AS o
WHERE (o.order_date>='2017-01-01' AND o.order_date<='2017-12-31')
AND o.customer_id = '8d50f5eadf50201ccdcedfb9e2ac8455'

--due to the size of the dataset(not as large), the difference in performance is mostly mild.
--The execution time after indexes does not go over 12-13 ms.Before the indexes it can go up to 20ms.





--before indexes
EXPLAIN ANALYZE SELECT * FROM ecommerce.orders AS o
JOIN ecommerce.order_items AS oi ON oi.order_id=o.order_id
JOIN ecommerce.products AS p ON p.product_id=oi.product_id
WHERE p.category LIKE 'climatizacao'

DROP INDEX IF EXISTS ecommerce.product_category_idx
CREATE INDEX product_category_idx ON ecommerce.products(category)

--after indexes
EXPLAIN ANALYZE SELECT * FROM ecommerce.orders AS o
JOIN ecommerce.order_items AS oi ON oi.order_id=o.order_id
JOIN ecommerce.products AS p ON p.product_id=oi.product_id
WHERE p.category LIKE 'climatizacao'

--In this example the performance change is also mild and unnoticeable, but we can see the change from Seq Scan to Index Scan