select a.user_id, a.name, a.mobile, a.email, b.send_time, b.access_time, c.age_group
from komodo.user_profiles a
left join message_sms.message_vcode_log b on a.mobile = b.mobile
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
	)c
on a.user_id = c.user_id
where b.vendor = 'kreddo'
and b.tags = 'applogin'
and a.mobile like '88%'