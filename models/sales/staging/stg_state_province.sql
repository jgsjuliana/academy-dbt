with
    selected as (
        select
            /* Primary key */
            stateprovinceid as id

            /* Foreign key */
            , territoryid as territory_id
            , countryregioncode as country_region_code

            /* Other columns */
            , name as state_province_name
            , stateprovincecode as state_province_code
            , isonlystateprovinceflag as is_only_state_province_flag
            , rowguid as row_guid
            , cast(modifieddate as timestamp) as modified_date

        from {{ source('raw_adventureworks','stateprovince') }}
    )

select *
from selected