-- inserts.sql
-- Sample data for testing the database schema

--Instead of this, it is better to use data-generator.py for a more real-word experience

-- CUSTOMERS

INSERT INTO customers (customer_id, customer_name, city, state)
VALUES
('cust_001', 'Marko Markovic', 'Sarajevo', 'BiH'),
('cust_002', 'Ana Kovac', 'Mostar', 'BiH'),
('cust_003', 'Ivan Horvat', 'Zagreb', 'Croatia'),
('cust_004', 'Emma Smith', 'London', 'UK');


-- PRODUCTS

INSERT INTO products (product_id, product_name, category, price)
VALUES
('prod_001', 'Laptop Lenovo', 'Electronics', 900.00),
('prod_002', 'Wireless Mouse', 'Accessories', 25.00),
('prod_003', 'Mechanical Keyboard', 'Accessories', 120.00),
('prod_004', 'Monitor Samsung', 'Electronics', 300.00),
('prod_005', 'Office Chair', 'Furniture', 200.00);


-- ORDERS

INSERT INTO orders (order_id, customer_id, order_date)
VALUES
('ord_001', 'cust_001', '2026-01-10'),
('ord_002', 'cust_002', '2026-01-15'),
('ord_003', 'cust_001', '2026-02-05'),
('ord_004', 'cust_003', '2026-02-20'),
('ord_005', 'cust_004', '2026-03-01');


-- ORDER ITEMS

INSERT INTO order_items (order_id, product_id, quantity)
VALUES
('ord_001', 'prod_001', 1),
('ord_001', 'prod_002', 2),

('ord_002', 'prod_005', 1),

('ord_003', 'prod_003', 1),
('ord_003', 'prod_004', 2),

('ord_004', 'prod_001', 1),
('ord_004', 'prod_002', 1),

('ord_005', 'prod_004', 3);