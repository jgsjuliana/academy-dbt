with
    selected as (
        select
            /* Primary key */
            productid as id

            /* Foreign key */
            , productsubcategoryid as product_subcategory_id
            , productmodelid as product_model_id

            /* Other columns */
            , name as product_name
            , productnumber as product_number
            , makeflag as is_make_flag
            , finishedgoodsflag as is_finished_goods_flag
            , color
            , safetystocklevel as safety_stock_level
            , reorderpoint as reorder_point
            , standardcost as standard_cost
            , listprice as list_price
            , size
            , sizeunitmeasurecode as size_unit_measure_code
            , weightunitmeasurecode as weight_unit_measure_code
            , weight
            , daystomanufacture as days_to_manufacture
            , productline as product_line
            , class
            , style
            , cast(sellstartdate as timestamp) as sell_start_date
            , cast(sellenddate as timestamp) as sell_end_date
            , discontinueddate
            , rowguid as row_guid
            , cast(modifieddate as timestamp) as modified_date

        from {{ source('raw_adventureworks','product') }}
    )

select *
from selected