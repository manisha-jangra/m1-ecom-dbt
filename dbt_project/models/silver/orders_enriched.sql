select
    o.order_id,
    o.customer_id,
    c.name as customer_name,
    p.product_name,
    p.product_id,
    p.category,
    o.order_date,
    o.amount

from {{ ref('stg_orders') }} o  

left join {{ ref('stg_customers') }} c
    on o.customer_id = c.customer_id

inner join {{ ref('stg_products') }} p
    on o.product_id = p.product_id

where o.order_date is not null
  and o.amount is not null