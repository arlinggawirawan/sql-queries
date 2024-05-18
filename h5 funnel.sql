select last_day(created_date)created_month, province, count(distinct id)count_user,					
sum(product_choosing)product_choosing,sum(personal_info)personal_info, sum(employment_info)employment_info,					
sum(emergency_contact)emergency_contact, sum(identity_verify)identity_verify, sum(wedefend_auth)wedefend_auth,					
sum(bank_card_info)bank_card_info, sum(applied)applied, 					
sum(approved)approved, sum(disbursed)disbursed, 					
sum(out_of_coverage)out_of_coverage, sum(timeout_after_sendback)timeout_after_sendback from					
	(select ui.id, date(ui.created_at)created_date,				
    if(ae.user_id is not null, '1','0') as product_choosing,					
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
    if(snb.user_id is not null and tmo.user_id is not null, '1','0') as timeout_after_sendback,					
    upa.province					
	from (				
		select ui.id, ui.created_at			
		from user.user_info ui			
		where ui.product_code = 'YN-MAUCASH'
        and origin='H5' and date(created_at) between 				
		date_add(date_add(last_day(date_add(curdate(), interval - 1 day)), interval 1 day), interval - 1 month) - interval 6 month 					
		and curdate() - interval 1 day and date(created_at)>='2020-07-11'
		) ui			
	left join				
		(select distinct user_id from collect.app_event			
		where event_type in ('long_product_page', 'product_confirm_page', 'short_product_page'))ae			
	on ui.id=ae.user_id				
	left join (				
		select up.id, up.user_id			
		from komodo.user_profiles up			
		) up on ui.id = up.user_id			
	left join (				
		select wp.user_id			
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
			from finance.finance_user_bankcard -- where is_used=2		
            )					
			union all		
			(select distinct user_id		
			from komodo.loans where product_code='YN-MAUCASH'
			and disbursement_method_type in ('fif_branch','alfamart'))		
		)x			
		) fub on ui.id = fub.user_id			
	left join (				
		select distinct user_id
		from komodo.loans 
        where product_code='YN-MAUCASH'		
        ) x on ui.id = x.user_id					
	left join (				
		select distinct user_id			
		from komodo.loans where product_code='YN-MAUCASH'
        and approved_amount is not null
        ) y on ui.id = y.user_id					
	left join (				
		select distinct user_id			
		from komodo.loans where product_code='YN-MAUCASH'
        and disbursed_at is not null
        ) z on ui.id = z.user_id					
	left join				
		(select c.location_id,ir.province,ir.postcode 			
		from komodo.addresses c 			
		left join indo_regions ir 
        on (c.province_id = ir.province_id 
        and c.city_id = ir.city_id 
        and c.area_id = ir.area_id 
        and c.village_id = ir.village_id)			
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
    on ui.id=nad.user_id					
    left join					
		(select user_id, min(date(send_back_at))send_back_at from komodo.loans_sendback			
		where date(send_back_at)>='2018-09-05'			
		group by user_id)snb			
	on ui.id=snb.user_id				
    left join					
		(select user_id, min(date(applied_at))applied_at 			
        from komodo.loans 					
        where state='timeout'					
        group by user_id)tmo					
	on ui.id=tmo.user_id				
)a					
group by last_day(created_date), province					
;					
