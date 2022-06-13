select 
    orderNumber
    , orderDate
    , requiredDate
    , shippedDate
    , status
    , comments
    , customerNumber
from
    {{ source('raw', 'orders') }}