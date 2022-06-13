select
    productLine
    , textDescription
from
    {{ source('raw', 'productlines') }}