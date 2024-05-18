SELECT a.merchant_id, a.location_id, b.name, c.name AS 'location'
FROM auto_approval_whitelist a
LEFT JOIN merchants b ON a.merchant_id=b.id
LEFT JOIN locations c ON a.location_id=c.id;

select receipt_uuid, merchant_name, payment_method, location_name, receipt_date, total, created_at, merchant_name_score, location_name_score, date_score, time_score, total_score
from ocr_receipt
order by created_at desc;

SELECT a.*, b.reason FROM auto_approval_log a
LEFT JOIN auto_approval_reason b ON a.reason = b.id
ORDER BY created_at DESC;

Select uuid, email, membership_number, merchant_id, merchant_name, location_id, location_name, receipt_date, total, reference_number, created_at from upload_receipt
-- where merchant_name = 'KFC'
order by created_at desc;
-- and date(created_at) = curdate();
-- order by created_at desc;
-- https://majoo.id/ereceipt/ms2022083144445

select * from ocr_receipt
-- where receipt_uuid in ('c2456a28-f031-4c95-899a-33c4edeb6213','b7805c17-5111-4e6f-a850-d592e21db641'); -- ,'6227513d-a54d-47d2-8800-8337843fe39e','2321ed1a-0b06-4521-8343-f87ea2757b77');
where receipt_uuid = 'cfd4100c-c699-4df9-b0a5-29a19bc6c80a';

SELECT * FROM dev_mygetplus.sku;

SELECT email, terminated_at FROM dev_loyalty.mst_member
-- where tier_current = 'Platinum';
where cardno in ('6194420221212152233','6194420221212151355','6194420221213103439','6194420221213113714');
-- or email = 'apptest5899+dev08@gmail.com';

select * from outlet_scan_to_use;

SELECT a.id, a.uuid, a.membership_number, a.email, a.created_at, a.receipt_date, a.total, b.merchant_name, b.location_name, 
-- a.trx_similarity, b.total_score, b.time_score, b.date_score, b.location_name_score, b.merchant_name_score
c.status, c.reason, c.notes, c.reason_notes as auto_approval_status
FROM upload_receipt a
INNER JOIN ocr_receipt b ON a.uuid = b.receipt_uuid
INNER JOIN (SELECT a.*, b.reason AS 'reason_notes' FROM auto_approval_log a
LEFT JOIN auto_approval_reason b ON a.reason = b.id) c ON a.id = c.receipt_id
WHERE a.email = 'rasyidrespati.30@gmail.com'
-- WHERE a.trx_similarity = '0'
-- AND b.total_score < 90
ORDER BY created_at
LIMIT 1000;

SELECT * FROM dev_mygetplus.sku;

select * from parameter;

select tenant, partner_id, partner_name, multiplier, factor, store_parent_name, status, address from dev_loyalty.mst_partner;
-- where partner_name like '%Ranch_%'
-- or partner_name like '%Grand_%';

-- 6194420221011074910
select * from pn_queue
where body like '%6194420221011074910%'
and date(created) = curdate()
order by created desc;

select * from pn_queue pq 
where date(created) = CURDATE(); 
	
select * from upload_receipt
-- where upload_type = 'url'
order by created_at desc;

SELECT * FROM log_gift_reward_code WHERE campaign ='Campaign-Test-Partner-03' AND STATUS ='active';

select * from dev_membership.otp_logs
order by created_at desc;

select sum(total)
from trans_hdr
Where customer = '6194420221021022247'
and created_at = curdate();

SELECT cardno, username, total_amount FROM dev_loyalty.mst_member
where username = 'apptest5899+dev01@gmail.com';
-- and username like '%_tes%';


Select status, id, uuid, membership_number, email, created_at, updated_at, reject_by, reject_reason from upload_receipt
where email in ('apptest5899+poininsentif@gmail.com', 'apptest5899+poininsentif02@gmail.com', 'apptest5899+dev01@gmail.com', 'apptest5899+terminated04@gmail.com', 'apptest5899@gmail.com', 'apptest5899+poininsentive8@gmail.com')
and Date(created_at) <= curdate()
-- or Date(created_at) < curdate()
order by created_at desc;

select uuid, membership_number, email, merchant_name, status, created_at, updated_at, reject_date, reject_reason, approve_date from upload_receipt
where email = 'apptest5899+pendingpoint1@gmail.com';

Select sum(total) as total FROM dev_loyalty.trans_hdr
where customer = '6194420221130031557'
and transaction_type = 'SALE';

select cardno, username, phone_no from dev_loyalty.mst_member
where username like '%apptest5899_%'
and is_verified = 1;

select * from dev_loyalty.trans_hdr
where uuid = 'e6f3e56a-b33b-4813-aba3-1224e9478e71'
order by created_at desc;

