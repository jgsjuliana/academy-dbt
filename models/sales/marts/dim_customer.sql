with
    customer as (
        select
            id
            , person_id
            , person_type
            , title
            , full_name
        from {{ ref ('int_customer') }}
    )

    /* Add the surrogate key in the table customer_join */
    , customer_with_sk as (
        select
            row_number() over (order by id) as customer_sk
            , *
        from customer
    )

select *
from customer_with_sk