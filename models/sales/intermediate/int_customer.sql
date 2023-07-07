with
    person as (
        select
            id
            , person_type
            , title
            , first_name
            , middle_name
            , last_name
        from {{ ref ('stg_person') }}
    )

    , customer as (
        select
            id
            , person_id
        from {{ ref ('stg_customer') }}
    )

    /* Creating a new table joining customer and person information */
    , customer_join as (
        select
            customer.id
            , customer.person_id
            , person.person_type
            , person.title
            , concat(person.first_name, ' ', person.middle_name, ' ', person.last_name) as full_name
        from customer
        left join person
            on customer.person_id = person.id
    )

select *
from customer_join