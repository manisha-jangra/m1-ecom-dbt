select
    product_id,

    trim(product_name) as product_name,

    initcap(trim(category)) as category,

    initcap(trim(brand)) as brand,

    case
        when price::text ~ '^\d+(\.\d+)?$'
        then price::numeric
        else null
    end as price

from {{ ref('raw_products') }}

where product_id is not null