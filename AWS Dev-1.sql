SELECT * from dev_loyalty.mst_partner mp 
where lower(partner_name) like '%apollo%';

select ml.is_auto_approval, a.name as 'merchant_name', b.name as 'merchant_location', ml.* from dev_mygetplus.merchant_locations ml
left join merchants a on ml.merchant_id = a.Id
left join locations b on ml.location_id = b.Id 
-- where ml.partner_id != 0;
where (lower(a.name) like '%kfc%' or lower(a.name) like '%taco%');

SELECT * FROM dev_mygetplus.merchant_categories mc ;

select * from dev_mygetplus.`parameter` p 
where paramName in ('InAppScanTransactionLimit', 'DefaultTotalReceiptLimit');

SELECT a.merchant_id, a.pos_id, b.name, c.name, a.is_active FROM merchant_locations a
INNER JOIN merchants b ON a.merchant_id=b.id
LEFT JOIN locations c ON a.location_id=c.id;
-- WHERE lower(b.name) like '%insight%';

select * from dev_mygetplus.`parameter` p;

select * from locations;
-- where LOWER(code) like '%tokopedia%';

select * from merchant_locations ml
where merchant_id = 513;

select a.*, b.reason from auto_approval_log a
left join auto_approval_reason b on a.reason = b.id
order by created_at desc;

select * from partner_join_account pja ;

select * from sku
where code = 'SKU-Appolo'
and lower(name) like '%oppo a17%';

select * from point_on_us_whitelist;

select * from merchants;
select * from merchant_locations;	-- 627 629
select * from locations;
select * from merchant_categories mc ;

select * from mcp_callback
where date(created) = CURDATE() ;

select * from dev_loyalty.trans_hdr
where customer = '6194420221021022526'
and date(created_at) = CURDATE() 
order by created_at DESC ;

select * from dev_loyalty.mst_email_template met ;

SELECT * from mcp_blocked_cc_history mbch ;

select uuid, membership_number, email,  from upload_receipt
-- where uuid = '9efe3dcb-305d-41e2-bb19-bf0c979a006d'
order by created_at desc;

select * from merchants;

SELECT * FROM mcp_callback 
WHERE payment_method = 'CARD' AND transaction_status in ('failed','Success') AND raw LIKE CONCAT('%', 'apptest5899+homepage40@gmail.com', '%');
-- and date(created) >= '2023-07-03';

select * from dev_membership.otp_logs ol 
order by created_at desc;

# ****QUERY AUTO APPROVE LOG****
select a.uuid,
	case when a.status = 10 then 'APPROVED'
	 	 when a.status = 9 then 'ISSUING IN PROGRESS - REAPPROVE'
	  	 when a.status = 4 then 'REJECTED'
	 	 when a.status = 3 then 'REJECT CANDIDATE'
	 	 when a.status = 2 then 'ISSUING IN PROGRESS - PROCESS IN BACKGROUND'
	 	 when a.status = 1 then 'PENDING'
	 	 When a.status = 20 then 'FIRS REJECT'
			else 'NOT MAPPING IN PORTAL'
	end as status_portal, 
		a.approve_by, a.created_at, c.reason_notes as auto_approval_notes, c.notes, a.receipt_date, a.total, a.merchant_name, a.location_name, a.upload_type, 
	case when c.status = 10 then 'SUCCESS AUTO APPROVE'
		else 'FAILED' 
	end as status_auto_approval, 
		c.reason, a.membership_number, a.email
FROM upload_receipt a
INNER JOIN (SELECT a.*, b.reason AS 'reason_notes' FROM auto_approval_log a
LEFT JOIN auto_approval_reason b ON a.reason = b.id)c ON a.id = c.receipt_id
WHERE a.membership_number = '6194420240229153745'
and date(a.created_at) = CURDATE()
order by a.created_at desc;			

SELECT * FROM upload_receipt
where lower(merchant_name) like 'ranch%'
and lower(location_name) like 'alam%'
and status = 10
order by created_at desc;

select c.reason_notes as 'auto_approval_status', c.notes, ar.uuid, ar.email, ar.merchant_name, ar.location_name, ar.total, ar.category_id, ar.category_name, ar.receipt_date, ar.reference_number, ar.status, ar.upload_type, ar.url, ar.created_at from upload_receipt ar
LEFT JOIN (SELECT a.*, b.reason AS 'reason_notes' FROM auto_approval_log a
LEFT JOIN auto_approval_reason b ON a.reason = b.id) c ON ar.id = c.receipt_id
-- where ar.uuid = 'cfd4100c-c699-4df9-b0a5-29a19bc6c80a'
order by ar.created_at desc;

