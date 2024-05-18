SELECT c.reason_notes as 'auto_approval_status', a.id, a.uuid, a.membership_number, a.email, a.created_at, a.receipt_date, a.total, a.merchant_name, a.location_name, a.reference_number,
c.status, c.reason, c.notes
FROM upload_receipt a
left join (SELECT a.*, b.reason AS 'reason_notes' FROM auto_approval_log a
LEFT JOIN auto_approval_reason b ON a.reason = b.id) c ON a.id = c.receipt_id
WHERE a.email LIKE '%gpites%' 
AND date(a.created_at) >= '2024-02-13';

select b.uuid, b.email, a.* from auto_approval_log a
left join upload_receipt b on a.receipt_id = b.id 
where uuid = 'ddd21c16-8682-4169-91ab-3c63d8c5f8c1';
-- order by created_at desc
-- limit 100;

SELECT count(`timestamp`), uuid, membership_number, email, merchant_name, `timestamp`, resource_id, device_platform, device_platform_version from upload_receipt ur 
group by `timestamp` 
having COUNT(`timestamp`) > 1;

SELECT * from upload_receipt ur 
WHERE `timestamp` = '1685631761'
and membership_number = '6194420221123144836';
order by created_at DESC;

select id, uuid, email, concat('https://images.mygetplus.id/', filename), merchant_name, location_name, receipt_date, total, reference_number from upload_receipt
where LOWER(merchant_name) like '%starbucks%'
and lower(location_name) like '%central%'
order by created_at desc;

select * from upload_receipt ur
-- where email = 'apptest5899+gpites@gmail.com'
where lower(merchant_name) like '%your bag%'
order by created_at DESC
limit 100;	

SELECT count(ap.id) as 'Total Auto Approve Apollo' from (select c.reason_notes as 'auto_approval_status', c.notes, a.id, a.receipt_date, a.total, a.merchant_name, a.location_name, 
c.status, c.reason, a.uuid, a.membership_number, a.email, a.reference_number, a.created_at
FROM upload_receipt a
INNER JOIN (SELECT a.*, b.reason AS 'reason_notes' FROM auto_approval_log a
LEFT JOIN auto_approval_reason b ON a.reason = b.id) c ON a.id = c.receipt_id
where lower(a.merchant_name) like '%apollo%'
and a.approve_by = 'AUTO-APPROVE'
and a.created_at >= '2023-07-07') ap;

SELECT a.id, a.uuid, a.membership_number, a.email, a.created_at, a.receipt_date, a.total, a.merchant_name, a.location_name, 
b.total_score, b.time_score, b.date_score, b.location_name_score, b.merchant_name_score, c.status, c.reason, c.notes, c.reason_notes as auto_approval_status
FROM upload_receipt a
INNER JOIN ocr_receipt b ON a.uuid = b.receipt_uuid
INNER JOIN (SELECT a.*, b.reason AS 'reason_notes' FROM auto_approval_log a
LEFT JOIN auto_approval_reason b ON a.reason = b.id) c ON a.id = c.receipt_id
WHERE lower(a.merchant_name) like '%cincau station%'
-- AND date(a.created_at) >= '2023-06-28'
ORDER BY a.created_at desc
limit 1000;

select merchant_name , location_name , category_id , category_name , concat('https://images.mygetplus.id/', filename), url From upload_receipt ur
where category_id in (26,35,36)
-- where LOWER(upload_type) like '%url%'
order by created_at desc;

select * from outlet_scan_to_use ostu
where lower(name) like '%roastman%';

select a.name as 'merchant_name', b.name as 'merchant_location', ml.* from merchant_locations ml
left join merchants a on ml.merchant_id = a.Id
left join locations b on ml.location_id = b.Id
-- WHERE lower(b.name) like '%apollo%';
where a.is_partner != 0;

