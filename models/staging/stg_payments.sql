select 
    customerNumber
    , checkNumber
    , paymentDate
    , amount
from
    {{ source('raw', 'payments') }}