select c.reason_notes as 'auto_approval_status', c.notes, ar.* from upload_receipt ar
LEFT JOIN (SELECT a.*, b.reason AS 'reason_notes' FROM auto_approval_log a
LEFT JOIN auto_approval_reason b ON a.reason = b.id) c ON ar.id = c.receipt_id
-- where url = 'https://majoo.id/ereceipt/ms202209013837' ar.uuid, ar.email, ar.merchant_name, ar.location_name, ar.total, ar.receipt_date, ar.status, ar.upload_type, ar.url, ar.created_at 
order by ar.created_at desc;

SELECT * from receipt_items
order by created_at desc;

select * from pn_queue pq 
order by created desc;

SELECT count(membership_number), membership_number , email , status, approve_by  from upload_receipt
where approve_by = 'arlingga.wirawan@gpi.id'
and date(approve_date) = CURDATE() 
group by membership_number 
order by created_at desc;

select * from `parameter` p;

select receipt_uuid , merchant_name_score , location_name_score , date_score , total_score  from ocr_receipt
where receipt_uuid  = '22adc723-f0ee-4e2c-83a3-a0cd2e2bf29c'
order by created_at desc;

select * FROM upload_receipt
where date(created_at) BETWEEN '2023-03-01' and '2023-04-01'
and merchant_name = 'KKULDAK'
-- and lower(merchant_name) like '%apollo%' -> klo mau query like  photo, screenshoot, document, url, PHOTO, GALLERY, DOCUMENT, URL
and status = 1;

SELECT COUNT(*) AS one_hour FROM mcp_callback mc 
INNER JOIN mcp_request mr ON mc.order_id = mr.order_id AND mr.email = 'apptest5899@gmail.com' 
WHERE mc.payment_method = 'CARD' AND mc.transaction_status = 'failed'
AND mc.created >= CONVERT_TZ(DATE_ADD(NOW(), INTERVAL -48 HOUR),@@SESSION.TIME_ZONE,'Asia/Jakarta') 
AND mc.created <= CONVERT_TZ(NOW(),@@SESSION.TIME_ZONE,'Asia/Jakarta');

select * from mcp_callback
WHERE payment_method = 'CARD' AND raw LIKE CONCAT('%', 'apptest5899@gmail.com', '%')
-- and date(created) = CURDATE()
and transaction_status = 'Failed'
order by created desc;

2023-08-27 22:53:50.000
2023-08-27 19:51:01.000
2023-08-27 15:54:29.000
2023-08-27 10:50:23.000
2023-08-26 23:31:30.000
2023-08-26 20:00:49.000
2023-08-26 19:59:15.000
2023-08-26 14:19:02.000
2023-08-26 12:17:59.000
2023-08-26 09:14:49.000

select * from mcp_request mr 
WHERE email = 'apptest5899@gmail.com'
order by CREATEd desc;

CALL fraud_checker_cc('apptest5899+@gmail.com');


2023-07-20 11:30:49.000
2023-07-20 09:34:44.000
2023-07-20 08:36:26.000 --081923401234
2023-07-20 05:38:14.000
2023-07-20 03:41:23.000
2023-07-20 00:42:50.000

select * from merchant_categories mc ;

SELECT COUNT(*) AS one_hour FROM mcp_callback mc 
INNER JOIN mcp_request mr ON mc.order_id = mr.order_id AND mr.email = 'apptest5899+allnewrebuild03@gmail.com' 
WHERE mc.payment_method = 'CARD' AND mc.transaction_status = 'failed'
AND mc.created >= CONVERT_TZ(DATE_ADD(NOW(), INTERVAL -1 HOUR),@@SESSION.TIME_ZONE,'Asia/Jakarta') 
AND mc.created <= CONVERT_TZ(NOW(),@@SESSION.TIME_ZONE,'Asia/Jakarta');

SELECT mc.transaction_id, mc.payment_method, mc.transaction_status, mc.created, mr.email FROM mcp_callback mc 
INNER JOIN mcp_request mr ON mc.order_id = mr.order_id AND mr.email = 'apptest5899@gmail.com' 
WHERE mc.payment_method = 'CARD' AND mc.transaction_status = 'failed' -- AND mr.email = email 
AND mc.created >= CONVERT_TZ(DATE_ADD(NOW(), INTERVAL -7 DAY),@@SESSION.TIME_ZONE,'Asia/Jakarta') 
AND mc.created <= CONVERT_TZ(NOW(),@@SESSION.TIME_ZONE,'Asia/Jakarta');

select * from mcp_callback mc
order by created desc;
SELECT * from mcp_request mr
order by created desc;