select uuid, status, merchant_name, location_name, receipt_date, total from upload_receipt
where uuid in ('91b2f0c6-d329-4416-bc9e-45047365d2ba','6e12ac37-1be0-4da8-85f2-4d374a8bf7af','510b5c38-fc50-48d6-9b24-c27e1c8f3d40','df650f36-34cc-4601-9fd0-3b41ac6846a3',
'66fea381-dd03-4ca4-8cbc-4fc240fd9588','c9c486f2-dce4-422e-8a93-3e34a7d96e65','db80f5f0-557f-49b9-85cc-b85e1d4f8ca1','2b686de9-943c-4587-83b2-911eaefc66db',
'd9c7a85a-c1ac-45c0-8d4c-7ea24fdb2bb6','e9e5437e-7bc9-4586-85bb-2187cadc0002');

select * from pn_queue pq
where LOWER(body) like '%6094450088005213522%' 
order by created desc
limit 100;

select * from outlet_scan_to_use ostu ;

select * from ocr_receipt
where LOWER(merchant_name) like '%apollo%'
and date(created_at) >= '2023-07-07'
order by created_at desc;

select * from upload_receipt ur 
where lower(upload_type)= 'url'
-- where email ='gpites01+qa@gmail.com'
order by created_at DESC
limit 1000;

select count(*) as total_apollo from (select c.reason_notes as 'auto_approval_status', c.notes, a.reference_number, a.receipt_date, a.total, a.merchant_name, a.location_name, a.upload_type, 
c.status, c.reason, a.uuid, a.membership_number, a.email, a.created_at
FROM upload_receipt a
INNER JOIN (SELECT a.*, b.reason AS 'reason_notes' FROM auto_approval_log a
LEFT JOIN auto_approval_reason b ON a.reason = b.id) c ON a.id = c.receipt_id
where lower(a.merchant_name) like '%apollo%'
and a.approve_by = 'AUTO-APPROVE'
and c.reason_notes = 'success'
-- and date(a.created_at) >= '2023-06-28'
order by created_at desc)total_apollo;

select concat('https://images.mygetplus.id/', b.filename), a.receipt_uuid, a.merchant_name, a.location_name, a.total, a.receipt_date, a.whole_text
from ocr_receipt a
left join upload_receipt b on a.receipt_date = b.uuid
where (lower(a.whole_text) like '%reprint%'
or lower(a.whole_text) like '%duplicate%'
or lower(a.whole_text) like '%copy%')
-- and LOWER(a.location_name) = 'grand indonesia'
order by a.created_at desc
limit 1000;

select concat('https://images.mygetplus.id/', b.filename), a.receipt_uuid, a.merchant_name, a.location_name, a.total, a.receipt_date, a.whole_text
from ocr_receipt a
left join upload_receipt b on a.receipt_date = b.uuid
where a.whole_text like '%1889%'
order by a.created_at desc;

select a.uuid, b.product_name, b.qty, b.product_group, a.merchant_name, a.location_name, b.subtotal as 'sku_subtotal', a.created_at
from upload_receipt a
inner join receipt_items b on a.id = b.receipt_id
where a.approve_by = 'AUTO-APPROVE'
and a.category_id in (8,36)
and date(a.created_at) >= '2023-04-28';

select ml.merchant_id , a.name , b.name as 'location_name' , a.is_partner , ml.partner_id , ml.location_id , ml.pos_id , ml.multiplier , ml.factor , ml.is_active , ml.is_auto_approval  
from merchant_locations ml
left join merchants a on ml.merchant_id = a.id 
left join locations b on ml.location_id = b.Id 	
where a.name like '%foodhall%';

select a.uuid, b.product_name, b.qty, b.product_group, a.merchant_name, a.location_name, b.subtotal as 'sku_subtotal', a.created_at
from upload_receipt a
INNER join receipt_items b on a.id = b.receipt_id
where a.approve_by = 'AUTO-APPROVE'
and (lower(a.merchant_name) like '%farmers%'
and lower(a.location_name) like '%kelapa%'
and date(a.created_at) >= '2023-04-28')
or (lower(a.merchant_name) like '%ranch%'
and LOWER(a.location_name) like '%grand%'
and date(a.created_at) >= '2023-04-28');

