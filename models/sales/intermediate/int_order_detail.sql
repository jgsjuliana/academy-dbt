with
    sales_order_detail as (
        select
            id
            , sales_order_id
            , product_id
            , order_qty
            , unit_price
            , unit_price_discount
        from {{ ref ('stg_sales_order_detail') }}
    )

    , sales_order_header as (
        select
            id
            , customer_id
            , sales_person_id
            , bill_to_address_id
            , ship_to_address_id
            , credit_card_id
            , order_date
            , due_date
            , ship_date
            , status
            , subtotal
            , tax_amt
            , freight
            , total_due
        from {{ ref ('stg_sales_order_header') }}
    )

    /* Creating a new table joining sales_order_detail with
    sales_order_header. */
    , order_header_detail_join as (
        select
            sales_order_detail.id
            , sales_order_detail.sales_order_id
            , sales_order_detail.product_id
            , sales_order_header.customer_id
            , sales_order_header.sales_person_id
            , sales_order_header.bill_to_address_id
            , sales_order_header.ship_to_address_id
            , sales_order_header.credit_card_id
            , sales_order_detail.order_qty
            , sales_order_detail.unit_price
            , sales_order_detail.unit_price_discount
            , sales_order_header.order_date
            , sales_order_header.due_date
            , sales_order_header.ship_date
            , sales_order_header.status
            , sales_order_header.subtotal
            , sales_order_header.tax_amt
            , sales_order_header.freight
            , sales_order_header.total_due
        from sales_order_detail
        left join sales_order_header
            on sales_order_detail.sales_order_id = sales_order_header.id
    )

    /* Creating a business rule to obtain
    the gross total and net total for each order_detail_id*/
    , business_rule as (
        select
            *
            , order_qty * unit_price as gross_sales
            , order_qty * unit_price * (1 - unit_price_discount) as net_sales
        from order_header_detail_join
    )

select *
from business_rule