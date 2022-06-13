select 
    employeeNumber
    , lastName
    , extension
    , email
    , officeCode
    , reportsTo
    , jobTitle
from
    {{ source('raw', 'employees') }}
