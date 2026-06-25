SELECT
p.brand,
SUM(f.amount) AS revenue
FROM fact_orders f
JOIN dim_products p
ON f.product_id = p.product_id
GROUP BY p.brand
ORDER BY revenue DESC;