{{ config(
    materialized='incremental',
    unique_key='order_id',
    incremental_strategy='merge'
) }}

select

    order_id,

    customer_id,

    product_id,

    customer_name,

    city,

    product_name,

    category,

    brand,

    quantity,

    payment_method,

    order_date,

    amount

from {{ ref('orders_enriched') }}

{{ backfill_filter('order_date') }}

{{ incremental_filter('order_date') }}