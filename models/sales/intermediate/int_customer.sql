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
            , case
                when person.middle_name is not null
                    then concat(person.first_name, ' ', person.middle_name, ' ', person.last_name)
                else concat(person.first_name, ' ', person.last_name)
            end as full_name
        from customer
        left join person
            on customer.person_id = person.id
    )

select *
from customer_join