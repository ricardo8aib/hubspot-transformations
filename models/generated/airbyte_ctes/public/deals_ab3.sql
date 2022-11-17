{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_public",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('deals_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        adapter.quote('id'),
        boolean_to_string('archived'),
        array_to_string('contacts'),
        array_to_string('companies'),
        'createdat',
        'updatedat',
        array_to_string('line_items'),
        object_to_string('properties'),
    ]) }} as _airbyte_deals_hashid,
    tmp.*
from {{ ref('deals_ab2') }} tmp
-- deals
where 1 = 1

