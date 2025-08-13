with customer_stats as (

    select
        c.customer_id,
        c.first_name,
        c.last_name,
        c.email,
        c.gender,
        c.age,
        c.country,
        count(t.transaction_id) as purchase_count,
        sum(t.total_amount) as total_spent,
        count(distinct t.product_id) as unique_products
    from {{ ref('dim_customer') }} c
    left join {{ ref('fct_transactions') }} t
        on c.customer_id = t.customer_id
    group by 
        c.customer_id, c.first_name, c.last_name, c.email, c.gender, c.age, c.country

),

customer_segments as (

    select
        customer_id,
        first_name,
        last_name,
        email,
        gender,
        age,
        country,
        total_spent,
        purchase_count,
        unique_products,

        -- Total Spending
        case 
            when total_spent >= 1000 then 'High'
            when total_spent >= 500 then 'Medium'
            else 'Low'
        end as spending_segment,

        -- Purchase Frequency
        case
            when purchase_count >= 20 then 'Frequent'
            when purchase_count >= 5 then 'Occasional'
            else 'Rare'
        end as frequency_segment,

        -- Product Diversity
        case
            when unique_products >= 10 then 'Diverse'
            else 'Focused'
        end as diversity_segment

    from customer_stats

)

select * from customer_segments
