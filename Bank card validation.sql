Select user_id, user_name, bank_account_number, bank_code, bank_account_holder_name, is_used, bank_name,
date(create_at)create_at, update_at
from finance.finance_user_bankcard
where date(create_at) between '2020-04-01' and '2020-04-30';