DROP VIEW IF EXISTS ecommerce.customer_summary

CREATE VIEW ecommerce.customer_summary AS(
SELECT c.customer_id,c.customer_name,c.city,c.state,
COUNT(o.order_id),SUM(oi.quantity*p.price::numeric)
FROM ecommerce.customers AS c
JOIN ecommerce.orders AS o ON o.customer_id=c.customer_id
JOIN ecommerce.order_items AS oi ON oi.order_id=o.order_id
JOIN ecommerce.products AS p ON p.product_id=oi.product_id
GROUP BY c.customer_id,c.customer_name,c.city,c.state
ORDER BY 5 DESC,6 DESC
)

SELECT * FROM ecommerce.customer_summary

--

DROP VIEW IF EXISTS ecommerce.product_summary

CREATE VIEW ecommerce.product_summary AS 
(
SELECT p.product_id,p.product_name,p.category,p.price,SUM(oi.quantity) AS UnitsSold,
SUM(oi.quantity*price::numeric) AS TotalRevenue
FROM ecommerce.products AS p
JOIN ecommerce.order_items AS oi ON oi.product_id=p.product_id
GROUP BY p.product_id,p.product_name,p.category,p.price
ORDER BY 5 DESC,6 DESC
)

SELECT * FROM ecommerce.product_summary

