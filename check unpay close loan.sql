SELECT fd.loan_id, fd.due_index, fd.due_date, 
	CASE 
		WHEN fd.is_close = '1' THEN 'Close'
		END AS Settlement
, fd.principal_amount, fd.principal_pay, fd.principal_unpay,fr.actual_repayment_at
FROM finance.finance_dues fd
left JOIN finance.finance_repayment_track fr on fd.loan_id = fr.loan_number
where fd.is_close = '1'
and fd.principal_unpay > '0'
and fr.actual_repayment_at is not null