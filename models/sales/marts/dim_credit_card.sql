with
    credit_card as (
        select
            id
            , case
                when card_type is null then 'Unknown'
                else card_type
            end as card_type
            , card_number
            , exp_month
            , exp_year
        from {{ ref ('int_credit_card') }}
    )

    /* Add the surrogate key in the table credit card */
    , credit_card_with_sk as (
        select
            row_number() over (order by id) as credit_card_sk
            , *
        from credit_card
    )

select *
from credit_card_with_sk