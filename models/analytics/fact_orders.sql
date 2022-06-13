with 

    orders as (
        select
            orderNumber
            , orderDate
            , requiredDate
            , shippedDate
            , status
            , customerNumber
        from {{ ref('stg_orders')}}
    )

    , grouped_orders_details as (
        select 
            orderNumber
            , sum(quantityOrdered) as total_quantity_items
            , sum(quantityOrdered*orderLineNumber) as total_costs
        from {{ ref('stg_orderdetails')}}
        group by 
            orderNumber
    )

    , customers as (
        select 
            customerNumber
            , customerName
            , phone
            , city
            , state
            , postalCode
            , country
            , salesRepEmployeeNumber
            , creditLimit
        from {{ ref('dim_customers')}}
    )

    , orders_final as (
        select 
            ord.orderNumber
            , ord.orderDate
            , ord.requiredDate
            , ord.shippedDate
            , ord.status
            , ord.customerNumber
            , god.total_quantity_items
            , god.total_costs
            , cs.customerName
            , cs.phone
            , cs.city
            , cs.state
            , cs.postalCode
            , cs.country
            , cs.salesRepEmployeeNumber
            , cs.creditLimit
        from orders ord
        left join grouped_orders_details god on ord.orderNumber=god.orderNumber
        left join customers cs on cs.customerNumber=cs.customerNumber
    )

select * from orders_final