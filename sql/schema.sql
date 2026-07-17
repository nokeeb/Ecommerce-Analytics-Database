DROP TABLE IF EXISTS schema.customers CASCADE;

CREATE TABLE IF NOT EXISTS schema.customers
                (
                customer_id text  NOT NULL,
                customer_name text  NOT NULL,
                city text  NOT NULL,
                state text  NOT NULL,
                CONSTRAINT customers_pkey PRIMARY KEY (customer_id)
                );


DROP TABLE IF EXISTS schema.orders CASCADE;

CREATE TABLE IF NOT EXISTS schema.orders
                (
                order_id TEXT NOT NULL,
                customer_id TEXT NOT NULL,
                order_date TIMESTAMP NOT NULL,
                CONSTRAINT order_id_PK PRIMARY KEY(order_id),
                CONSTRAINT customer_id_FK FOREIGN KEY(customer_id) REFERENCES schema.customers(customer_id)
                
                );

DROP TABLE IF EXISTS schema.products CASCADE;

CREATE TABLE IF NOT EXISTS schema.products
                (
                product_id TEXT NOT NULL,
                product_name TEXT NOT NULL,
                category TEXT NOT NULL,
                price MONEY NOT NULL,
                CONSTRAINT product_id_PK PRIMARY KEY(product_id)
                
                
                );

DROP TABLE IF EXISTS schema.order_items CASCADE;

CREATE TABLE IF NOT EXISTS schema.order_items
                (
                order_item_id INT NOT NULL GENERATED ALWAYS AS IDENTITY,
                order_id TEXT NOT NULL,
                product_id TEXT NOT NULL,
                quantity INT NOT NULL,
                CONSTRAINT order_item_id_PK PRIMARY KEY(order_item_id),
                CONSTRAINT order_id_FK FOREIGN KEY(order_id) REFERENCES schema.orders(order_id),
                CONSTRAINT product_id_FK FOREIGN KEY(product_id) REFERENCES schema.products(product_id)
                );