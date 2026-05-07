select
    order_id,
    customer_id,
    product_id,

    order_date,

    case 
    -- This is a regex (pattern check) 
        when amount::text ~ '^\d+(\.\d+)?$'
        then amount::numeric
        else null
    end as amount

from {{ ref('raw_orders') }}

where order_id is not null