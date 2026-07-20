--List of all order items (customer name,product name,quantity and price) - only orders 
--that exist and have valid products
SELECT c.customer_name,p.product_name,oi.quantity,p.price FROM ecommerce.customers AS c
JOIN ecommerce.orders AS o ON o.customer_id=c.customer_id
JOIN ecommerce.order_items AS oi ON oi.order_id=o.order_id
JOIN ecommerce.products AS p ON p.product_id=oi.product_id
WHERE o.order_id IS NOT NULL AND p.product_id IS NOT NULL

--List of all customers and if they have orders, number of orders and total consumption
SELECT c.customer_name,COUNT(o.order_id),SUM(oi.quantity*p.price::numeric) 
FROM ecommerce.customers AS c
LEFT JOIN ecommerce.orders AS o ON c.customer_id=o.customer_id
JOIN ecommerce.order_items AS oi ON oi.order_id=o.order_id
JOIN ecommerce.products AS p ON p.product_id=oi.product_id
GROUP BY c.customer_id,c.customer_name
HAVING COUNT(o.order_id)>1


--List of all orders with their number of order items
SELECT o.order_id,COUNT(oi.order_item_id) FROM ecommerce.orders AS o
JOIN ecommerce.order_items AS oi ON oi.order_id=o.order_id
GROUP BY o.order_id


