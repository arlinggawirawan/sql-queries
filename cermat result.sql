
select a.*, b.due_date, b.to_be_paid_amount, b.repayment_at, b.repayment_amount, b.approved_amount, b.approved_tenor,
b.promotion_code, b.discount from
	(select loan_id, due_index, min(rn)rn from
		(select a.*, b.repayment_at, b.repayment_amount, c.approved_amount, c.approved_tenor,
		d.promotion_code, a.to_be_paid_amount-b.repayment_amount as discount,
		(case a.loan_id when @curloan then @currow:=@currow+1
		else @currow:=1 and @curloan:=a.loan_id end)rn
		from
			(select loan_id, date(due_date)due_date, due_index, sum(amount)to_be_paid_amount 
			from finance.dues
			where date(due_date) between '2020-04-21' and '2020-06-15'
			group by loan_id, date(due_date), due_index)a
		left join
			(select loan_number, due_index, date(repayment_at)repayment_at, repayment_amount 
			from finance.finance_repayment_track 
			where date(repayment_at) between '2020-04-13' and '2020-05-31')b
		on a.loan_id=b.loan_number and a.due_index=b.due_index
		left join
			(select loan_number, approved_amount, case when approved_tenor like '%D' then left(approved_tenor,2)
			when approved_tenor like '%M' then left(approved_tenor,1)*30 end as approved_tenor 
			from komodo.loans)c
		on a.loan_id=c.loan_number
		left join
			(select distinct date(created_at)created_at, 
			loan_number, promotion_code, dis_interest_fee
			from finance.loan_coupon
			where promotion_code like 'CERMAT%'
			and date(created_at) between '2020-04-13' and '2020-05-31')d
		on a.loan_id=d.loan_number
		where b.loan_number is not null and d.promotion_code is not null and a.to_be_paid_amount>b.repayment_amount
		order by a.loan_id, b.repayment_at, d.promotion_code)a
	group by loan_id, due_index)a
left join
	(select a.*, b.repayment_at, b.repayment_amount, c.approved_amount, c.approved_tenor,
	d.promotion_code, a.to_be_paid_amount-b.repayment_amount as discount,
	(case a.loan_id when @curloan then @currow:=@currow+1
	else @currow:=1 and @curloan:=a.loan_id end)rn
	from
		(select loan_id, date(due_date)due_date, due_index, sum(amount)to_be_paid_amount 
		from finance.dues
		where date(due_date) between '2020-04-21' and '2020-06-15'
		group by loan_id, date(due_date), due_index)a
	left join
		(select loan_number, due_index, date(repayment_at)repayment_at, repayment_amount 
		from finance.finance_repayment_track 
		where date(repayment_at) between '2020-04-13' and '2020-05-31')b
	on a.loan_id=b.loan_number and a.due_index=b.due_index
	left join
		(select loan_number, approved_amount, case when approved_tenor like '%D' then left(approved_tenor,2)
		when approved_tenor like '%M' then left(approved_tenor,1)*30 end as approved_tenor 
		from komodo.loans)c
	on a.loan_id=c.loan_number
	left join
		(select distinct date(created_at)created_at, 
		loan_number, promotion_code, dis_interest_fee
		from finance.loan_coupon
		where promotion_code like 'CERMAT%'
		and date(created_at) between '2020-04-13' and '2020-05-31')d
	on a.loan_id=d.loan_number
	where b.loan_number is not null and d.promotion_code is not null and a.to_be_paid_amount>b.repayment_amount
	order by a.loan_id, b.repayment_at, d.promotion_code)b
on a.loan_id=b.loan_id and a.due_index=b.due_index and a.rn=b.rn