SELECT a.merchant_id, a.pos_id, b.name, c.name FROM merchant_locations a
INNER JOIN merchants b ON a.merchant_id=b.id
LEFT JOIN locations c ON a.location_id=c.id;
-- WHERE b.name like '%_polis%';

select * from buypoints_method;

SELECT a.id, a.uuid, a.membership_number, CONCAT('https://images.mygetplus.id/', a.filename) AS link_url, 
a.merchant_name, a.location_name, a.total, b.product, a.created_at FROM upload_receipt a
LEFT JOIN (SELECT ab.id, ab.receipt_uuid, ac.product FROM ocr_receipt ab 
INNER JOIN ocr_receipt_items ac ON ab.id=ac.ocr_receipt_id) b ON a.uuid=b.receipt_uuid
ORDER BY DATE(a.created_at) desc
LIMIT 1000;

SELECT a.merchant_id, a.pos_id, a.factor, a.multiplier, a.is_active, a.partner_id, b.name, c.name FROM merchant_locations a
INNER JOIN merchants b ON a.merchant_id=b.id
LEFT JOIN locations c ON a.location_id=c.id
WHERE b.is_active='1'
and b.name like '%cin_%';

SELECT a.merchant_id, a.location_id, b.name, c.name AS 'location'
FROM auto_approval_whitelist a
LEFT JOIN merchants b ON a.merchant_id=b.id
LEFT JOIN locations c ON a.location_id=c.id;

SELECT * FROM dev_loyalty.mst_registrations
where username like '%apptest5899+_%'
-- where username = 'apptest5899+homepage37@gmail.com'
-- where username in ('apptest5899+homepage30@gmail.com','apptest5899+homepage31@gmail.com','apptest5899+homepage32@gmail.com',
-- 'apptest5899+homepage33@gmail.com','apptest5899+homepage34@gmail.com', 'apptest5899+homepage35@gmail.com','apptest5899+homepage36@gmail.com','apptest5899+homepage42@gmail.com')
order by created_at desc;

select * from dev_loyalty.mst_member
where username like '%apptest5899+_%'
-- where is_verified = '0'
-- order by created_at desc;
-- where username in ('apptest5899+homepage30@gmail.com','apptest5899+homepage31@gmail.com','apptest5899+homepage32@gmail.com',
-- 'apptest5899+homepage33@gmail.com','apptest5899+homepage34@gmail.com', 'apptest5899+homepage35@gmail.com','apptest5899+homepage36@gmail.com','apptest5899+homepage37@gmail.com')
-- where username like '%apptest5899+homepage37_%'
-- and date(created_at) = curdate()
order by DATE(created_at) desc;

SELECT * FROM dev_membership.otp_logs
-- where phone_no like '81213439010';
Where date(created_at) = curdate()
order by created_at desc;

select * from dev_loyalty.mst_registrations
where username like '%apptest5899+_%';

SELECT * FROM dev_loyalty.mst_email_template;
SELECT * FROM dev_mygetplus.merchant_locations;
select * from dev_loyalty.mst_member
where username like '%apptest5899+_%'
order by created_at desc;
select * from upload_receipt
where url = 'https://majoo.id/ereceipt/ms2022090110628'
limit 100;

SELECT * FROM dev_loyalty.mst_member
-- WHERE DATE(created_at) >= '2023-01-18'
WHERE email like '%apptest5899%'
ORDER BY created_at desc
LIMIT 5000;

SELECT * FROM dev_mygetplus.partner_join_params;

select * from dev_mygetplus.partner_join_mst_member;
select * from dev_loyalty.mst_partner_app;
select id, cardno, username, email, phone_no, email_verified, phone_verified, is_verified, created_at from dev_loyalty.mst_member
where username like '%apptest5899_%'
-- and phone_no = '+62 81318567710'
order by created_at desc;

select * from dev_mygetplus.partner_join_account
-- where GetPlusID = '6194420230104013547';
order by created desc;

select * from dev_loyalty.mst_partner;

SELECT a.merchant_id, a.pos_id, b.name, c.name FROM merchant_locations a
INNER JOIN merchants b ON a.merchant_id=b.id
LEFT JOIN locations c ON a.location_id=c.id;

select * from merchant_categories mc ;

select * from dev_mygetplus.partner_join_account
where PartnerID = 'edf277d8-3770-4b2a-abb3-44d4bc5dd387';
-- and GetPlusID = '6194420221021022247';

Select a.uuid, CONCAT('https://images.mygetplus.id/', a.filename) as 'Image Link', a.merchant_name as 'Merchant Name by OCR',
a.location_name, b.name as 'Merchant Name', a.created_at from upload_receipt a
left join merchants b on a.merchant_name like b.name;

select * from auto_approval_log
order by created_at desc;

