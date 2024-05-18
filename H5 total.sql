select 	@start_dt	:='2020-07-11',		
		@end_dt		:='2020-07-18';
				
select 'a. Total Register' as flag, date(created_at)data_date, count(id)count_total from user.user_info				
where origin='H5' and date(created_at)>=@start_dt group by date(created_at)				
union all				
select 'b. Total Apply' as flag, date(created_at)data_date, count(distinct loan_number)count_applied				
from komodo.loans where source_id='h5' and date(created_at)>=@start_dt group by date(created_at)				
union all				
select 'c. Total Approved' as flag, date(b.approved_at)data_date, count(a.loan_number)count_approved				
from 				
	(select loan_number from komodo.loans where product_code='YN-MAUCASH' and approved_amount is not null			
    and source_id='h5')a				
	left join			
	(select loan_number, date(created_at)approved_at from fund.fund_loans)b			
	on a.loan_number=b.loan_number			
where b.approved_at between @start_dt and @end_dt group by date(approved_at)				
union all				
select 'd. Total Disburse' as flag, date(disbursed_at)data_date, count(distinct loan_number)count_disbursed				
from komodo.loans where source_id='h5' and date(disbursed_at)>=@start_dt and disbursed_at is not null				
group by date(disbursed_at);