SELECT a.msg_vcode_id, a.mobile, a.source_id, a.template_name, a.vcode as otp_code,
case
	when a.used_flag = '1' then 'used'
	else 'not used' end as used_flag,
a.send_time, a.access_time, a.finish_time, a.vendor, 
Case 
	when a.tags = 'welab-user' then 'SMS OTP'
    End as tags,
    count(a.mobile)attempt, b.mobile
FROM message_sms.message_vcode_log a
left join
user.user_info b on a.mobile = b.mobile
where a.vendor != 'kreddo'
and a.source_id = 'android'
and a.tags = 'welab-user'
and a.send_time between '2020-10-01' and '2020-10-26'
and a.mobile like '811%' or a.mobile like '812%' or a.mobile like '813%' 
or a.mobile like '821%' or a.mobile like '822%' or a.mobile like '823%' or a.mobile like '851%' 
or a.mobile like '852%' or a.mobile like '853%'
group by a.mobile
having count(a.mobile) = '1'