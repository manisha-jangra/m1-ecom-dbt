{{ config(
    materialized='incremental',
    unique_key='product_id',
    incremental_strategy='merge'
) }}
select distinct
    product_id,
    product_name,
    category,
    price,
    created_at
from {{ ref('stg_products') }}
{{ incremental_filter('created_at') }}
{{ backfill_filter('created_at') }}