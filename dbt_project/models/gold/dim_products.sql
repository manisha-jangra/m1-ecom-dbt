select distinct
    product_id,
    product_name,
    category,
    price

from {{ ref('stg_products') }}