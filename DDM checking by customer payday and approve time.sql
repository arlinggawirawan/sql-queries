SELECT l.user_id, l.loan_number, l.amount, l.tenor, l.state, 
l.approved_at, l.disbursed_at, l.approved_amount, l.approved_tenor, 
CASE 
	WHEN wp.salary_method = '13' THEN 'Bulanan'
    WHEN wp.salary_method = '12' THEN 'Dua Kali Sebulan'
    WHEN wp.salary_method = '11' THEN 'Mingguan'
    WHEN wp.salary_method = '10' THEN 'Harian'
    END AS salary_method
, wp.salary_day
FROM komodo.loans l
left join
komodo.work_profiles wp on l.user_id = wp.user_id
where l.approved_at >= '2020-08-31 14:00:00'
and l.disbursed_at is not null
and wp.salary_method is not null