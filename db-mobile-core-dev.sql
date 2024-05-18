select customer, transaction_type, transaction_date, partner_name, merchant_location, total, points_earned, source_channel  from trans_hdr th
where customer = '6194420221021022247'
order by created_at desc;

select * from mst_registrations mr 
where username like '%apptest5899+cek404%'
order by created_at desc;

select * from mst_partner;

select customer , transaction_id , transaction_type , transaction_date , source_channel , merchant_name , merchant_location , total , total_nonsale , points_earned from trans_hdr
where customer = '6194420230412071003'
order by created_at desc;

select * from mst_partner mp
where lower(partner_name) like '%kopi 6 hari%';

select * from mst_email_template met ;

select * from mst_partner
where lower(partner_name) like '%kfc%';

select * from mst_reward;
where reward_id_rsn = '63402025352130073d1e840a';

SELECT * from mst_member
where email  like '%apptest5899%'
order by created_at desc;

select a.*, b.partner_name, b.store_active from mst_partner_highlight a
left join mst_partner b on a.partner_id = b.partner_id;

select * from mst_partner mp 
where partner_id in ('68043','170833','325417','299895','328268','24098','108229','24100');

select a.customer, b.username, a.transaction_id, a.transaction_ref, a.transaction_type, a.partner_name, a.total, points_earned, a.source_channel, a.created_at  from trans_hdr a
left join mst_member b on a.customer = b.cardno  
ORDER by created_at desc;

select customer, `action` , transaction_id , transaction_ref , transaction_type , merchant_name , merchant_location , total , total_nonsale , points_earned , source_channel, 
transaction_date , created_at  from trans_hdr
where customer = '6194420221021022247'
and date(created_at) = CURDATE()
order by created_at desc;

select customer, `action` , transaction_id , transaction_ref , transaction_type , merchant_name , merchant_location , total , total_nonsale , points_earned , source_channel, 
transaction_date , created_at  from trans_hdr
where customer = '6194420221011074910'
and date(created_at) = CURDATE()
order by created_at desc;

select ol.* from otp_logs ol 
order by ol.created_at desc;

select partner_name, partner_id, store_parent_name, points_source, updated_at, auto_approve from mst_partner
where auto_approve = 1
and store_type = 'OUTLET';

select COUNT(transaction_ref), transaction_id, transaction_ref ,
transaction_type , source_channel , customer , transaction_date , points_earned 
from trans_hdr 
where source_channel ='mcpayment'
group by transaction_ref 
having COUNT(transaction_ref) > 1
order by transaction_ref;

select * from mst_pubsub_config ;

select * from mst_member mm 
where email like '%apptest5899%' /*phone_no like '%82110607190%' or phone_no like '%9418%' or phone_no like '%0163525%'*/
order by created_at desc;

select * from mst_member
where email like '%apptest5899%'
-- where phone_no like '%+62 81234567666%'
order by created_at desc;

select * from mst_registrations mr  
where email like '%apptest5899%'
order by created_at desc;

select partner_id, partner_name, auto_approve from mst_partner -- 2023-09-22 03:14:24.000 (MKG 235784, cp 235783) lower(partner_name) like '%Mall kelapa gading%'
-- and store_type = 'MERCHANT' {"website": "https://www.malkelapagading.com/", "facebook": "", "whatsapp": "", "instagram": "@mallkelapagading"}
where partner_id = 299876
order by id asc;

select * from trans_hdr
where uuid in ('8501d538-e3af-465f-94e2-19cbbcbe0732','527a5bf2-2a0e-4ea7-a3ed-440fa52d77f9','6dd241a5-bf92-48c2-afb8-d6e3fcea3003','75d4b7bf-09c7-47c8-ab99-9c539a31b99e','0ce01d3b-bc35-4c02-bf4f-e0f496558850')
-- where uuid = 'c7790749-7414-4b13-aead-5e5fb55f0eaf'
-- where customer = '6194420230821081328'
order by created_at desc;

select * from trans_hdr
where source = 'convert_points'
and source_channel = '%bca%'
ORDER by created_at desc;

SELECT * FROM (
  SELECT *,
         LEAD(created_at) OVER (ORDER BY created_at) AS next_timestamp
  FROM trans_hdr
) next_timestamp
WHERE TIMESTAMPDIFF(SECOND, created_at, next_timestamp) <= 10;

select cardno, username, birth_date, email_verified, phone_verified, is_verified from mst_member
where TIMESTAMPDIFF(YEAR, birth_date, CURDATE()) < 18
and username like '%apptest5899_%'
order by created_at desc;

select th.* from trans_hdr th
where customer = '6194420230821080911'
and source_channel = 'linkaja'
order by th.created_at desc;
mygetplus.convertpoints_history

SELECT * FROM mst_registrations WHERE first_name like '%velia%' LIMIT 10;
SELECT * FROM mst_partner where partner_type = 'brand';
SELECT * FROM mst_partner; -- where lower(partner_name) like '%planet%';
SELECT * FROM mst_partner where store_active = 0 and store_type = 'MERCHANT';
SELECT * FROM mst_partner where store_type = 'OUTLET' and store_parent = 235783;

