with 
    customers as (
        select 
            customerNumber
            , customerName
            , contactLastName
            , contactFirstName
            , phone
            , addressLine1
            , addressLine2
            , city
            , state
            , postalCode
            , country
            , salesRepEmployeeNumber
            , creditLimit
        from {{ ref('stg_customers') }}
    )

select *
from customers