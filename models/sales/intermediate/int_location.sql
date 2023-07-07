with
    address as (
        select
            id
            , state_province_id
            , city
        from {{ ref ('stg_address') }}
    )

    , state_province as (
        select
            id
            , state_province_name
            , country_region_code
        from {{ ref ('stg_state_province') }}
    )

    , country_region as (
        select
            country_region_code
            , country_name
        from {{ ref ('stg_country_region') }}
    )

    /* Creating a new table joining address, state_province
    and country_region */
    , location_join as (
        select
            address.id
            , address.city
            , address.state_province_id
            , state_province.state_province_name
            , state_province.country_region_code
            , country_region.country_name
        from address
        left join state_province
            on address.state_province_id = state_province.id
        left join country_region
            on state_province.country_region_code = country_region.country_region_code
    )

    /* Add the surrogate key in the table location_join */
    , location_join_with_sk as (
        select
            row_number() over (order by id) as location_sk
            , *
        from location_join
    )

select *
from location_join_with_sk