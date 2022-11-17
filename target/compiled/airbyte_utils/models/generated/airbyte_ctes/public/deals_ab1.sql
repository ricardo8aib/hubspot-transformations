
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