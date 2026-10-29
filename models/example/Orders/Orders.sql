with source as (
    select * from DBT_CLOUD.RAW_SCHEMA.ORDERS
),

renamed as (
    select
        order_id,
        customer_id,
        product_id,
        quantity,
        total_amount,
        -- Make sure this alias is exactly 'order_date_utc'
        order_date as order_date_utc,
        lower(status) as order_status
    from source
)

select * from renamed
