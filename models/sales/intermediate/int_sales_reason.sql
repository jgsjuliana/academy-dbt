with
    sales_reason as (
        select
            id
            , sales_reason_name
            , reason_type
        from {{ ref ('stg_sales_reason') }}
    )

    , sales_order_header_sales_reason as (
        select
            sales_reason_id
            , sales_order_id
        from {{ ref ('stg_sales_order_header_sales_reason') }}
    )

    /* Creating a new table joining sales_reason with
    sales_order_header_sales_reason */
    , sales_reason_join as (
        select
            sales_order_header_sales_reason.sales_reason_id as id
            , sales_order_header_sales_reason.sales_order_id
            , sales_reason.sales_reason_name
            , sales_reason.reason_type
        from sales_order_header_sales_reason
        left join sales_reason
            on sales_order_header_sales_reason.sales_reason_id = sales_reason.id
    )

select *
from sales_reason_join