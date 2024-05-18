				
select 	@start_dt	:='2020-08-01',		
		@end_dt		:='2020-09-10';
				
select 				
a.user_id, f.name, f.mobile, f.email, f.gender, d.monthly_salary, e.education, c.age_group, 				
a.created_date register_date, a.province from				
	(select ui.id as user_id, date(ui.created_at)created_date, 			
	if(up.user_id is not null, '1','0') as personal_info, 			
	if(wp.user_id is not null, '1', '0') as employment_info, 			
	if(e.user_id is not null, '1','0') as emergency_contact, 			
	if(fi.user_id is not null, '1', '0') as identity_verify, 			
	if(alo.user_id is not null, '1','0') as wedefend_auth, 			
	if(fub.user_id is not null, '1','0') as bank_card_info,			
    if(x.user_id is not null, '1','0') as applied,				
	if(y.user_id is not null, '1','0') as approved,			
    if(z.user_id is not null, '1','0') as disbursed,				
    if(nad.user_id is not null, '1','0') as out_of_coverage,				
    upa.province				
	from (			
		select distinct ui.id, ui.created_at		
		from user.user_info ui		
		where ui.product_code = 'YN-MAUCASH'		
		) ui		
	left join (			
		select distinct up.id, up.user_id		
		from komodo.user_profiles up
		) up on ui.id = up.user_id		
	left join (			
		select distinct wp.user_id		
		from komodo.work_profiles wp		
		) wp on ui.id = wp.user_id		
	left join (			
		select distinct e.user_id		
		from komodo.contacts e		
		) e on ui.id = e.user_id		
	left join (			
		select distinct fi.user_id		
		from komodo.faceid_logs fi		
		-- where fi.faceid_status = '1'		
		) fi on ui.id = fi.user_id		
	left join (			
		select distinct a.user_id from		
			(select distinct alo.user_id	
			from komodo.auth_logs alo	
			where alo.status = 'pass'	
			union all	
			select distinct relation_id from welab_document.saas_document	
			where date(gmt_create)>='2020-01-16'	
            and doc_type in				
            ('2nd_BPJS',				
			'2nd_BPJS_H',	
			'2nd_BPJS_R',	
			'SK_PNS',	
			'SK_PNS_2nd',	
			'bank_statement_3_months',	
			'bank_statement_3_months_2nd',	
			'name_card_2nd',	
			'occupational_license',	
			'office_card',	
			'photos_of_busi_loca_2nd',	
			'salary_slip',	
			'salary_slip_2nd',	
			'salary_slip_3_months',	
			'self_SIUP',	
			'self_SKU',	
			'self_SKU_SIUP_TDP',	
			'self_SKU_SIUP_TDP_2nd')	
            )a				
				
		) alo on ui.id = alo.user_id		
	left join (			
		select distinct user_id from (		
			(select distinct user_id	
			from finance.finance_user_bankcard where is_used=2	
            )				
			union all	
			(select distinct user_id	
			from komodo.loans where product_code='YN-MAUCASH'	
			and second_prod_code in ('maucash_short','maucash_long','astra_maucash_short','astra_maucash_long')	
			and disbursement_method_type in ('fif_branch','alfamart'))	
		)x		
		) fub on ui.id = fub.user_id		
	left join (			
		select distinct user_id		
		from komodo.loans where product_code='YN-MAUCASH'		
        ) x on ui.id = x.user_id				
	left join (			
		select distinct user_id		
		from komodo.loans where product_code='YN-MAUCASH'		
        and second_prod_code in ('maucash_short','maucash_long','astra_maucash_short','astra_maucash_long')				
        and approved_amount is not null				
        ) y on ui.id = y.user_id				
	left join (			
		select distinct user_id		
		from komodo.loans where product_code='YN-MAUCASH'		
        and second_prod_code in ('maucash_short','maucash_long','astra_maucash_short','astra_maucash_long')				
        and disbursed_at is not null				
        ) z on ui.id = z.user_id				
	left join (			
		select c.location_id,ir.province,ir.postcode 		
		from komodo.addresses c		
		left join komodo.indo_regions ir on (c.province_id = ir.province_id and c.city_id = ir.city_id and c.area_id = ir.area_id and c.village_id = ir.village_id)		
		where c.location = 'user_profiles'		
		) upa on up.id = upa.location_id		
	left join			
    (select a.*, b.state, b.not_approved_desc from				
		(select user_id, max(applied_at)max_applied 		
		from komodo.loans 		
		where product_code='yn-maucash'		
		group by user_id)a		
	left join			
		(select user_id, applied_at, state, not_approved_desc		
		from komodo.loans		
		where product_code='yn-maucash')b		
	on a.user_id=b.user_id and a.max_applied=b.applied_at			
	where b.state='canceled'			
	and b.not_approved_desc in ('AutoCancel -Out of Coverage Area/n','Out of Coverage Area'))nad			
    on up.id=nad.user_id				
	where date(ui.created_at) between @start_dt and @end_dt			
)a				
left join				
	(select user_id, name, mobile, email, case when gender=1 then 'Pria' else 'Wanita' end as gender from komodo.user_profiles)f			
on a.user_id=f.user_id				
left join				
	(select user_id, case when monthly_salary<1000000 then 'a. lt 1 mio'			
	when monthly_salary>=1000000 and monthly_salary<2000000 then 'b. 1 - 2 mio'			
	when monthly_salary>=2000000 and monthly_salary<4000000 then 'c. 2 - 4 mio'			
	when monthly_salary>=4000000 and monthly_salary<6000000 then 'd. 4 - 6 mio'			
	when monthly_salary>=6000000 and monthly_salary<8000000 then 'e. 6 - 8 mio'			
	when monthly_salary>=8000000 then 'e. mte 8 mio'			
	end as monthly_salary			
	from komodo.work_profiles			
	)d			
on a.user_id=d.user_id				
left join				
	(select a.user_id, c.value as education from			
		(select user_id, education_level from komodo.user_profiles		
		where date(created_at)>='2018-09-05')a		
		left join		
		(select a.category, a.key, a.value, description from komodo.configs a)c		
		on a.education_level=c.key and c.category='education'		
	)e			
on a.user_id=e.user_id				
left join				
	(select a.user_id, 			
    timestampdiff(year,birthday,date(created_at))age,				
    case when timestampdiff(year,birthday,date(created_at)) between 21 and 25 then 'a. 21 - 25'				
	when timestampdiff(year,birthday,date(created_at)) between 26 and 30 then 'b. 26 - 30'			
	when timestampdiff(year,birthday,date(created_at)) between 31 and 35 then 'c. 31 - 35'			
	when timestampdiff(year,birthday,date(created_at)) between 36 and 40 then 'd. 36 - 40'			
	when timestampdiff(year,birthday,date(created_at)) between 41 and 45 then 'e. 41 - 45'			
	when timestampdiff(year,birthday,date(created_at)) between 46 and 50 then 'f. 46 - 50'			
	when timestampdiff(year,birthday,date(created_at)) > 50 then 'e. > 50'			
	end as age_group			
	from			
		(select user_id, case when char_length(replace(birthday,'/',''))=7 then str_to_date(replace(concat(0,birthday),'/',''),'%d%m%Y') 		
		else str_to_date(replace(birthday,'/',''),'%d%m%Y') end as birthday, created_at		
		from komodo.user_profiles		
		where date(created_at)>='2018-05-01')a		
	)c			
on a.user_id=c.user_id				
where identity_verify=1 and				
wedefend_auth=1 and bank_card_info=1 and applied=0				
