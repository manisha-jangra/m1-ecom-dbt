-- analysis/daily_revenue.sql

select
date(order_date) as order_day,
count(order_id) as total_orders,
sum(amount) as daily_revenue

from {{ ref('fact_orders') }}

group by order_day
order by order_day
