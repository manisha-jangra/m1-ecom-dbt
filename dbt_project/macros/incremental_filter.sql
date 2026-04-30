{% macro incremental_filter(column_name) %}

{% if is_incremental() %}

    and {{ column_name }} > (
        select coalesce(max({{ column_name }}), '1900-01-01')
        from {{ this }}
    )

{% endif %}

{% endmacro %}