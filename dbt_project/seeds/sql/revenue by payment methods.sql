SELECT
payment_method,
SUM(amount) AS revenue
FROM fact_orders
GROUP BY payment_method
ORDER BY revenue DESC;