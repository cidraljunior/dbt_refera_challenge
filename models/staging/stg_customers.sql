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
from
    {{ source('raw', 'customers') }}
