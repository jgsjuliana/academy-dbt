with
    selected as (
        select
            /* Foreign key */
            salesreasonid as id

            /* Other columns */
            , name as sales_reason_name
            , reasontype as reason_type
            , cast(modifieddate as timestamp) as modified_date

        from {{ source('raw_adventureworks','salesreason') }}
    )

select *
from selected