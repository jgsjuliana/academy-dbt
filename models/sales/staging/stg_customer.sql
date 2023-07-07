with
    selected as (
        select
            /* Primary key */
            customerid as id

            /* Foreign key */
            , personid as person_id
            , storeid as store_id
            , territoryid as territory_id

            /* Other columns */
            , rowguid as row_guid
            , cast(modifieddate as timestamp) as modified_date

        from {{ source('raw_adventureworks','customer') }}
    )

select *
from selected