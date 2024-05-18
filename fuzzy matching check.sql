SELECT c.loan_number, c.user_id, c.state, c.created_at, a.TYPE, a.value1, a.value2, a.score, a.created_at, b.is_used,
b.bank_name
FROM finance.levenshtein_score a
join komodo.loans c on  a.user_id = c.user_id
join finance.finance_user_bankcard b on b.user_id = c.user_id 
WHERE a.created_at >= '2020-07-16';