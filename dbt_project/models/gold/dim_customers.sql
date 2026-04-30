select
    customer_id,
    name,
    email
from {{ ref('stg_customers') }}