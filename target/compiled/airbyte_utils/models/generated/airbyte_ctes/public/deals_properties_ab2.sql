
with __dbt__cte__deals_properties_ab1 as (

-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: "postgres".public."deals"
select
    _airbyte_deals_hashid,
    jsonb_extract_path_text(properties, 'dealname') as dealname,
    jsonb_extract_path_text(properties, 'dealtype') as dealtype,
    jsonb_extract_path_text(properties, 'closedate') as closedate,
    jsonb_extract_path_text(properties, 'dealstage') as dealstage,
    jsonb_extract_path_text(properties, 'createdate') as createdate,
    jsonb_extract_path_text(properties, 'link_to_jd') as link_to_jd,
    jsonb_extract_path_text(properties, 'description') as description,
    jsonb_extract_path_text(properties, 'company_name') as company_name,
    jsonb_extract_path_text(properties, 'hs_is_closed') as hs_is_closed,
    jsonb_extract_path_text(properties, 'job_description') as job_description,
    jsonb_extract_path_text(properties, 'role_description') as role_description,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    now() as _airbyte_normalized_at
from "postgres".public."deals" as table_alias
-- properties at deals/properties
where 1 = 1
and properties is not null
)-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: __dbt__cte__deals_properties_ab1
select
    _airbyte_deals_hashid,
    cast(dealname as text) as dealname,
    cast(dealtype as text) as dealtype,
    cast(nullif(closedate, '') as 
    timestamp with time zone
) as closedate,
    cast(dealstage as text) as dealstage,
    cast(nullif(createdate, '') as 
    timestamp with time zone
) as createdate,
    cast(link_to_jd as text) as link_to_jd,
    cast(description as text) as description,
    cast(company_name as text) as company_name,
    cast(hs_is_closed as boolean) as hs_is_closed,
    cast(job_description as text) as job_description,
    cast(role_description as text) as role_description,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    now() as _airbyte_normalized_at
from __dbt__cte__deals_properties_ab1
-- properties at deals/properties
where 1 = 1