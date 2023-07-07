with
    selected as (
        select
            /* Primary key */
            salesorderdetailid as id

            /* Foreign key */
            , salesorderid as sales_order_id
            , productid as product_id
            , specialofferid as special_offer_id

            /* Other columns */
            , carriertrackingnumber as carrier_tracking_number
            , orderqty as order_qty
            , unitprice as unit_price
            , unitpricediscount as unit_price_discount
            , rowguid as row_guid
            , cast(modifieddate as timestamp) as modified_date

        from {{ source('raw_adventureworks','salesorderdetail') }}
    )

    , transformed as (
        select
            row_number() over (order by id) as salesorderdetail_sk
            , *
        from selected
    )

select *
from transformed