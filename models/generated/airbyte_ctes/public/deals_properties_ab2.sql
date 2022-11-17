{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_public",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('deals_properties_ab1') }}
select
    _airbyte_deals_hashid,
    cast(dealname as {{ dbt_utils.type_string() }}) as dealname,
    cast(dealtype as {{ dbt_utils.type_string() }}) as dealtype,
    cast({{ empty_string_to_null('closedate') }} as {{ type_timestamp_with_timezone() }}) as closedate,
    cast(dealstage as {{ dbt_utils.type_string() }}) as dealstage,
    cast({{ empty_string_to_null('createdate') }} as {{ type_timestamp_with_timezone() }}) as createdate,
    cast(link_to_jd as {{ dbt_utils.type_string() }}) as link_to_jd,
    cast(description as {{ dbt_utils.type_string() }}) as description,
    cast(company_name as {{ dbt_utils.type_string() }}) as company_name,
    {{ cast_to_boolean('hs_is_closed') }} as hs_is_closed,
    cast(job_description as {{ dbt_utils.type_string() }}) as job_description,
    cast(role_description as {{ dbt_utils.type_string() }}) as role_description,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('deals_properties_ab1') }}
-- properties at deals/properties
where 1 = 1

