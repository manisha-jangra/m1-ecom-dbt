select
    customer_id,

    initcap(trim(name)) as customer_name,

    lower(trim(email)) as email,

    initcap(trim(city)) as city,

    cast(created_at as timestamp) as created_at

from {{ ref('raw_customers') }}

where customer_id is not null