select a.uuid, b.product_name, b.qty, b.product_group, a.merchant_name, a.location_name, b.subtotal as 'sku_subtotal', a.created_at
from upload_receipt a
INNER join receipt_items b on a.id = b.receipt_id
where a.approve_by = 'AUTO-APPROVE'
and a.merchant_id in (531, 87) 
and location_id in (636,979)
and date(a.created_at) >= '2023-04-28';

select a.name as 'merchant_name', b.id as 'category_id' , b.name as 'category_name', c.name 'location_name' from merchants a
left join merchant_categories b on a.category_id = b.id
left JOIN (select ml.merchant_id , ml.location_id , l.name from merchant_locations ml left join locations l on ml.location_id = l.id) c 
on a.id = c.merchant_id;

select case when a.status = 10 then 'Approved' end as 'Status', 
a.id, a.uuid, a.membership_number, a.email, concat('https://images.mygetplus.id/', a.filename), a.merchant_name, a.location_name, a.total, a.receipt_date,
b.code, b.product_name, b.qty, b.subtotal
from upload_receipt a
inner join receipt_items b on a.id = b.receipt_id 
where a.status = 10
order by a.created_at desc;

select CONCAT('https://images.mygetplus.id/', b.filename), a.* from ocr_receipt a
left join upload_receipt b on a.receipt_uuid = b.uuid 
where lower(a.merchant_name) like '%karnivor%'
and lower(a.whole_text) like '%closed%'
and lower(a.location_name) like '%grand indo%'
order by a.created_at desc
limit 1000;

select id, name, is_active, logo from partners
where (lower(name) like '%circle%' or LOWER(name) like '%diamond%' or LOWER(name) like '%hari%' or LOWER(name) like '&hush%');  

select * from receipt_items
order by created_at desc
limit 100;

select * from merchant_categories mc ;

select CONCAT('https://images.mygetplus.id/', b.filename) , a.* from ocr_receipt a
left join upload_receipt b on a.receipt_uuid = b.uuid 
where a.payment_product != 'BCA'
and a.payment_method = 'CARD'
and b.reject_reason_id = 24
-- and a.whole_text like '%ARD TYPE BCA (DIP)%'
order by a.created_at desc;

select * from merchant_locations
where is_auto_approval = 1;

select a.thumbnail, a.uuid, a.membership_number, a.status, a.reject_reason_id, a.merchant_name, a.location_name, a.total, a.receipt_date, a.created_at from upload_receipt a
where a.reject_reason_id = 24
ORDER by a.created_at DESC;

select count(a.`timestamp`) as 'duplicate', a.`timestamp`, a.uuid, a.membership_number, a.email, a.filename, a.created_at, a.receipt_date ,total, a.merchant_name, a.location_name  from upload_receipt a
-- where membership_number = '6194420230830074450'
-- where date(created_at) = CURDATE()
GROUP by a.`timestamp`, a.email
HAVING COUNT(a.`timestamp`) > 7
order by a.created_at asc;

SELECT * from upload_receipt ur 
where email = 'lingga.saputra@gmail.com'
and (created_at - LAG(created_at, 1) OVER(PARTITION BY id, ORDER by created_at))
order by created_at desc;

select * from mcp_callback mc
where payment_channel = 'CARD'
order by created desc;

select * from ocr_receipt
where lower(whole_text) like '%temporary%'
/*and lower(merchant_name) like '%karnivor%'
and lower(location_name) like '%grand%'*/
order by created_at desc;

select * from ocr_receipt
where receipt_uuid = '56a4dc73-6228-482a-9bb4-f1ead1e41c85'
order by created_at desc;

select uuid, email, status,  upload_type , url, created_at  from upload_receipt
where date(created_at) >= '2023-08-27'
order by created_at desc;

select count(uuid) from upload_receipt
where device_platform = 'iOS'
and device_platform_version like '%17%'
order by created_at desc;

select count(url) from upload_receipt
where (url like '/v3/member/%' or url like '/v3/%');

