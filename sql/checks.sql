--null check
SELECT * FROM schema.order_items AS oi
WHERE oi.order_id IS NULL
OR oi.product_id  IS NULL
OR oi.quantity IS NULL
OR oi.order_item_id IS NULL;

SELECT * FROM schema.customers AS c
WHERE c.customer_id IS NULL
OR c.customer_name  IS NULL
OR c.city IS NULL
OR c.state IS NULL;

SELECT * FROM schema.products AS p
WHERE p.product_id IS NULL
OR p.product_name IS NULL
OR p.category IS NULL
OR p.price IS NULL;

SELECT * FROM schema.orders AS o
WHERE o.order_id IS NULL
OR o.customer_id IS NULL
OR o.order_date IS NULL;

--duplicate check

SELECT COUNT(c.customer_id),c.customer_id FROM schema.customers AS c
GROUP BY c.customer_id;
HAVING COUNT(c.customer_id)>1;

SELECT COUNT(oi.order_item_id),oi.order_item_id FROM schema.order_items AS oi
GROUP BY oi.order_item_id
HAVING COUNT(oi.order_item_id)>1;

SELECT COUNT(p.product_id),p.product_id FROM schema.products AS p
GROUP BY p.product_id
HAVING COUNT(p.product_id)>1;

SELECT COUNT(o.order_id),o.order_id FROM schema.orders AS o
GROUP BY o.order_id
HAVING COUNT(o.order_id)>1;

--FK integrity check

SELECT DISTINCT o.customer_id FROM schema.orders AS o
LEFT JOIN schema.customers AS c ON o.customer_id=c.customer_id
WHERE c.customer_id IS NULL;

SELECT DISTINCT oi.product_id FROM schema.order_items AS oi
LEFT JOIN schema.products AS p ON oi.product_id=p.product_id
WHERE p.product_id IS NULL;

SELECT DISTINCT oi.order_id FROM schema.order_items AS oi
LEFT JOIN schema.orders AS o ON oi.order_id=o.order_id
WHERE o.order_id IS NULL;