with
    product as (
        select
            id
            , product_name
        from {{ ref ('int_product') }}
    )

    /* Add the surrogate key in the table product */
    , product_with_sk as (
        select
            row_number() over (order by id) as product_sk
            , *
        from product
    )

select *
from product_with_sk