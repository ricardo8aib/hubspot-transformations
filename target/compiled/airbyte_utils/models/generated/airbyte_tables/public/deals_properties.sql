
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
),  __dbt__cte__deals_properties_ab2 as (

-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
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
),  __dbt__cte__deals_properties_ab3 as (

-- SQL model to build a hash column based on the values of this record
-- depends_on: __dbt__cte__deals_properties_ab2
select
    md5(cast(coalesce(cast(_airbyte_deals_hashid as text), '') || '-' || coalesce(cast(dealname as text), '') || '-' || coalesce(cast(dealtype as text), '') || '-' || coalesce(cast(closedate as text), '') || '-' || coalesce(cast(dealstage as text), '') || '-' || coalesce(cast(createdate as text), '') || '-' || coalesce(cast(link_to_jd as text), '') || '-' || coalesce(cast(description as text), '') || '-' || coalesce(cast(company_name as text), '') || '-' || coalesce(cast(hs_is_closed as text), '') || '-' || coalesce(cast(job_description as text), '') || '-' || coalesce(cast(role_description as text), '') as text)) as _airbyte_properties_hashid,
    tmp.*
from __dbt__cte__deals_properties_ab2 tmp
-- properties at deals/properties
where 1 = 1
)-- Final base SQL model
-- depends_on: __dbt__cte__deals_properties_ab3
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
    now() as _airbyte_normalized_at,
    _airbyte_properties_hashid
from __dbt__cte__deals_properties_ab3
-- properties at deals/properties from "postgres".public."deals"
where 1 = 1