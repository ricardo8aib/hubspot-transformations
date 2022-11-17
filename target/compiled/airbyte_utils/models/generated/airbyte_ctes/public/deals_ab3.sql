
with __dbt__cte__deals_ab1 as (

-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: "postgres".public._airbyte_raw_deals
select
    jsonb_extract_path_text(_airbyte_data, 'id') as "id",
    jsonb_extract_path_text(_airbyte_data, 'archived') as archived,
    jsonb_extract_path(_airbyte_data, 'contacts') as contacts,
    jsonb_extract_path(_airbyte_data, 'companies') as companies,
    jsonb_extract_path_text(_airbyte_data, 'createdAt') as createdat,
    jsonb_extract_path_text(_airbyte_data, 'updatedAt') as updatedat,
    jsonb_extract_path(_airbyte_data, 'line_items') as line_items,
    
        jsonb_extract_path(table_alias._airbyte_data, 'properties')
     as properties,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    now() as _airbyte_normalized_at
from "postgres".public._airbyte_raw_deals as table_alias
-- deals
where 1 = 1
),  __dbt__cte__deals_ab2 as (

-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: __dbt__cte__deals_ab1
select
    cast("id" as text) as "id",
    cast(archived as boolean) as archived,
    contacts,
    companies,
    cast(nullif(createdat, '') as 
    timestamp with time zone
) as createdat,
    cast(nullif(updatedat, '') as 
    timestamp with time zone
) as updatedat,
    line_items,
    cast(properties as 
    jsonb
) as properties,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    now() as _airbyte_normalized_at
from __dbt__cte__deals_ab1
-- deals
where 1 = 1
)-- SQL model to build a hash column based on the values of this record
-- depends_on: __dbt__cte__deals_ab2
select
    md5(cast(coalesce(cast("id" as text), '') || '-' || coalesce(cast(archived as text), '') || '-' || coalesce(cast(contacts as text), '') || '-' || coalesce(cast(companies as text), '') || '-' || coalesce(cast(createdat as text), '') || '-' || coalesce(cast(updatedat as text), '') || '-' || coalesce(cast(line_items as text), '') || '-' || coalesce(cast(properties as text), '') as text)) as _airbyte_deals_hashid,
    tmp.*
from __dbt__cte__deals_ab2 tmp
-- deals
where 1 = 1