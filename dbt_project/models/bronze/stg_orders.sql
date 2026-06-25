select
    order_id,

    customer_id,

    product_id,

    cast(order_date as timestamp) as order_date,

    quantity::integer as quantity,

    case
        when amount::text ~ '^\d+(\.\d+)?$'
        then amount::numeric
        else null
    end as amount,

    initcap(trim(payment_method)) as payment_method

from {{ ref('raw_orders') }}

where order_id is not null