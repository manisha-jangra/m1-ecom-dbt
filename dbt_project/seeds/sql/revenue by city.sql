SELECT
c.city,
SUM(f.amount) AS revenue
FROM fact_orders f
JOIN dim_customers c
ON f.customer_id = c.customer_id
GROUP BY c.city
ORDER BY revenue DESC;