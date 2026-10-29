with source_orders as (
    select * from DBT_CLOUD.RAW_SCHEMA.ORDERS
),

customers as (
    select * from DBT_CLOUD.RAW_SCHEMA.CUSTOMERS
),

products as (
    select * from DBT_CLOUD.RAW_SCHEMA.PRODUCTS
),

final as (
    select
        o.order_id,
        o.order_date,
        lower(o.status) as order_status, 
        
        -- Customer attributes
        o.customer_id,
        c.first_name || ' ' || c.last_name as customer_name,
        c.email as customer_email,
        
        -- Product attributes
        o.product_id,
        p.product_name,
        -- Changed from p.product_category to p.category to match the staging schema
        p.category as product_category,
        -- Changed from p.unit_price to p.price to match the staging schema
        p.price as unit_price,
        
        -- Metrics
        o.quantity,
        o.total_amount,
        
        -- Derived flags
        case 
            when lower(o.status) = 'delivered' then true 
            else false 
        end as is_completed_order

    from source_orders o
    left join customers c on o.customer_id = c.customer_id
    left join products p on o.product_id = p.product_id
)

select * from final
