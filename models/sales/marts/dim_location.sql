with
    location as (
        select
            id
            , city
            , state_province_id
            , state_province_name
            , country_region_code
            , country_name
        from {{ ref ('int_location') }}
    )

    /* Add the surrogate key in the table location_join */
    , location_with_sk as (
        select
            row_number() over (order by id) as location_sk
            , *
        from location
    )

select *
from location_with_sk