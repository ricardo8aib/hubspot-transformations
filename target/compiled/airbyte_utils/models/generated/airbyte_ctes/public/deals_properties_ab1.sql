
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