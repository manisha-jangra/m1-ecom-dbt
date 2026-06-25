WITH monthly_revenue AS (
SELECT
DATE_TRUNC('month', order_date) AS month,
SUM(amount) AS revenue
FROM fact_orders
GROUP BY 1
)

SELECT
month,
revenue,
LAG(revenue) OVER (ORDER BY month) AS revenue_pm
FROM monthly_revenue
ORDER BY month;