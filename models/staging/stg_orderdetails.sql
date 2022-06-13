select 
    orderNumber
    , productCode
    , quantityOrdered
    , priceEach
    , orderLineNumber
from
    {{ source('raw', 'orderdetails') }}