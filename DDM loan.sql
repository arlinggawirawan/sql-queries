select a.*,														
case when a.second_prod_code like '%astra%' then 'Astra'														
when a.second_prod_code like '%sigap%' then 'Sigap'														
else 'Non Astra' end as astra_flag,														
case when c.nik is not null and a.applied_date>c.min_disbursed then 'RO'														
when c.nik is not null and a.applied_date<=c.min_disbursed then 'New'														
when c.nik is null then 'New' end as RO_flag,														
case when a.second_prod_code in ('maucash_short','maucash_short_v2','old_user_maucash_short','old_user_maucash_short_v2',														
'astra_maucash_short','astra_maucash_short_v2','old_astra_maucash_short','old_astra_maucash_short_v2','lite_maucash_short',														
'lite_maucash_short_v2') then 'Maucepat'														
when a.second_prod_code in ('maucash_long','maucash_long_v2','old_user_maucash_long','old_user_maucash_long_v2',														
'astra_maucash_long','astra_maucash_long_v2','old_astra_maucash_long','old_astra_maucash_long_v2') then 'Mauringan'														
when a.second_prod_code like '%sigap%' then 'Sigap' end as product_flag,														
fdu.total_outstanding, ui.registered_date, wps.salary_date, wps.salary_method, wps.occupation, 														
wps.employment_status, wps.industry, fd.max_due_date, case when fo.dpd_max is null then 0 else fo.dpd_max end as dpd_max, fl.approved_date														
from														
	(select user_id, loan_number, second_prod_code, state, approved_amount, 													
	case when approved_tenor like '%D' then cast(tenor as unsigned)													
	when approved_tenor like '%M' then cast(tenor as unsigned)*30 end as approved_tenor,													
	date(applied_at)applied_date, date(disbursed_at)disbursed_date													
	from komodo.loans													
	where product_code='yn-maucash'													
	-- and date(disbursed_at) between '2020-08-31' and '2020-10-12'													
    )a														
left join														
	(select user_id, nik 													
	from komodo.user_profiles 													
	where date(created_at)>='2018-09-05')b													
on a.user_id=b.user_id														
left join														
	(select nik, date(min_disbursed)min_disbursed from													
		(select a.nik, min(c.min_disbursed)min_disbursed, count(b.loan_number)count_loan from												
			(select nik, user_id 											
			from komodo.user_profiles 											
			where date(created_at)>='2018-09-05')a											
		left join												
			(select distinct user_id, loan_number from komodo.loans											
			where product_code='yn-maucash'											
			and date(applied_at)>='2018-09-05'											
			and disbursed_at is not null)b											
		on a.user_id=b.user_id												
		left join												
			(select user_id, min(disbursed_at)min_disbursed from komodo.loans											
			where product_code='yn-maucash'											
			and date(applied_at)>='2018-09-05'											
			and disbursed_at is not null											
			group by user_id)c											
		on a.user_id=c.user_id												
		group by nik)d												
	where count_loan>=1)c													
on b.nik=c.nik														
left join														
	(select loan_id,													
	sum(principal_amount)+sum(admin_fee_amount)+sum(fund_interest_amount)+sum(service_fee_amount) 													
	as amount,													
	sum(principal_pay)+sum(admin_fee_pay)+sum(fund_interest_pay)+sum(service_fee_pay) 													
	as amount_paid, 													
	sum(principal_unpay)+sum(admin_fee_unpay)+sum(fund_interest_unpay)+sum(service_fee_unpay) as total_outstanding,													
	sum(principal_unpay)principal_outstanding,sum(admin_fee_unpay)admin_fee_outstanding,													
	sum(fund_interest_unpay)fund_interest_outstanding,sum(service_fee_unpay)service_fee_outstanding													
	from finance.finance_dues													
	group by loan_id)fdu													
on a.loan_number=fdu.loan_id														
left join														
	(select id, date(created_at)registered_date													
	from user.user_info ui													
	where ui.product_code = 'YN-MAUCASH')ui													
on a.user_id=ui.id														
left join														
	(select wp.user_id, wp.salary_day as salary_date, kc.value as salary_method, kc2.value as occupation, 													
    kc3.value as employment_status, kc4.value as industry														
    from														
		(select user_id, salary_method, salary_day, occupation, employment_status, industry												
		from komodo.work_profiles)wp												
	left join													
		(select a.key, a.value from komodo.configs a where category like '%salary_method%')kc												
	on wp.salary_method=kc.key													
    left join														
		(select a.key, a.value from komodo.configs a where category='occupation')kc2												
	on wp.occupation=kc2.key													
    left join														
		(select a.key, a.value from komodo.configs a where category='work')kc3												
	on wp.employment_status=kc3.key													
    left join														
		(select a.key, a.value from komodo.configs a where category='industry')kc4												
	on wp.industry=kc4.key)wps													
on a.user_id=wps.user_id														
left join														
	(select loan_id, max(date(due_date))max_due_date													
	from finance.dues													
	group by loan_id)fd													
on a.loan_number=fd.loan_id														
left join														
	(select loan_number, max(dpd)dpd_max													
    from														
		(select loan_number, due_index, count(loan_number)dpd 												
		from finance.overdue												
		group by loan_number, due_index)a												
    group by loan_number)fo														
on a.loan_number=fo.loan_number														
left join														
	(select loan_number, date(created_at)approved_date from fund.fund_loans)fl													
on a.loan_number=fl.loan_number														
where fl.approved_date between '2020-08-31' and '2020-10-11'														
