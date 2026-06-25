{{ config(
    materialized='table'
) }}

select distinct

    product_id,

    product_name,

    category,

    brand,

    price

from {{ ref('stg_products') }}