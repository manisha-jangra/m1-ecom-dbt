SELECT
c.name AS customer_name,
SUM(f.amount) AS revenue
FROM fact_orders f
JOIN dim_customers c
ON f.customer_id = c.customer_id
GROUP BY c.name
ORDER BY revenue DESC
LIMIT 10;