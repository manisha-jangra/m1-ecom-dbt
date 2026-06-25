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
LAG(revenue) OVER (ORDER BY month) AS revenue_pm,
ROUND(
(
revenue -
LAG(revenue) OVER (ORDER BY month)
) * 100.0
/
NULLIF(
LAG(revenue) OVER (ORDER BY month),
0
),
2
) AS mom_percent
FROM monthly_revenue
ORDER BY month;