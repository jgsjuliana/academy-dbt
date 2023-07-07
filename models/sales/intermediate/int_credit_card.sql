with
    credit_card as (
        select
            id
            , card_type
            , card_number
            , exp_month
            , exp_year
        from {{ ref ('stg_credit_card') }}
    )

select *
from credit_card