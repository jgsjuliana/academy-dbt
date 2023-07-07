with
    selected as (
        select
            /* Primary key */
            salesorderid as id

            /* Foreign key */
            , customerid as customer_id
            , salespersonid as sales_person_id
            , territoryid as territory_id
            , billtoaddressid as bill_to_address_id
            , shiptoaddressid as ship_to_address_id
            , shipmethodid as ship_method_id
            , creditcardid as credit_card_id
            , currencyrateid as currency_rate_id

            /* Other columns */
            , revisionnumber
            , cast(orderdate as timestamp) as order_date
            , cast(duedate as timestamp) as due_date
            , cast(shipdate as timestamp) as ship_date
            , status
            , onlineorderflag as is_online_order
            , purchaseordernumber as purchase_order_number
            , accountnumber as account_number
            , creditcardapprovalcode as credit_card_approval_code
            , subtotal
            , taxamt as tax_amt
            , freight
            , totaldue as total_due
            , comment
            , rowguid as row_guid
            , cast(modifieddate as timestamp) as modified_date

        from {{ source('raw_adventureworks','salesorderheader') }}
    )

select *
from selected