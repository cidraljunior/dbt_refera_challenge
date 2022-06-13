with 
    payments as (
        select 
            customerNumber
            , checkNumber
            , paymentDate
            , amount
        from {{ ref('stg_payments')}}
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

    , grouped_orders_details as (
        select 
            orderNumber
            , sum(quantityOrdered) as total_quantity_items
            , sum(quantityOrdered*orderLineNumber) as total_costs
        from {{ ref('stg_orderdetails')}}
        group by 
            orderNumber
    )

    , orders_unified as (
        select
            ord.orderNumber
            , ord.orderDate
            , ord.requiredDate
            , ord.shippedDate
            , ord.status
            , ord.customerNumber
            , god.total_quantity_items
            , god.total_costs 
        from orders ord
        left join grouped_orders_details god on ord.orderNumber=god.orderNumber
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

    , payments_final as (
        select 
            py.customerNumber
            , py.checkNumber
            , py.paymentDate
            , py.amount
            , ordu.orderNumber
            , ordu.orderDate
            , ordu.requiredDate
            , ordu.shippedDate
            , ordu.status
            , ordu.total_quantity_items
            , ordu.total_costs
            , cs.customerName
            , cs.phone
            , cs.city
            , cs.state
            , cs.postalCode
            , cs.country
            , cs.salesRepEmployeeNumber
            , cs.creditLimit
        from payments py
        left join orders_unified ordu 
        on py.customerNumber=ordu.customerNumber
        and py.amount=ordu.total_costs
        left join customers cs on cs.customerNumber=cs.customerNumber
    )

select * from payments_final