/* update mst_partner 
set points_source = 'point_on_us'
where id in (606847,606723,606724,606725,606726,606727,606728,606729,606730,606731,606732,606733,606734,606735,606736,606738,606739,606742,606743,606744,606745,606746,606747,606748,606750,
606751,606752,606753,606754,606755);

update mst_partner 
set status = ''
where id = 528724
and partner_id = 24082;

insert into mst_partner (id, tenant, partner_id, partner_name, country, state, city, zip_code, multiplier, factor, store_active, store_type, store_parent, store_parent_name)
values (606743, 'GETPLUS', 24311, 'Starbucks', 'Indonesia', 'DKI Jakarta', 'Jakarta', '11420', 1, 0, 1, 'OUTLET', 235783, 'Central Park'),
(606744, 'GETPLUS', 24312, 'Burger King', 'Indonesia', 'DKI Jakarta', 'Jakarta', '11420', 1, 0, 1, 'OUTLET', 235783, 'Central Park'),
(606745, 'GETPLUS', 24313, 'Kopi Kenangan', 'Indonesia', 'DKI Jakarta', 'Jakarta', '11420', 1, 0, 1, 'OUTLET', 235783, 'Central Park'),
(606746, 'GETPLUS', 24314, 'Chattime', 'Indonesia', 'DKI Jakarta', 'Jakarta', '11420', 1, 0, 1, 'OUTLET', 235783, 'Central Park'),
(606747, 'GETPLUS', 24315, 'H&M', 'Indonesia', 'DKI Jakarta', 'Jakarta', '11420', 1, 0, 1, 'OUTLET', 235783, 'Central Park'),
(606748, 'GETPLUS', 24316, 'Pull & Bear', 'Indonesia', 'DKI Jakarta', 'Jakarta', '11420', 1, 0, 1, 'OUTLET', 235783, 'Central Park'),
(606749, 'GETPLUS', 24317, 'Miniso', 'Indonesia', 'DKI Jakarta', 'Jakarta', '11420', 1, 0, 1, 'OUTLET', 235783, 'Central Park'),
(606750, 'GETPLUS', 24318, 'Subway', 'Indonesia', 'DKI Jakarta', 'Jakarta', '11420', 1, 0, 1, 'OUTLET', 235783, 'Central Park'),
(606751, 'GETPLUS', 24319, 'Tous Les Jours', 'Indonesia', 'DKI Jakarta', 'Jakarta', '11420', 1, 0, 1, 'OUTLET', 235783, 'Central Park'),
(606752, 'GETPLUS', 24320, 'Hoops', 'Indonesia', 'DKI Jakarta', 'Jakarta', '11420', 1, 0, 1, 'OUTLET', 235783, 'Central Park');

insert into mst_partner (id, tenant, partner_id, partner_name, partner_type, country, state, city, zip_code, multiplier, factor, store_active, store_type)
values (606770, 'GETPLUS', 24324, '121 Test', 'Offline Merchant', 'Indonesia', 'DKI Jakarta', 'Jakarta', '11420', 1, 0, 1, 'MERCHANT'),
(606771, 'GETPLUS', 24325, '21 Test Short', 'Offline Merchant', 'Indonesia', 'DKI Jakarta', 'Jakarta', '11420', 1, 0, 1, 'MERCHANT'),
(606772, 'GETPLUS', 24326, '219 Test', 'Offline Merchant', 'Indonesia', 'DKI Jakarta', 'Jakarta', '11420', 1, 0, 1, 'MERCHANT'),
(606773, 'GETPLUS', 24327, '3 Second', 'Offline Merchant', 'Indonesia', 'DKI Jakarta', 'Jakarta', '11420', 1, 0, 1, 'MERCHANT');

**/

select store_parent, store_parent_name, id, partner_id, partner_name, store_type, store_visible, store_active, auto_approve from mst_partner mp 
where store_parent in (235784, 235783)
-- where store_type = 'OUTLET'
and auto_approve = 0;

select cardno, email, phone_no, email_verified, phone_verified, is_verified from mst_member mm 
where cardno in ('6194420240220072502','6194420240220072759');

select * from mst_member mm 
where email like '%apptest5899%';

select customer, action, transaction_id, transaction_type, transaction_date, status, source_channel, source from trans_hdr
where transaction_type = 'REDEMPTION'
and `action` = 'reward'
order by created_at desc;

select * from mst_sku ms ;

SELECT mph.*, mp.partner_name from mst_partner_highlight mph
left join mst_partner mp on mph.partner_id = mp.partner_id ;

select status, customer, transaction_id, transaction_type, partner_name, total, points_earned, points_burned, source from trans_hdr
WHERE transaction_type = 'REDEMPTION' and date(created_at) = curdate()
order by created_at desc;

# *****Query earn point SR*****
select customer, uuid, partner_name, partner_location, points_earned, points_earned_original , total, total_nonsale, transaction_date, status, transaction_type, notes, transaction_id, source, source_channel from trans_hdr th
WHERE customer = '6194420240229153745'
and status in ('success','in_progress')
and source = 'scan_receipt'
and date(created_at) = CURDATE() 
and transaction_type in ('SALE', 'BONUS', 'ACTIVITY')
order by created_at desc;

select * from mst_member
where tier_current = 'gold'
and email like '%apptest5899%';

SELECT mm.email, mr.* from mst_registrations mr 
left join mst_member mm on mr.cardno = mm.cardno 
where mr.phone_verified = 1 and mr.email_verified = 1 and mr.is_verified = 0
and mm.email is NULL 
and mr.email like '%apptest5899%';