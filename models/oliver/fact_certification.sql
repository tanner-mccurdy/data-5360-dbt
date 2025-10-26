{{ config(
    materialized = 'table',
    schema = 'dw_oliver'
)}}

select
    c.certification_awarded_date as date_key,
    c.employee_id as employee_key,
    c.certification_name,
    c.certification_cost
from {{ ref('stg_employee_certifications') }} c
inner join {{ ref('dim_date') }} d
    on c.certification_awarded_date = d.date_day
inner join {{ ref('oliver_dim_employee')}} e
    on c.employee_id = e.employee_id
