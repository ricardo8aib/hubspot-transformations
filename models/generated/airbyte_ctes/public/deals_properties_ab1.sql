{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_public",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('deals') }}
select
    _airbyte_deals_hashid,
    {{ json_extract_scalar('properties', ['dealname'], ['dealname']) }} as dealname,
    {{ json_extract_scalar('properties', ['dealtype'], ['dealtype']) }} as dealtype,
    {{ json_extract_scalar('properties', ['closedate'], ['closedate']) }} as closedate,
    {{ json_extract_scalar('properties', ['dealstage'], ['dealstage']) }} as dealstage,
    {{ json_extract_scalar('properties', ['createdate'], ['createdate']) }} as createdate,
    {{ json_extract_scalar('properties', ['link_to_jd'], ['link_to_jd']) }} as link_to_jd,
    {{ json_extract_scalar('properties', ['description'], ['description']) }} as description,
    {{ json_extract_scalar('properties', ['company_name'], ['company_name']) }} as company_name,
    {{ json_extract_scalar('properties', ['hs_is_closed'], ['hs_is_closed']) }} as hs_is_closed,
    {{ json_extract_scalar('properties', ['job_description'], ['job_description']) }} as job_description,
    {{ json_extract_scalar('properties', ['role_description'], ['role_description']) }} as role_description,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('deals') }} as table_alias
-- properties at deals/properties
where 1 = 1
and properties is not null

