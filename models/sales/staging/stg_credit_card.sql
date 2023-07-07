with
    selected as (
        select
            /* Primary key */
            creditcardid as id

            /* Other columns */
            , cardtype as card_type
            , cardnumber as card_number
            , expmonth as exp_month
            , expyear as exp_year
            , cast(modifieddate as timestamp) as modified_date

        from {{ source('raw_adventureworks','creditcard') }}
    )

select *
from selected