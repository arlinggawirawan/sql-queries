select distinct alo.user_id			
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
			'self_SKU_SIUP_TDP_2nd');