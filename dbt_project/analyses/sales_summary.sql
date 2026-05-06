-- analysis/sales_summary.sql

select
count(distinct order_id) as total_orders,
count(distinct customer_id) as total_customers,
sum(amount) as total_revenue,
avg(amount) as avg_order_value

from {{ ref('fact_orders') }}
