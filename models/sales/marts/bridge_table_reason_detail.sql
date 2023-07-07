with
    sales_reason as (
        select
            sales_reason_sk
            , sales_order_id
        from {{ ref ('dim_sales_reason') }}
    )

    , order_detail as (
        select
            id
            , sales_order_id
        from {{ ref ('int_order_detail') }}
    )

    , bridge_table as (
        select
            sales_reason.sales_reason_sk as sales_reason_fk
            , order_detail.id
            , order_detail.sales_order_id
        from sales_reason
        left join order_detail
            on sales_reason.sales_order_id = order_detail.sales_order_id
    )

select *
from bridge_table