SELECT Case when second_prod_code = 'maucash_short' then 'Maucepat V1'
		when second_prod_code = 'maucash_long' then 'Mauringan V1'
		when second_prod_code = 'old_user_maucash_short' then 'RO Maucepat V1'
		when second_prod_code = 'old_user_maucash_long' then 'RO Mauringan V1'
		when second_prod_code = 'maucash_short_v2' then 'Maucepat V2'
		when second_prod_code = 'maucash_long_v2' then 'Mauringan V2'
		when second_prod_code = 'old_user_maucash_short_v2' then 'RO Maucepat V2'
		when second_prod_code = 'old_user_maucash_long_v2' then 'Mauringan V2'
		when second_prod_code = 'lite_maucash_short' then 'Maucepat500'
		when second_prod_code = 'lite_maucash_short_v2' then 'Maucepat500 V2'
		when second_prod_code = 'astra_maucash_short' then 'Astra Maucepat V1'
		when second_prod_code = 'astra_maucash_long' then 'Astra Mauringan V1'
		when second_prod_code = 'old_astra_maucash_short' then 'RO Astra Maucepat V1'
		when second_prod_code = 'old_astra_maucash_long' then 'RO Astra Mauringan V1'
		when second_prod_code = 'astra_maucash_short_v2' then 'Astra Maucepat V2'
		when second_prod_code = 'astra_maucash_long_v2' then 'Astra Mauringan V2'
		when second_prod_code = 'old_astra_maucash_short_v2' then 'RO Astra Maucepat V2'
		when second_prod_code = 'old_astra_maucash_long_v2' then 'RO Astra Mauringan V2'
		when second_prod_code = 'astra_maucash_short' then 'Astra Maucepat V1'
		when second_prod_code = 'sigap_maucash' then 'SIGAP'
	end as product, approved_tenor as tenor, approved_amount as amount, count(loan_number)total_active_loan
from komodo.loans
where second_prod_code in ('maucash_short','maucash_short_v2','old_user_maucash_short','old_user_maucash_short_v2',														
'astra_maucash_short','astra_maucash_short_v2','old_astra_maucash_short','old_astra_maucash_short_v2','lite_maucash_short',														
'lite_maucash_short_v2','maucash_long','maucash_long_v2','old_user_maucash_long','old_user_maucash_long_v2',														
'astra_maucash_long','astra_maucash_long_v2','old_astra_maucash_long','old_astra_maucash_long_v2','sigap_maucash')
and state not in ('rejected', 'closed', 'timeout', 'canceled','in_approval','send_back')
and date(applied_at) >= '2020-01-01'
group by product, approved_tenor, approved_amount
order by product, approved_tenor, approved_amount asc