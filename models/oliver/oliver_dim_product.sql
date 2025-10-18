{{ config(
    materialized = 'table',
    schema = 'dw_oliver'
)}}

select
    product_id as product_key,
    product_id,
    unit_price,
    description,
    product_name,
from {{ source('oliver_landing', 'product')}}