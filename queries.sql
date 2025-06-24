-- Q1: Top 5 Best-Selling Products by Quantity
SELECT
    p.product_name,
    SUM(oi.quantity) AS total_quantity_sold
FROM Order_Items AS oi
JOIN Products AS p ON oi.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_quantity_sold DESC
LIMIT 5;

-- Q2: Total Revenue by Category
SELECT
    p.category,
    SUM(oi.quantity * oi.price_per_unit) AS total_revenue
FROM Order_Items AS oi
JOIN Products AS p ON oi.product_id = p.product_id
GROUP BY p.category
ORDER BY total_revenue DESC;

-- Q3: Top 3 Most Valuable Customers
SELECT
    c.first_name,
    c.last_name,
    c.email,
    SUM(oi.quantity * oi.price_per_unit) AS total_spent
FROM Customers AS c
JOIN Orders AS o ON c.customer_id = o.customer_id
JOIN Order_Items AS oi ON o.order_id = oi.order_id
GROUP BY c.customer_id, c.first_name, c.last_name, c.email
ORDER BY total_spent DESC
LIMIT 3;

-- Q4: Monthly Sales Growth for 2023
WITH MonthlySales AS (
    SELECT
        -- PostgreSQL function to truncate the date to the first day of the month
        DATE_TRUNC('month', o.order_date)::DATE AS sales_month,
        SUM(oi.quantity * oi.price_per_unit) AS monthly_revenue
    FROM Orders AS o
    JOIN Order_Items AS oi ON o.order_id = oi.order_id
    WHERE EXTRACT(YEAR FROM o.order_date) = 2023
    GROUP BY sales_month
)
SELECT
    sales_month,
    monthly_revenue,
    -- LAG() is a window function that gets data from a previous row
    LAG(monthly_revenue, 1, 0) OVER (ORDER BY sales_month) AS previous_month_revenue,
    monthly_revenue - LAG(monthly_revenue, 1, 0) OVER (ORDER BY sales_month) AS monthly_growth
FROM MonthlySales
ORDER BY sales_month;