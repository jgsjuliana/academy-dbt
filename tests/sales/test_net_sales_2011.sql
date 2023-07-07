with
    selected as (
        select
            net_sales
            , order_date
        from {{ ref('fct_order_detail') }}
    )

    , net_sales_2011 as (
        select round(sum(net_sales), 2) as net_sales
        from selected
        where
            order_date
            between '2011-01-01' and '2011-12-31'
    )

select *
from net_sales_2011
where net_sales != 12641672.21