SELECT a.id, a.uuid, a.membership_number, a.email, a.created_at, a.receipt_date, a.total, b.merchant_name, b.location_name, 
-- a.trx_similarity, b.total_score, b.time_score, b.date_score, b.location_name_score, b.merchant_name_score
c.status, c.reason, c.notes, c.reason_notes as auto_approval_status
FROM upload_receipt a
INNER JOIN ocr_receipt b ON a.uuid = b.receipt_uuid
INNER JOIN (SELECT a.*, b.reason AS 'reason_notes' FROM auto_approval_log a
LEFT JOIN auto_approval_reason b ON a.reason = b.id) c ON a.id = c.receipt_id
WHERE a.email = 'rasyidrespati.30@gmail.com'
-- WHERE a.trx_similarity = '0'
-- AND b.total_score < 90
ORDER BY created_at DESC
LIMIT 1000;

select * from ocr_receipt
order by created_at desc;

Select * from upload_receipt
-- where receipt_date is null;
where email like '%apptest5899%'
-- and date(created_at) = curdate()
order by created_at desc;

SELECT a.id, a.uuid, a.membership_number, a.email, a.created_at, a.receipt_date, a.total, a.merchant_name, a.location_name, 
c.status, c.reason, c.notes, c.reason_notes as 'auto_approval_status'
FROM upload_receipt a
INNER JOIN (SELECT a.*, b.reason AS 'reason_notes' FROM auto_approval_log a
LEFT JOIN auto_approval_reason b ON a.reason = b.id) c ON a.id = c.receipt_id
WHERE a.email in ('apptest5899@gmail.com','apptest5899+dev01@gmail.com')
and date(a.created_at) = curdate()
ORDER BY a.created_at DESC;

-- https://r.mokapos.com/r/570404_8EQzqWSJjk
-- https://r.mokapos.com/r/476311_PB248oq7O6
-- https://r.mokapos.com/r/570404_8EQz2WSJjk
-- https://r.mokapos.com/r/427741_2ApIRKTGUt
-- https://majoo.id/ereceipt/ms2022083115043
select * from upload_receipt
where email in ('apptest5899@gmail.com','apptest5899+dev01@gmail.com')
and date(created_at) = curdate()
order by created_at desc;

select * from upload_receipt
where (lower(merchant_name) like '%baby%' or LOWER(merchant_name) like '%nanny%' or lower(merchant_name) like '%karnivor%')
and status = 10
order by created_at desc;

select * from ocr_receipt
order by created_at desc;

select a.status, a.id, a.uuid, a.membership_number, a.email, concat('https://images-dev.mygetplus.id/', a.filename) as 'Image Link', a.receipt_date, 
a.location_name, a.merchant_name, a.category_name, a.created_at, b. merchant_name as 'OCR Merchant', b.location_name as 'ORC Location', b.payment_method as 'OCR Payment' ,
b.payment_product as 'product', b.total, b.bank_name, b.merchant_name_score, b.location_name_score, b.date_score, b.time_score, b.total_score from upload_receipt a
left join ocr_receipt b on a.uuid = b.receipt_uuid
where a.email = 'apptest5899@gmail.com'
and date(a.created_at) = curdate()
order by a.created_at desc;

select category_id from upload_receipt
where status in (10,4,20)
order by created_at desc;

SELECT * FROM dev_eshop_db.ia_pb_tracking
where member_id = 6194420221011074910
order by pb_date desc
limit 1000;
select * from dev_eshop_db.ia_merchant_offers;
select * from dev_eshop_db.ia_offers_list;
select customer, action, transaction_id, transaction_type, transaction_date, partner_name, points_earned, source, source_channel from dev_loyalty.trans_hdr
where date(created_at) = curdate()
and customer = 6194420221011074910
and action = 'campaign_bonus';
-- and partner_name like 'eShop%';
select * from dev_eshop_db.postback_queue
order by created desc
limit 100;

select * from dev_mygetplus.pn_queue
where body like CONCAT('%', '6194420221215040527', '%');

select * from dev_eshop_db.postback_issuance_queue
order by created desc
limit 100;
SELECT * FROM dev_eshop_db.ia_t_his_conversion
where conversion_id = 249640996;
SELECT * FROM dev_eshop_db.ia_rejects_bucket
where conversion_id = 249640996;

SELECT * FROM dev_loyalty.log_gift_reward_code;
-- WHERE campaign ='Campaign-Test-Partner-03' AND STATUS ='active';

select * from dev_loyalty.mst_member
where username like '%apptest5899_%'
order by created_at desc;

select a.id, a.name as 'merchant_name', b.id as 'category_id' , b.name as 'category_name', c.name 'location_name' from merchants a
left join merchant_categories b on a.category_id = b.id
left JOIN (select ml.merchant_id , ml.location_id , l.name from merchant_locations ml left join locations l on ml.location_id = l.id) c 
on a.id = c.merchant_id
WHERE (lower(b.name) like 'casual%' or LOWER(b.name) like 'mini%' or LOWER(b.name) like 'super%'); 

