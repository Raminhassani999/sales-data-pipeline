-- Total revenue
SELECT SUM(total_amount) AS total_revenue
FROM sales;


-- Revenue by product
SELECT
    product,
    SUM(quantity) AS total_quantity,
    SUM(total_amount) AS total_revenue
FROM sales
GROUP BY product
ORDER BY total_revenue DESC;


-- Revenue by customer
SELECT
    customer,
    SUM(total_amount) AS total_spent
FROM sales
GROUP BY customer
ORDER BY total_spent DESC;