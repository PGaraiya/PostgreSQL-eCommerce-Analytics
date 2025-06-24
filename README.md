# PostgreSQL-eCommerce-Analytics
An SQL project to analyze e-commerce data, featuring complex queries and business insights.

**Tables:**

*   **`Customers`**: Stores unique information about each customer.
*   **`Products`**: Contains details for each product available for sale.
*   **`Orders`**: Records each order placed, linked to a specific customer.
*   **`Order_Items`**: A junction table that links products to orders, allowing for many-to-many relationships (one order can have many products, and one product can be in many orders).

---

### Project Setup

To run this project locally, follow these steps:

1.  **Prerequisites:** Ensure you have PostgreSQL and a tool like DBeaver or pgAdmin installed.
2.  **Create the Database:** Create a new database in PostgreSQL named `e_commerce_db`.
3.  **Build the Schema:** Run the entire `schema.sql` script to create the necessary tables and their relationships.
4.  **Populate the Database:** Run the entire `data.sql` script to insert the sample data into the tables.
5.  **Run Queries:** Use the `queries.sql` file to execute the analytical queries and see the results.

---

### Queries and Insights

This section showcases some of the analytical queries written to answer key business questions.

#### 1. What are our best-selling products?

*   **Business Question:** "What are our top 5 best-selling products by total quantity sold?"
*   **SQL Query:**
    ```sql
    SELECT
        p.product_name,
        SUM(oi.quantity) AS total_quantity_sold
    FROM Order_Items AS oi
    JOIN Products AS p ON oi.product_id = p.product_id
    GROUP BY p.product_name
    ORDER BY total_quantity_sold DESC
    LIMIT 5;
    ```
*   **Insight:** This query identifies the most popular products, helping the business focus on inventory management and marketing for high-demand items like "Laptop" and "Headphones".

#### 2. Who are our most valuable customers?

*   **Business Question:** "Who are our top 3 customers by total spending?"
*   **SQL Query:**
    ```sql
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
    ```
*   **Insight:** Identifying top spenders like John Doe allows the marketing team to create targeted loyalty programs and personalized offers, fostering customer retention.

#### 3. What is our monthly sales growth?

*   **Business Question:** "Show me the month-over-month sales revenue growth for 2023."
*   **SQL Query:**
    ```sql
    WITH MonthlySales AS (
        SELECT
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
        LAG(monthly_revenue, 1, 0) OVER (ORDER BY sales_month) AS previous_month_revenue,
        monthly_revenue - LAG(monthly_revenue, 1, 0) OVER (ORDER BY sales_month) AS monthly_growth
    FROM MonthlySales
    ORDER BY sales_month;
    ```
*   **Insight:** This advanced query uses a CTE and a Window Function (`LAG`) to analyze sales trends over time. This is critical for financial forecasting and evaluating the performance of marketing campaigns.
