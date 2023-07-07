with
    product as (
        select
            id
            , product_name
        from {{ ref ('stg_product') }}
    )

select *
from product