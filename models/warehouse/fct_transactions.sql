select
    t.transaction_id,
    t.customer_id,
    t.product_id,
    t.quantity,
    t.quantity * p.price_gbp as total_amount,
    t.transaction_date
from {{ ref('stg_transactions') }} t
join {{ ref('stg_products') }} p
    on t.product_id = p.product_id
