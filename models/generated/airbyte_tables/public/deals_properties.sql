{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "public",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('deals_properties_ab3') }}
select
    _airbyte_deals_hashid,
    dealname,
    dealtype,
    closedate,
    dealstage,
    createdate,
    link_to_jd,
    description,
    company_name,
    hs_is_closed,
    job_description,
    role_description,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_properties_hashid
from {{ ref('deals_properties_ab3') }}
-- properties at deals/properties from {{ ref('deals') }}
where 1 = 1

