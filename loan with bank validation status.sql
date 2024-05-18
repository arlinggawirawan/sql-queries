SELECT distinct l.user_id, l.loan_number, l.state, fub.user_name, fub.bank_account_number, fub.bank_account_holder_name,
fub.bank_name,
	CASE
		WHEN fub.is_used = '0' THEN	'Unavailable'
        WHEN fub.is_used = '1' THEN	'Failed'
        WHEN fub.is_used = '2' THEN	'Success'
	END as check_bank
, fub.bank_name, ls.score,
l.applied_at, l.updated_at, l.product_code, l.second_prod_code 
FROM komodo.loans l
INNER JOIN finance.finance_user_bankcard fub on l.user_id	= fub.user_id
INNER JOIN finance.levenshtein_score ls on l.user_id = ls.user_id
WHERE l.applied_at >= '2020-07-16 00:00:00';