select ml.is_auto_approval , a.name as 'merchant_name', b.name as 'merchant_location', ml.* from dev_mygetplus.merchant_locations ml
left join merchants a on ml.merchant_id = a.Id
left join locations b on ml.location_id = b.Id
where ml.merchant_id = 87
and ml.location_id  = 521;
-- where ml.is_auto_approval = 1
-- and lower(a.name) like '%insight%';

select concat('https://images.mygetplus.id/', b.filename), a.receipt_uuid, a.merchant_name, a.location_name, a.total, a.receipt_date, a.whole_text
from ocr_receipt a
left join upload_receipt b on a.receipt_date = b.uuid
where (-- lower(a.whole_text like '%duplicate%')
-- or lower(a.whole_text) Like '%copy%'
lower(a.whole_text) like '%reprint%')
and LOWER(a.location_name) = 'grand indonesia'
order by a.created_at desc;

SELECT * from dev_mygetplus_service.receipt_allocate
where admin_email like '%arlingga%'
and status = 1
order by created_at desc;

select id, uuid, email, merchant_name, location_name, receipt_date, total, reference_number, status, approve_by FROM upload_receipt
where uuid in ('5971b8bd-64a8-4a69-8609-8730c26eb609', 'cfd4100c-c699-4df9-b0a5-29a19bc6c80a')
order by created_at desc;

select * FROM pn_queue pq
order by created desc;

select membership_number, uuid , email , status, merchant_name, location_name, total, receipt_date, created_at from upload_receipt
-- where membership_number = '6194420221021022247'
-- where uuid = '62a5bae8-2590-4656-97e6-3b0cf7038cbd'
order by created_at desc;

SELECT app_version, device_platform_version, device_platform, uuid, approve_by, created_at, receipt_date, merchant_name, location_name, total, email, membership_number from upload_receipt ur 
where approve_by = 'SYSTEM';

select c.receipt_type_name, c.reference_number , c.status, c.id, c.uuid, c.membership_number, c.email, c.original_filename, c.merchant_name, c.location_name, c.total, c.receipt_date, a.mapping_result, a.ocr_result, c.created_at, c.reject_reason FROM upload_receipt c
left join ocr_receipt a on c.uuid = a.receipt_uuid
WHERE c.membership_number = '6194420240220073703'
and date(c.created_at) = CURDATE() 
order by c.created_at desc;	

-- fraud checker rebuild
SELECT `mcp_callback`.`id`, `mcp_callback`.`transaction_id`, `mcp_callback`.`order_id`, `mcp_callback`.`external_id`, `mcp_callback`.`currency`, `mcp_callback`.`payment_method`, 
`mcp_callback`.`payment_channel`, `mcp_callback`.`transaction_status`, `mcp_callback`.`raw`, `mcp_callback`.`created`, `mcr`.`id` AS `mcr.id`, `mcr`.`transaction_id` 
AS `mcr.transaction_id`, `mcr`.`order_id` AS `mcr.order_id`, `mcr`.`external_id` AS `mcr.external_id`, `mcr`.`amount` AS `mcr.amount`, `mcr`.`channel` AS `mcr.channel`, 
`mcr`.`is_customer_paying_fee` AS `mcr.is_customer_paying_fee`, `mcr`.`save_card` AS `mcr.save_card`, `mcr`.`callback_url` AS `mcr.callback_url`, `mcr`.`success_redirect_url` 
AS `mcr.success_redirect_url`, `mcr`.`failed_redirect_url` AS `mcr.failed_redirect_url`, `mcr`.`description` AS `mcr.description`, `mcr`.`membership_number` 
AS `mcr.membership_number`, `mcr`.`email` AS `mcr.email`, `mcr`.`first_name` AS `mcr.first_name`, `mcr`.`last_name` AS `mcr.last_name`, `mcr`.`product_code` 
AS `mcr.product_code`, `mcr`.`product_name` AS `mcr.product_name`, `mcr`.`point` AS `mcr.point`, `mcr`.`price` AS `mcr.price`, `mcr`.`pos_id` AS `mcr.pos_id`, `mcr`.`mcp_signature` 
AS `mcr.mcp_signature`, `mcr`.`created` AS `mcr.created` FROM `mcp_callback` AS `mcp_callback` INNER JOIN `mcp_request` AS `mcr` ON `mcp_callback`.`order_id` = `mcr`.`order_id` 
WHERE `mcp_callback`.`payment_method` = 'CARD' AND `mcp_callback`.`transaction_status` = 'failed' AND `mcp_callback`.`created` 
BETWEEN '2023-12-01 11:35:00' AND '2023-12-01 11:45:40' AND `mcr`.`email` = 'apptest5899+allnewrebuild03@gmail.com';