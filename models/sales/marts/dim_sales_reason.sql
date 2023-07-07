with
    sales_reason as (
        select
            id
            , sales_order_id
            , sales_reason_name
            , case
                when reason_type is null then 'Unknown'
                else reason_type
            end as reason_type
        from {{ ref ('int_sales_reason') }}
    )

    /* Add the surrogate key in the table reason */
    , sales_reason_with_sk as (
        select
            row_number() over (order by id) as sales_reason_sk
            , *
        from sales_reason
    )

select *
from sales_reason_with_sk
