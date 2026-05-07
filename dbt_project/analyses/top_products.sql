select
    p.product_name,
    p.category,
    count(f.order_id) as total_orders,
    sum(f.amount) as revenue

from {{ ref('fact_orders') }} f
join {{ ref('dim_products') }} p
    on f.product_id = p.product_id

group by p.product_name, p.category
order by revenue desc