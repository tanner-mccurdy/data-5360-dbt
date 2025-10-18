{{ config(
    materialized = 'table',
    schema = 'dw_oliver'
)}}

select
    e.employee_key,
    cu.cust_key,
    p.product_key,
    st.store_key,
    d.date_key,
    ol.quantity,
    ol.unit_price,
    o.total_amount as dollars_sold
from {{ source('oliver_landing', 'orderline')}} ol
inner join {{ source('oliver_landing', 'orders')}} o
    on ol.order_id = o.order_id
inner join {{ ref('oliver_dim_employee') }} e 
    on o.employee_id = e.employee_id
inner join {{ ref('oliver_dim_customer') }} cu 
    on o.customer_id = cu.customer_id
inner join {{ ref('oliver_dim_product') }} p 
    on ol.product_id = p.product_id
inner join {{ ref('oliver_dim_store') }} st
    on o.store_id = st.store_id
inner join {{ ref('oliver_dim_date') }} d
    on o.order_date = d.date_day