{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_public",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('deals_ab1') }}
select
    cast({{ adapter.quote('id') }} as {{ dbt_utils.type_string() }}) as {{ adapter.quote('id') }},
    {{ cast_to_boolean('archived') }} as archived,
    contacts,
    companies,
    cast({{ empty_string_to_null('createdat') }} as {{ type_timestamp_with_timezone() }}) as createdat,
    cast({{ empty_string_to_null('updatedat') }} as {{ type_timestamp_with_timezone() }}) as updatedat,
    line_items,
    cast(properties as {{ type_json() }}) as properties,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('deals_ab1') }}
-- deals
where 1 = 1