select * from merchants ; -- 331433 627
select * from merchant_locations;	-- 626 indomaret 358 alfa 359 midi location id 407 loc 626
select * from locations;
select * from merchant_categories mc ;

select * from ocr_receipt
-- where lower(merchant_name) like '%bath & body%'
-- and lower(whole_text) like '%duplicate%';
order by created_at desc;

select * from mcp_callback
WHERE payment_method = 'CARD' AND raw LIKE CONCAT('%', 'apptest5899@gmail.com', '%')
-- and date(created) = CURDATE()
and transaction_status = 'Failed'
order by created desc;

SELECT uuid , membership_number , email ,merchant_name , location_name , total , status , receipt_date , reject_by , reject_reason , reject_date  from upload_receipt
where uuid = 'c6d67d14-3b84-443d-b1ea-fa2dd1d5dec4'
-- where status = 1
order by created_at desc;

SELECT * from upload_receipt 
WHERE (created_at - LAG(created_at, 1) OVER (PARTITION BY id ORDER BY created_at)) < '60 seconds';

SELECT * FROM (
  SELECT *,
         LEAD(created_at) OVER (ORDER BY created_at) AS next_timestamp
  FROM upload_receipt
) next_timestamp
WHERE TIMESTAMPDIFF(SECOND, created_at, next_timestamp) <= 60;

select a.*, b.name from sku_merchant_whitelist a
left join merchants b on a.merchant_id = b.id ;

select * from sku_merchant_whitelist smw ;

select * from auto_approval_log
order by created_at desc;

select reference_number, uuid, merchant_name, location_name, merchant_id, location_id, total, receipt_date, status, email, upload_type , url, created_at  from upload_receipt
-- where email = 'apptest5899+dev01@gmail.com'
order by created_at desc;

select /*approve_by, approve_date,*/ a.status, a.* from upload_receipt a
-- where status = 1
where membership_number = '6194420230908075839'
and date(created_at) = CURDATE() 
order by updated_at desc;

SELECT x.status, x.* FROM dev_mygetplus.upload_receipt x
WHERE uuid in ('c4fd0fb0-52b3-44d8-98cc-a5b631dca79b','042c94d8-c3d1-4bd9-afca-33e1d47e2526')
order by created_at desc;

select * from auto_approval_log aal
where receipt_id = 3293;

select * from upload_receipt
where url in ('https://r.mokapos.com/r/570404_NIA24uvEgO',
'https://majoo.id/ereceipt/ms2023060341455',
'https://r.mokapos.com/r/772373_J8ZsdSHghY',
'https://majoo.id/ereceipt/ms2023060397142',
'https://majoo.id/ereceipt/ms2023060391812',
'https://r.mokapos.com/r/796669_AnENE4xn2B',
'https://r.mokapos.com/r/570404_cO0SQl9Aoq',
'https://r.mokapos.com/r/768427_fa9UfLPxR9',
'https://r.mokapos.com/r/127891_s8Th2fmR8V',
'https://r.mokapos.com/r/806723_hAl4XkcqEu',
'https://r.mokapos.com/r/570404_tK06G4G6Fn');

select * from upload_receipt
/* test url, hapus atau edit url ini dari db */
where url = 'https://majoo.id/ereceipt/ms1696503983412176639'
order by created_at desc;

select device_platform, url, uuid, status, upload_type, merchant_name, location_name, total, receipt_date, membership_number, email, created_at from upload_receipt ur 
where upload_type = 'URL'
order by created_at desc;

select c.receipt_type_name, c.reference_number , c.status, c.id, c.uuid, c.membership_number, c.email, c.original_filename, c.merchant_name, c.location_name, c.total, c.receipt_date, a.mapping_result, a.ocr_result, a.sku_items, c.created_at, c.reject_reason FROM upload_receipt c
left join ocr_receipt a on c.uuid = a.receipt_uuid
WHERE c.membership_number = '6194420240229153745'
and date(c.created_at) = CURDATE() 
order by c.created_at desc;		

select ur.uuid, ur.email, ur.membership_number, ur.status, ri.product_name from upload_receipt ur 
left join receipt_items ri on ur.id = ri.receipt_id 
where status = 1
order by ur.created_at desc;

select email, uuid, merchant_name, location_name, total , category_id, category_name, status from upload_receipt
where status = 1
and category_name is not NULL
order by created_at desc;

select uuid, email, admin, admin_email, status, merchant, location, category_name from receipt_pending rp
where category_name is not null
and status = 1
order by created_at desc;

select * from receipt_items
where receipt_id = 4932;

/*update upload_receipt 
set url = ''
where upload_type != 'url'
and date(created_at) >= '2023-08-27';*/
