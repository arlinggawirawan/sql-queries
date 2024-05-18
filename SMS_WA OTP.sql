SELECT msg_vcode_id, mobile, source_id, template_name, vcode as otp_code,
case
	when used_flag = '1' then 'used'
	else 'not used' end as used_flag,
send_time, access_time, finish_time, vendor, 
Case 
	when tags = 'welab-user' then 'SMS OTP'
    when tags = 'welab-message' then 'WA OTP'
    End as tags
FROM message_sms.message_vcode_log 
where vendor != 'kreddo'
and mobile like '88%'
and tags in ('welab-user', 'welab-message')