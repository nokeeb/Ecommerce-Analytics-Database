DROP TABLE IF EXISTS ecommerce.customers CASCADE;

CREATE TABLE IF NOT EXISTS ecommerce.customers
                (
                customer_id text  NOT NULL,
                customer_name text  NOT NULL,
                city text  NOT NULL,
                state text  NOT NULL,
                CONSTRAINT customers_pkey PRIMARY KEY (customer_id)
                );


DROP TABLE IF EXISTS ecommerce.orders CASCADE;

CREATE TABLE IF NOT EXISTS ecommerce.orders
                (
                order_id TEXT NOT NULL,
                customer_id TEXT NOT NULL,
                order_date TIMESTAMP NOT NULL,
                CONSTRAINT order_id_PK PRIMARY KEY(order_id),
                CONSTRAINT customer_id_FK FOREIGN KEY(customer_id) REFERENCES ecommerce.customers(customer_id)
                
                );

DROP TABLE IF EXISTS ecommerce.products CASCADE;

CREATE TABLE IF NOT EXISTS ecommerce.products
                (
                product_id TEXT NOT NULL,
                product_name TEXT NOT NULL,
                category TEXT NOT NULL,
                price NUMERIC(10,2) NOT NULL,
                CONSTRAINT product_id_PK PRIMARY KEY(product_id)
                
                
                );

DROP TABLE IF EXISTS ecommerce.order_items CASCADE;

CREATE TABLE IF NOT EXISTS ecommerce.order_items
                (
                order_item_id INT NOT NULL GENERATED ALWAYS AS IDENTITY,
                order_id TEXT NOT NULL,
                product_id TEXT NOT NULL,
                quantity INT NOT NULL,
                CONSTRAINT order_item_id_PK PRIMARY KEY(order_item_id),
                CONSTRAINT order_id_FK FOREIGN KEY(order_id) REFERENCES ecommerce.orders(order_id),
                CONSTRAINT product_id_FK FOREIGN KEY(product_id) REFERENCES ecommerce.products(product_id)
                );