select * from upload_receipt
where email = 'agustina@fpsi.untar.ac.id'
order by created_at desc;

SELECT count(id) as Total_Auto_Approve from (select c.reason_notes as 'auto_approval_status', c.notes, a.id, a.receipt_date, a.total, a.merchant_name, a.location_name, 
c.status, c.reason, a.uuid, a.membership_number, a.email, a.reference_number, a.created_at
FROM upload_receipt a
INNER JOIN (SELECT a.*, b.reason AS 'reason_notes' FROM auto_approval_log a
LEFT JOIN auto_approval_reason b ON a.reason = b.id) c ON a.id = c.receipt_id
where date(a.created_at) >= '2023-09-14'
and a.approve_by = 'AUTO-APPROVE') Total_Auto_Approve;

select a.*, b.name from sku_merchant_whitelist a
left join merchants b on a.merchant_id = b.id ;

select a.*, p.name as 'merchant_name' from merchant_locations a
join partners p on a.partner_id = p.id
where a.partner_id != 0;

select a.membership_number, a.email, date(a.created_at), count(a.uuid), a.merchant_name, 
case
	when a.status = 10 then 'Approved'
	when a.status = 1 then 'Pending'
	else 'Not define'
end as 'status'
from upload_receipt a
where (a.status = 10 or a.status = 1)
and date(a.created_at) >= '2023-01-01'
group by date(a.created_at), a.membership_number, a.merchant_name, a.status
having COUNT(a.uuid) >= 5
order by date(a.created_at) desc;

select a.membership_number, a.email, date(a.created_at), count(a.uuid), b.merchant_name from upload_receipt a
left join (select c.*, p.name as 'merchant_name' from merchant_locations c
left join partners p on c.partner_id = p.id
where c.partner_id != 0) b on a.merchant_id = b.merchant_id
where a.status = 10
and date(a.created_at) >= '2023-09-01'
group by date(a.created_at), a.membership_number, b.merchant_name
having COUNT(a.uuid) >= 10
order by count(a.uuid) desc;

select * from upload_receipt
where lower(upload_type) = 'url'
order by created_at desc;


select ml.is_auto_approval, a.name as 'merchant_name', b.name as 'merchant_location', ml.* from merchant_locations ml
left join merchants a on ml.merchant_id = a.Id
left join locations b on ml.location_id = b.Id
where lower(a.name) like 'grand lucky%';

select uuid, email, CONCAT('https://images.mygetplus.id/', filename), merchant_name, location_name, total, created_at from upload_receipt
where (lower(merchant_name) like '%kfc%' or lower(merchant_name) like '%taco bell%')
and location_name = 'grand indonesia'
order by created_at desc;

select uuid, email, CONCAT('https://images.mygetplus.id/', filename), merchant_name, location_name, total, created_at from upload_receipt
where (lower(merchant_name) like '%watsons%' or lower(merchant_name) like '%guardian%')
and location_name = 'grand indonesia'
order by created_at desc;

select c.reason_notes as 'auto_approval_status', c.notes, ar.uuid, ar.email, ar.merchant_name, ar.location_name, ar.total, ar.category_id, ar.category_name, ar.receipt_date, ar.status, ar.upload_type, ar.url, ar.created_at from upload_receipt ar
LEFT JOIN (SELECT a.*, b.reason AS 'reason_notes' FROM auto_approval_log a
LEFT JOIN auto_approval_reason b ON a.reason = b.id) c ON ar.id = c.receipt_id
-- where ar.uuid = '6fe10d94-7fcf-4fbc-8d2e-1a1fb86e55c9'
order by ar.created_at desc
limit 500;

select status, ur.* from upload_receipt ur
where email like '%gpites01+qa%'
-- where upload_type = 'URL'
and date(ur.created_at) = CURDATE() 
order by ur.created_at desc;

select a.email, or2.* from ocr_receipt or2
left join upload_receipt a on or2.receipt_uuid = a.uuid 
where date(or2.created_at) = CURDATE()
and a.email like '%gpites%'
order by or2.created_at desc;

