--total consumption by customer
WITH order_values AS
(
SELECT o.order_id AS orderid,SUM(oi.quantity*p.price::numeric::integer) AS orderSum,o.customer_id AS customer FROM schema.orders AS o
JOIN schema.order_items AS oi ON oi.order_id=o.order_id
JOIN schema.products AS p ON p.product_id=oi.product_id
GROUP BY o.order_id
)
SELECT SUM(OrderSum),c.customer_id,c.customer_name FROM schema.customers AS c 
JOIN order_values AS ov ON ov.customer=c.customer_id
GROUP BY c.customer_id


--Total revenue by product
WITH orders_products AS
(
SELECT oi.order_id, SUM(oi.quantity*p.price::numeric::integer) as SumByOrder,p.product_id AS product
FROM schema.order_items AS oi 
JOIN schema.products AS p ON p.product_id=oi.product_id
GROUP BY oi.order_id,p.product_id
)
SELECT SUM(SumByOrder),p.product_id,p.product_name FROM 
schema.products AS p JOIN orders_products AS op
ON op.product=p.product_id
GROUP BY p.product_id,p.product_name

--List of products and their rank in price for their category
SELECT p.product_id,p.product_name,p.category,p.price,
RANK() OVER (PARTITION BY p.category ORDER BY p.price DESC) AS row_num
FROM schema.products AS p

--Customers ranked by consumption
SELECT c.customer_id,c.customer_name,COUNT(o.order_id),
ROW_NUMBER() OVER (ORDER BY COUNT(o.order_id) desc)
FROM schema.customers AS c JOIN 
schema.orders AS o ON o.customer_id=c.customer_id
GROUP BY c.customer_id,c.customer_name



