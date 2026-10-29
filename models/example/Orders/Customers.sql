with source as (
    select * from DBT_CLOUD.RAW_SCHEMA.CUSTOMERS
),

renamed as (
    select
        customer_id,
        first_name,
        last_name,
        -- standardising naming fields
        first_name || ' ' || last_name as customer_name,
        email,
        phone,
        created_at as created_at_utc
    from source
)

select * from renamed
