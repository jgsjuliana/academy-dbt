with
    selected as (
        select
            /* Primary key */
            countryregioncode as country_region_code

            /* Other columns */
            , name as country_name
            , cast(modifieddate as timestamp) as modified_date

        from {{ source('raw_adventureworks','countryregion') }}
    )

select *
from selected