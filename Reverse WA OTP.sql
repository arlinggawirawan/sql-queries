SELECT msg_vcode_id, mobile, source_id, template_name, vcode as otp_code,
case
	when used_flag = '1' then 'used'
	else 'not used' end as used_flag,
send_time, access_time, finish_time, vendor, tags
FROM message_sms.message_vcode_log 
where vendor = 'kreddo'
and tags = 'applogin'
and mobile like '88%'