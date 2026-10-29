with source as (
    select * from DBT_CLOUD.RAW_SCHEMA.PRODUCTS
),

renamed as (
    select
        product_id,
        product_name,
        category as product_category,
        price as unit_price,
        stock_quantity,
        created_at as created_at_utc
    from source
)

select * from renamed
