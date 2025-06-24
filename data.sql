-- data.sql

-- Insert data into Customers
INSERT INTO Customers (customer_id, first_name, last_name, email, registration_date) VALUES
(1, 'John', 'Doe', 'john.doe@email.com', '2022-01-10'),
(2, 'Jane', 'Smith', 'jane.smith@email.com', '2022-02-15'),
(3, 'Peter', 'Jones', 'peter.jones@email.com', '2022-03-20'),
(4, 'Alice', 'Williams', 'alice.w@email.com', '2023-01-05');

-- Insert data into Products
INSERT INTO Products (product_id, product_name, category, price) VALUES
(101, 'Laptop', 'Electronics', 1200.00),
(102, 'Smartphone', 'Electronics', 800.00),
(103, 'Headphones', 'Electronics', 150.00),
(201, 'Coffee Maker', 'Home Goods', 80.00),
(202, 'Blender', 'Home Goods', 60.00);

-- Insert data into Orders
-- Notice customer 1 (John Doe) has two orders
INSERT INTO Orders (order_id, customer_id, order_date, status) VALUES
(1001, 1, '2023-02-15', 'delivered'),
(1002, 2, '2023-03-10', 'shipped'),
(1003, 1, '2023-04-01', 'pending'),
(1004, 3, '2023-04-05', 'delivered'),
(1005, 4, '2023-04-06', 'shipped');

-- Insert data into Order_Items
-- Notice order 1001 has two different products
INSERT INTO Order_Items (order_item_id, order_id, product_id, quantity, price_per_unit) VALUES
(1, 1001, 101, 1, 1200.00), -- John bought a Laptop
(2, 1001, 103, 2, 145.00),  -- John also bought 2 Headphones (price was slightly different then)
(3, 1002, 102, 1, 800.00),  -- Jane bought a Smartphone
(4, 1002, 202, 1, 60.00),   -- Jane also bought a Blender
(5, 1003, 103, 1, 150.00),  -- John bought another Headphone
(6, 1004, 201, 1, 80.00),   -- Peter bought a Coffee Maker
(7, 1005, 101, 1, 1200.00); -- Alice bought a Laptop