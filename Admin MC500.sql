SELECT t.loan_number, t.period, t.admin_rate, t.second_prod_code, t.admin_fee,
date(approved_at)approved_at, ld.due_date
FROM finance.loan_detail t, finance.finance_dues ld
where second_prod_code = 'lite_maucash_short'
and admin_rate = '0.240000'
and period ='25D'
and t.loan_number = ld.loan_id
union
SELECT t.loan_number, t.period, t.admin_rate, t.second_prod_code, t.admin_fee,
date(approved_at)approved_at, ld.due_date
FROM finance.loan_detail t, finance.finance_dues ld
where second_prod_code = 'lite_maucash_short'
and admin_rate = '0.200000'
and period ='30D'
and t.loan_number = ld.loan_id;