SELECT msg_vcode_id, mobile, source_id, template_name, vcode as otp_code,
case
	when used_flag = '1' then 'used'
	else 'not used' end as used_flag,
send_time, access_time, finish_time, vendor, 
Case 
	when tags = 'welab-user' then 'SMS OTP'
    End as tags,
    count(mobile)attempt
FROM message_sms.message_vcode_log 
where vendor != 'kreddo'
and source_id = 'android'
and tags = 'welab-user'
and send_time between '2020-10-01' and '2020-10-26'
and mobile like '817%' or mobile like '818%' or mobile like '819%' 
or mobile like '859%' or mobile like '877%' or mobile like '878%'
group by mobile
having count(mobile) = '1'