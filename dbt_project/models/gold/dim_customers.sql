{{ config(
    materialized='incremental',
    unique_key='customer_id',
    incremental_strategy='merge'
) }}

select distinct
    customer_id,

    customer_name,

    email,

    city,

    created_at

from {{ ref('stg_customers') }}

{{ incremental_filter('created_at') }}
{{ backfill_filter('created_at') }}