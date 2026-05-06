select
    product_name,
    category,
    count(order_id) as total_orders,
    sum(amount) as revenue

from {{ ref('fact_orders') }}

group by product_name, category
order by revenue desc