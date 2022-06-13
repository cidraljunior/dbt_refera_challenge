with 
    orders_details as (
        select 
            orderNumber
            , productCode
            , quantityOrdered
            , priceEach
            , orderLineNumber
            , quantityOrdered*orderLineNumber as costs_items
        from {{ ref('stg_orderdetails')}}
    )

    , products as (
        select
            productCode
            , productName
            , productLine
            , productVendor
            , buyPrice
        from {{ ref('dim_products')}}
    )

    , orders as (
        select
            orderNumber
            , orderDate
            , requiredDate
            , shippedDate
            , status
            , customerNumber
        from {{ ref('stg_orders')}}
    )

    , orders_items_final as (
        select 
            odd.orderNumber
            , odd.productCode
            , odd.quantityOrdered
            , odd.priceEach
            , odd.orderLineNumber
            , odd.costs_items
            , pr.productName
            , pr.productLine
            , pr.productVendor
            , pr.buyPrice
            , ord.orderDate
            , ord.requiredDate
            , ord.shippedDate
            , ord.status
            , ord.customerNumber
        from orders_details odd
        left join products pr on odd.productCode=pr.productCode
        left join orders ord on odd.orderNumber=ord.orderNumber
    )

select * from orders_items_final