{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_public",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('deals_properties_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_deals_hashid',
        'dealname',
        'dealtype',
        'closedate',
        'dealstage',
        'createdate',
        'link_to_jd',
        'description',
        'company_name',
        boolean_to_string('hs_is_closed'),
        'job_description',
        'role_description',
    ]) }} as _airbyte_properties_hashid,
    tmp.*
from {{ ref('deals_properties_ab2') }} tmp
-- properties at deals/properties
where 1 = 1

