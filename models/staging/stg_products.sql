select 
    productCode
    , productName
    , productLine
    , productVendor
    , productDescription
    , quantityInStock
    , buyPrice
    , MSRP
from
    {{ source('raw', 'products') }}