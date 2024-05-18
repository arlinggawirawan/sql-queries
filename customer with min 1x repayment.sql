select a.*, c.name, c.genders as gender, c.mobile, c.email, 		
case when b.dpd_max is null then 0 else b.dpd_max end as dpd_max,		
case when b.dpd_max is null or b.dpd_max=0 then 'a. Ever 0 DPD'		
when b.dpd_max between 1 and 7 then 'b. Ever 1-7 DPD'		
when b.dpd_max between 8 and 10 then 'c. Ever 8-10 DPD'		
when b.dpd_max>10 then 'd. Ever >10 DPD' end as dpd_flag, e.max_repay,		
case when e.max_repay=1 then 'a. 1x Repayment'		
when e.max_repay=2 then 'b. 2x Repayment'		
when e.max_repay=3 then 'c. 3x Repayment'		
when e.max_repay=4 then 'd. 4x Repayment'		
when e.max_repay=5 then 'e. 5x Repayment'		
when e.max_repay>5 then 'f. > 5x Repayment' end as max_repay_flag,		
f.state as latest_status, f.applied_at as latest_applied_date,		
case when g.occupation in 		
('Pekerja Lepas',		
'Pemilik Usaha',		
'Profesi',		
'Jurnalis / Wartawan',		
'Ojek Motor',		
'Pedagang',		
'Seniman',		
'Sopir',		
'Hotel',		
'Jasa',		
'Lain-Lain',		
'Dokter/Bidan/Mantri',		
'Produksi',		
'Pelayaran/Pelaut',		
'Guru/Pendidikan',		
'ABRI',		
'Ibu Rumah Tangga',		
'Transportasi & Komunikasi',		
'Pengrajin Tangan',		
'Pelajar/Mahasiswa') then 'Non-Fixed Income' else 'Fixed Income' end as income_type, 		
h.reject_reason, i.count_reject, j.register_date, 'Whitelist' as whitelist_flag		
from		
	(select user_id, count(loan_number)total_disburse, max(date(disbursed_at))latest_disburse	
	from komodo.loans	
	where product_code='yn-maucash'	
	and date(disbursed_at) between '2018-09-05' and '2020-10-08'	
	group by user_id)a	
left join		
	(select c.user_id, max(a.dpd)dpd_max from	
		(select distinct user_id, loan_number 
		from komodo.loans 
		where product_code='YN-MAUCASH'
		and date(applied_at)>='2018-09-05')c
	left join	
		(select loan_number, due_index, count(loan_number)dpd 
		from finance.overdue
		group by loan_number, due_index)a
	on c.loan_number=a.loan_number	
	group by c.user_id)b	
on a.user_id=b.user_id		
left join		
	(select a.*, case when gender=1 then 'Pria' else 'Wanita' end as genders 	
    from komodo.user_profiles a)c		
on a.user_id=c.user_id		
left join		
	(select distinct a.user_id from	
		(select user_id, loan_number from komodo.loans 
		where product_code='yn-maucash'
		and date(disbursed_at) between '2018-09-05' and '2020-10-08')a
	left join	
		(select loan_number, due_index from finance.finance_repayment_track where due_index in (1))b
	on a.loan_number=b.loan_number 	
	left join	
		(select loan_id, due_index 
		from finance.finance_dues 
		where due_index in (1) 
		and principal_amount=principal_pay)bb
	on b.loan_number=bb.loan_id and b.due_index=bb.due_index	
    where b.loan_number is not null and bb.loan_id is not null)d	
on a.user_id=d.user_id		
left join		
	(select user_id, max(due_index)max_repay 	
    from finance.finance_repayment_track		
    group by user_id)e		
on a.user_id=e.user_id		
left join		
	(select zz.user_id,zz.applied_at, xx.state from	
		(select user_id, max(applied_at)applied_at from komodo.loans where product_code='yn-maucash' group by user_id)zz
	left join	
		(select user_id, applied_at, loan_number, state from komodo.loans where product_code='yn-maucash')xx
	on zz.user_id=xx.user_id and zz.applied_at=xx.applied_at	
	where xx.user_id is not null)f	
on a.user_id=f.user_id		
left join		
	(select cc.user_id, vv.value as occupation from	
		(select user_id, occupation from komodo.work_profiles)cc
	left join	
		(select * from komodo.configs where category='occupation')vv
	on cc.occupation=vv.key)g	
on a.user_id=g.user_id		
left join		
	(select bb.user_id, nn.not_approved_desc as reject_reason from	
		(select user_id, max(rejected_at)rejected_at from komodo.loans where product_code='yn-maucash' group by user_id)bb
	left join	
		(select user_id, rejected_at, not_approved_desc from komodo.loans where product_code='yn-maucash')nn
	on bb.user_id=nn.user_id and bb.rejected_at=nn.rejected_at	
	where bb.user_id is not null)h	
on a.user_id=h.user_id		
left join		
	(select user_id, count(loan_number)count_reject from komodo.loans where product_code='yn-maucash' and state='rejected' group by user_id)i	
on a.user_id=i.user_id		
left join		
	(select id, date(created_at)register_date	
	from user.user_info	
	where product_code = 'YN-MAUCASH')j	
on a.user_id=j.id		
where d.user_id is not null		
-- and b.dpd_max<=10		
-- and 		
-- (-- f.state<>'rejected' 		
-- -- and 		
-- (h.reject_reason in 		
-- ('> DBR or IIR',		
-- 'AutoReject - Number of Query By Lending Platforms > 10/n',		
-- 'AutoReject - Number of Query By Lending Platforms > 13/n',		
-- 'AutoReject - Number of Query By Lending Platforms > 3/n',		
-- 'AutoReject - Number of Query By Lending Platforms > 5/n',		
-- 'AutoReject - Number of Query By Lending Platforms > 8/n',		
-- 'Capacity - Credit Shopper',		
-- 'Capacity - Fintech Apps Installed',		
-- 'Capacity - Heavy Debt Burden',		
-- 'Company - failed verification',		
-- 'Company - uncontact verification',		
-- 'Emergency - Failed verification',		
-- 'Emergency - Uncontact verification',		
-- 'Employment - Failed verification',		
-- 'Employment - Uncontact verification',		
-- 'GPS Location work address',		
-- 'Number of Query By Lending Platforms > 13',		
-- 'Number of Query By Lending Platforms > 3',		
-- 'Number of Query By Lending Platforms > 5',		
-- 'Uncomplete Document') or h.reject_reason is null)		
-- )		
