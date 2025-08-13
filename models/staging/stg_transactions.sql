select
  id as transaction_id,
  customer_id,
  product_id,
  quantity,
  transaction_date
from {{ source('public', 'transactions') }}
