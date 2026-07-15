-----Top 10 customers by consumption
SELECT  c.customer_id AS ID ,c.customer_name AS Name ,SUM(p.price*oi.quantity) FROM schema.customers AS c
JOIN schema.orders AS o ON o.customer_id=c.customer_id
JOIN schema.order_items AS oi ON oi.order_id=o.order_id
JOIN schema.products AS p ON p.product_id=oi.product_id
GROUP BY c.customer_id,c.customer_name,o.order_id
ORDER BY 3 DESC
LIMIT 10;

--Top 10 products by revenue
SELECT p.product_id,p.product_name,SUM(oi.quantity*p.price) FROM schema.products AS p
JOIN schema.order_items AS oi ON oi.product_id=p.product_id
GROUP BY p.product_id
ORDER BY 3 DESC
LIMIT 10;

--Number of orders by customer
SELECT c.customer_id,c.customer_name,COUNT(o.order_id) FROM schema.customers AS c
JOIN schema.orders AS o ON o.customer_id=c.customer_id
GROUP BY c.customer_id,c.customer_name
ORDER BY 3 DESC;

--Average order value

SELECT ROUND(AVG(subq.sum),2) FROM(
SELECT SUM(oi.quantity*p.price::numeric::integer) AS sum FROM schema.orders AS o
JOIN schema.order_items AS oi ON oi.order_id=o.order_id
JOIN schema.products AS p ON p.product_id=oi.product_id
GROUP BY o.order_id
) AS subq


--Number of orders by month
SELECT DATE_TRUNC('month',o.order_date) AS month,COUNT(o.order_id) FROM schema.orders AS o
GROUP BY DATE_TRUNC('month',o.order_date)
ORDER BY month