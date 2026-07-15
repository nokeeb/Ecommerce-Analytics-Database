SELECT DISTINCT o.customer_id FROM schema.orders AS o
LEFT JOIN schema.customers AS c ON o.customer_id=c.customer_id
WHERE c.customer_id IS NULL;

SELECT DISTINCT oi.product_id FROM schema.order_items AS oi
LEFT JOIN schema.products AS p ON oi.product_id=p.product_id
WHERE p.product_id IS NULL;

SELECT DISTINCT oi.order_id FROM schema.order_items AS oi
LEFT JOIN schema.orders AS o ON oi.order_id=o.order_id
WHERE o.order_id IS NULL;