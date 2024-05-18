select a.user_id, a.name, a.mobile, a.email, count(b.loan_number)count_loan, f.applied_at as latest_applied, g.age_group
from komodo.user_profiles a
left join
komodo.loans b on a.user_id = b.user_id
left join
(select zz.user_id,zz.applied_at, xx.state from	
	(select user_id, max(applied_at)applied_at from komodo.loans where product_code='yn-maucash' group by user_id)zz
		left join	
		(select user_id, applied_at, loan_number, state from komodo.loans where product_code='yn-maucash')xx
	on zz.user_id=xx.user_id and zz.applied_at=xx.applied_at	
where xx.user_id is not null)f
on a.user_id = f.user_id
left join				
	(select a.user_id, 			
    timestampdiff(year,birthday,date(created_at))age,				
    case when timestampdiff(year,birthday,date(created_at)) between 18 and 21 then 'a. 18 - 21'
    when timestampdiff(year,birthday,date(created_at)) between 21 and 25 then 'b. 21 - 25'				
	when timestampdiff(year,birthday,date(created_at)) between 26 and 30 then 'c. 26 - 30'			
	when timestampdiff(year,birthday,date(created_at)) between 31 and 35 then 'd. 31 - 35'			
	when timestampdiff(year,birthday,date(created_at)) between 36 and 40 then 'e. 36 - 40'			
	when timestampdiff(year,birthday,date(created_at)) between 41 and 45 then 'f. 41 - 45'			
	when timestampdiff(year,birthday,date(created_at)) between 46 and 50 then 'f. 46 - 50'			
	when timestampdiff(year,birthday,date(created_at)) > 50 then 'g. > 50'			
	end as age_group			
	from			
		(select user_id, case when char_length(replace(birthday,'/',''))=7 then str_to_date(replace(concat(0,birthday),'/',''),'%d%m%Y') 		
		else str_to_date(replace(birthday,'/',''),'%d%m%Y') end as birthday, created_at		
		from komodo.user_profiles		
		where date(created_at)>='2018-05-01')a		
	)g
on a.user_id = g.user_id
where date(b.applied_at) >= '2019-01-01'
and date(b.rejected_at) is null
and b.product_code='yn-maucash'
group by a.user_id
having count(b.loan_number) >= '2'
order by f.applied_at asc