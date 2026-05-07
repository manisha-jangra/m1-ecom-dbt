select
    customer_id,

    initcap(trim(name)) as name,

    lower(trim(email)) as email,

    created_at


from {{ ref('raw_customers') }}

where customer_id is not null