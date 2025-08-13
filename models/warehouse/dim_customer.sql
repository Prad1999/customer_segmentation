select
    customer_id,
    first_name,
    last_name,
    email,
    gender,
    age,
    country,
    signup_date
from {{ ref('stg_customers') }}
