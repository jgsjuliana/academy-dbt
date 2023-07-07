with
    selected as (
        select
            /* Primary key */
            businessentityid as id

            /* Foreign key */
            , persontype as person_type
            , namestyle as name_style
            , title
            , firstname as first_name
            , middlename as middle_name
            , lastname as last_name
            , suffix
            , emailpromotion as email_promotion
            , additionalcontactinfo as additional_contact_info
            , demographics

            /* Other columns */
            , rowguid as row_guid
            , cast(modifieddate as timestamp) as modified_date

        from {{ source('raw_adventureworks','person') }}
    )

select *
from selected