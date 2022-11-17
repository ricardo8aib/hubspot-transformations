{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "public",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('deals_ab3') }}
select
    {{ adapter.quote('id') }},
    archived,
    contacts,
    companies,
    createdat,
    updatedat,
    line_items,
    properties,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_deals_hashid
from {{ ref('deals_ab3') }}
-- deals from {{ source('public', '_airbyte_raw_deals') }}
where 1 = 1