select a.uuid, a.email, a.total, a.merchant_name, a.location_name, a.reference_number, a.approve_by, a.receipt_date, a.created_at, b.sku_items, b.ocr_result, b.mapping_result from upload_receipt a
left join ocr_receipt b on a.uuid = b.receipt_uuid 
where a.membership_number = '6094450088005213522'
order by a.created_at desc;

select email, COUNT(email) from (select uuid, membership_number, email, merchant_name, location_name, created_at, receipt_date from upload_receipt
where location_name like '%mall kelapa gading%'
and date(created_at) = '2024-01-06')cek
group by email;

select ur.device_platform, ur.status, ur.* from upload_receipt ur
where ur.email like '%gpites%'
-- and date(ur.created_at) = curdate()
and ur.status = 1
-- and ur.upload_type = 'URL'
order by ur.created_at desc;
  
select CONCAT('https://images.mygetplus.id/', filename), status, merchant_name, location_name from upload_receipt
where lower(merchant_name) like '%xxi%'
order by created_at desc;

SELECT SUM(pending) from ( SELECT count(*) as pending, created_at from receipt_pending
where status in (1,3)
and assign_to_spv is NOT NULL 
group by created_at ) a;

SELECT count(*) , date(created_at) from upload_receipt
where status in (1,3)
group by date(created_at) 
order by date(created_at) asc;

SELECT SUM(pending) from ( SELECT COUNT(*) as pending, date(created_at) from upload_receipt
where status in (1,3,9)
and assign_date is not null
group by date(created_at))a;

SELECT * from upload_receipt
where status in (1,3)
and (approve_by is not NULL or reject_by is not NULL);

select a.uuid,
	case when a.status = 10 then 'APPROVED'
	 	 when a.status = 9 then 'ISSUING IN PROGRESS - REAPPROVE'
	  	 when a.status = 4 then 'REJECTED'
	 	 when a.status = 3 then 'REJECT CANDIDATE'
	 	 when a.status = 2 then 'ISSUING IN PROGRESS - PROCESS IN BACKGROUND'
	 	 when a.status = 1 then 'PENDING'
	 	 When a.status = 20 then 'FIRST REJECT'
			else 'NOT MAPPING IN PORTAL'
	end as status_portal, 
		a.approve_by, a.created_at, a.merchant_name, a.location_name, c.reason_notes as auto_approval_notes, c.notes, a.receipt_date, a.total, a.upload_type, 
	case when c.status = 10 then 'SUCCESS AUTO APPROVE'
		else 'FAILED' 
	end as status_auto_approval, 
		c.reason, a.membership_number, a.email
FROM upload_receipt a
INNER JOIN (SELECT a.*, b.reason AS 'reason_notes' FROM auto_approval_log a
LEFT JOIN auto_approval_reason b ON a.reason = b.id)c ON a.id = c.receipt_id
-- where date(a.created_at) = CURDATE()
-- and a.uuid = '376d1cc5-2dd8-4a73-b205-7b8a238227d5'
where lower(a.merchant_name) like '%yogya%'
order by a.created_at desc;	

SELECT app_version, device_platform_version, device_platform, uuid, approve_by, created_at, receipt_date, merchant_name, location_name, total, email, membership_number from upload_receipt ur 
where approve_by = 'AUTO-APPROVE'
and date(created_at) = CURDATE();

SELECT COUNT(*) from (SELECT * from upload_receipt ur 
where date(created_at) = '2024-05-08')a

SELECT ri.receipt_id, ri.sku_id, ri.product_name, ri.qty, ri.subtotal, ri.plu, ur.uuid, ur.merchant_name, ur.location_name, ur.total, ur.receipt_date, ur.created_at, ur.original_filename from receipt_items ri
Left join upload_receipt ur on ri.receipt_id = ur.id
-- where lower(ur.merchant_name) = 'ranch market'
where lower(ri.product_name) like '%abc%'
ORDER by ur.created_at desc; 