{{ config(
    materialized='incremental',
    unique_key='order_id',
    incremental_strategy='merge'
) }}

select
    order_id,
    customer_id,
    order_date,
    amount
from {{ ref('orders_enriched') }}

where 1=1


{{ backfill_filter('order_date') }}

{{ incremental_filter('order_date') }}