SELECT
f.order_id,
f.order_date,
c.name AS customer_name,
c.city,
p.product_name,
p.category,
p.brand,
f.quantity,
f.amount,
f.payment_method
FROM fact_orders f
JOIN dim_customers c
ON f.customer_id = c.customer_id
JOIN dim_products p
ON f.product_id = p.product_id
ORDER BY f.order_date DESC;