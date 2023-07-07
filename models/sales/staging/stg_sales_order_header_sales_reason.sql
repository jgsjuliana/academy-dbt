with
    selected as (
        select
            /* Foreign key */
            salesreasonid as sales_reason_id
            , salesorderid as sales_order_id

            /* Other columns */
            , cast(modifieddate as timestamp) as modified_date

        from {{ source('raw_adventureworks','salesorderheadersalesreason') }}
    )

select *
from selected