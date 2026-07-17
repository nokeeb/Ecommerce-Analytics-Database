DROP VIEW IF EXISTS schema.customer_summary

CREATE VIEW schema.customer_summary AS(
SELECT c.customer_id,c.customer_name,c.city,c.state,
COUNT(o.order_id),SUM(oi.quantity*p.price::numeric::integer)
FROM schema.customers AS c
JOIN schema.orders AS o ON o.customer_id=c.customer_id
JOIN schema.order_items AS oi ON oi.order_id=o.order_id
JOIN schema.products AS p ON p.product_id=oi.product_id
GROUP BY c.customer_id,c.customer_name,c.city,c.state
ORDER BY 5 DESC,6 DESC
)

SELECT * FROM schema.customer_summary

--

DROP VIEW IF EXISTS schema.product_summary

CREATE VIEW schema.product_summary AS 
(
SELECT p.product_id,p.product_name,p.category,p.price,SUM(oi.quantity) AS UnitsSold,
SUM(oi.quantity*price::numeric::integer) AS TotalRevenue
FROM schema.products AS p
JOIN schema.order_items AS oi ON oi.product_id=p.product_id
GROUP BY p.product_id,p.product_name,p.category,p.price
ORDER BY 5 DESC,6 DESC
)

SELECT * FROM schema.product_summary

