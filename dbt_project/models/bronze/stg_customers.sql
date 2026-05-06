select
    customer_id,

    initcap(trim(name)) as name,

    lower(trim(email)) as email,

    {{ safe_cast_timestamp('created_at') }} as created_at


from {{ ref('raw_customers') }}

where customer_id is not null