with 

    products_erp as (
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
            {{ ref('stg_products') }}
    )

    , products_lines as (
        select
            productLine
            , textDescription
        from 
            {{ ref('stg_productlines') }}
    )

    , products_final as (
        select 
            pr.productCode
            , pr.productName
            , pr.productLine
            , pr.productVendor
            , pr.productDescription
            , pr.quantityInStock
            , pr.buyPrice
            , pr.MSRP
            , pl.textDescription
        from products_erp pr 
        left join products_lines as pl on pr.productLine=pl.productLine
    )

select *
from products_final 