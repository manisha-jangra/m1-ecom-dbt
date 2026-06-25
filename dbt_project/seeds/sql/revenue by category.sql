SELECT
p.category,
SUM(f.amount) AS revenue
FROM fact_orders f
JOIN dim_products p
ON f.product_id = p.product_id
GROUP BY p.category
ORDER BY revenue DESC;