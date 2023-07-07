with
    selected as (
        select
            /* Primary key */
            addressid as id

            /* Foreign key */
            , stateprovinceid as state_province_id

            /* Other columns */
            , addressline1 as address_1
            , addressline2 as address_2
            , city
            , postalcode as postal_code
            , spatiallocation as spatial_location
            , rowguid as row_guid
            , cast(modifieddate as timestamp) as modified_date

        from {{ source('raw_adventureworks','address') }}
    )

select *
from selected