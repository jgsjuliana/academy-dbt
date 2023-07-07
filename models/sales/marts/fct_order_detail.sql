with
    credit_card as (
        select
            credit_card_sk
            , id
        from {{ ref ('dim_credit_card') }}
    )

    , customer as (
        select
            customer_sk
            , id
            , person_id
        from {{ ref ('dim_customer') }}
    )

    , location as (
        select
            location_sk
            , id
            , state_province_id
            , country_region_code
        from {{ ref ('dim_location') }}
    )

    , product as (
        select
            product_sk
            , id
        from {{ ref ('dim_product') }}
    )

    /* Creating a new table joining sales_order_detail with
    sales_order_header */
    , orders_with_fk as (
        select
            /* Primary Key */
            order_detail.id

            /* Foreign Key */
            , credit_card.credit_card_sk as credit_card_fk
            , customer.customer_sk as customer_fk
            , location.location_sk as location_fk
            , product.product_sk as product_fk

            , order_detail.sales_order_id
            , order_detail.ship_to_address_id
            , order_detail.order_qty
            , order_detail.unit_price
            , order_detail.unit_price_discount
            , order_detail.gross_sales
            , order_detail.net_sales
            , order_detail.order_date
            , order_detail.due_date
            , order_detail.ship_date
            , case
                when order_detail.status = 1 then 'Pending'
                when order_detail.status = 2 then 'In Progress'
                when order_detail.status = 3 then 'Shipped'
                when order_detail.status = 4 then 'Cancelled'
                when order_detail.status = 5 then 'Delivered'
                when order_detail.status = 6 then 'Returned'
                else 'Unknown'
            end as status
            , order_detail.subtotal
            , order_detail.tax_amt
            , order_detail.freight
            , order_detail.total_due
        from {{ ref ('int_order_detail') }} as order_detail
        left join credit_card
            on order_detail.credit_card_id = credit_card.id
        left join customer
            on order_detail.customer_id = customer.id
        left join location
            on order_detail.bill_to_address_id = location.id
        left join product
            on order_detail.product_id = product.id
    )

select *
from orders_with_fk