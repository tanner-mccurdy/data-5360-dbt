{{ config(
    materialized = 'table',
    schema = 'dw_oliver'
)}}

select
    employee_id,
    first_name,
    last_name,
    email,
    certification_completion_id,
    parse_json(certification_json):certification_name::varchar as certification_name,
    parse_json(certification_json):certification_cost::int as certification_cost,
    parse_json(certification_json):certification_awarded_date::date as certification_awarded_date
from {{ source('oliver_landing', 'employee_certifications')}}
