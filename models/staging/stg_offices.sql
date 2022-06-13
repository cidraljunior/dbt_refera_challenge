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
    {{ source('raw', 'offices') }}