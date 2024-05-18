SELECT a.loan_number, a.state, b.salary_method, b.salary_day, b.employment_status, b.industry, b.occupation,
date(a.created_at)created_at
FROM komodo.work_profiles b
join komodo.loans a on b.user_id = a.user_id
where date(a.created_at) >= '2020-07-16'
and salary_method is not null;