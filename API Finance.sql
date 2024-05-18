SELECT t.loan_number, t.order_id, t.amount, t.`status` , ld.second_prod_code, type
FROM finance_trading t , loan_detail ld 
WHERE t.created_at > '2020-08-13' 
and t.loan_number = ld.loan_number
-- and ld.second_prod_code != 'lite_maucash_short'
AND t.created_at < '2020-08-18' 
-- AND t.type = 1 
AND t.`status` = 1;