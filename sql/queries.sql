-----Top 10 customers by consumption
SELECT  c.customer_id AS ID ,c.customer_name AS Name ,SUM(p.price*oi.quantity) FROM ecommerce.customers AS c
JOIN ecommerce.orders AS o ON o.customer_id=c.customer_id
JOIN ecommerce.order_items AS oi ON oi.order_id=o.order_id
JOIN ecommerce.products AS p ON p.product_id=oi.product_id
GROUP BY c.customer_id,c.customer_name,o.order_id
ORDER BY 3 DESC
LIMIT 10;

--Top 10 products by revenue
SELECT p.product_id,p.product_name,SUM(oi.quantity*p.price) FROM ecommerce.products AS p
JOIN ecommerce.order_items AS oi ON oi.product_id=p.product_id
GROUP BY p.product_id
ORDER BY 3 DESC
LIMIT 10;

--Number of orders by customer
SELECT c.customer_id,c.customer_name,COUNT(o.order_id) FROM ecommerce.customers AS c
JOIN ecommerce.orders AS o ON o.customer_id=c.customer_id
GROUP BY c.customer_id,c.customer_name
ORDER BY 3 DESC;

--Average order value

SELECT ROUND(AVG(subq.sum),2) FROM(
SELECT SUM(oi.quantity*p.price) AS sum FROM ecommerce.orders AS o
JOIN ecommerce.order_items AS oi ON oi.order_id=o.order_id
JOIN ecommerce.products AS p ON p.product_id=oi.product_id
GROUP BY o.order_id
) AS subq


--Number of orders by month
SELECT DATE_TRUNC('month',o.order_date) AS month,COUNT(o.order_id) FROM ecommerce.orders AS o
GROUP BY DATE_TRUNC('month',o.order_date)
ORDER BY month





--Agregate queries




--Average consumption by customer
SELECT c.customer_id,c.customer_name,ROUND(AVG(oi.quantity*price),2) FROM ecommerce.customers AS c
JOIN ecommerce.orders AS o ON o.customer_id=c.customer_id
JOIN ecommerce.order_items AS oi ON oi.order_id=o.order_id
JOIN ecommerce.products AS p ON p.product_id=oi.product_id
GROUP BY c.customer_id


--Average price by category
SELECT p.category,ROUND(AVG(p.price),2)
FROM ecommerce.products AS p
GROUP BY p.category
ORDER BY 2 DESC

--Total revenue by category 
SELECT p.category,SUM(p.price*oi.quantity) FROM ecommerce.products AS p
JOIN ecommerce.order_items AS oi ON oi.product_id=p.product_id
JOIN ecommerce.orders AS o ON oi.order_id=o.order_id
GROUP BY p.category 
ORDER BY 2 DESC

--Number of orders by state 
SELECT c.state,COUNT(*) FROM ecommerce.orders AS o
JOIN ecommerce.customers AS c ON o.customer_id=c.customer_id
GROUP BY c.state
ORDER BY 2 DESC

--Top 5 orders by revenue
SELECT o.order_id,SUM(oi.quantity*p.price::numeric) FROM ecommerce.orders AS o
JOIN ecommerce.order_items AS oi ON oi.order_id=o.order_id
JOIN ecommerce.products AS p ON p.product_id=oi.product_id
GROUP BY o.order_id
ORDER BY 2 DESC
LIMIT 5;




