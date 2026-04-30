{% macro backfill_filter(column_name) %}

{% if var('start_date', none) and var('end_date', none) %}

    and {{ column_name }} between '{{ var("start_date") }}'
                              and '{{ var("end_date") }}'

{% endif %}

{% endmacro %}