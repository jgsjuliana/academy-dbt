with
    selected as (
        select
            gross_sales
            , order_date
        from {{ ref('fct_order_detail') }}
    )

    , gross_sales_2011 as (
        select round(sum(gross_sales), 2) as gross_sales
        from selected
        where
            order_date
            between '2011-01-01' and '2011-12-31'
    )

select *
from gross_sales_2011
where gross_sales != 12646112.16