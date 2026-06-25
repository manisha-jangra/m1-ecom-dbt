SELECT
DATE_TRUNC('month', order_date) AS month,
SUM(amount) AS revenue
FROM fact_orders
GROUP BY 1
ORDER BY 1;