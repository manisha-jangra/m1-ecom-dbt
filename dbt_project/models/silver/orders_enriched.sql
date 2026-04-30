select
    o.order_id,
    o.customer_id,
    c.name,
    o.order_date,
    o.amount
from {{ ref('stg_orders') }} o
join {{ ref('stg_customers') }} c
on o.customer_id = c.customer_id