with 

    employees as (
        select 
            employeeNumber
            , lastName
            , extension
            , email
            , officeCode
            , reportsTo
            , jobTitle
        from
            {{ ref('stg_employees') }}
    )

    , offices as (
        select 
            officeCode
            , city
            , phone
            , addressLine1
            , addressLine2
            , state
            , country
            , postalCode
            , territory
        from
            {{ ref('stg_offices') }}
    )

    , employee_offices as (
        select 
            emp.employeeNumber
            , emp.lastName
            , emp.extension
            , emp.email
            , emp.officeCode
            , emp.reportsTo
            , emp.jobTitle
            , of.city
            , of.phone
            , of.addressLine1
            , of.addressLine2
            , of.state
            , of.country
            , of.postalCode
            , of.territory
        from employees emp 
        left join offices of on emp.officeCode=of.officeCode 
    )

select *
from employee_offices