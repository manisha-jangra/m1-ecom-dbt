-- macros/safe_cast.sql
{% macro safe_cast_timestamp(column) %}
case 
    when {{ column }} ~ '^\d{4}-\d{2}-\d{2}( \d{2}:\d{2}:\d{2})?$'
    then {{ column }}::timestamp
    else null
end
{% endmacro %}