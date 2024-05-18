select COUNT(transaction_ref), transaction_id , transaction_ref,transaction_type , source_channel , customer , transaction_date , points_earned
from trans_hdr 
where source_channel ='mcpayment'
and date(created_at) >= '2023-09-07' -- tanggal naik fixing double posting mcp '2023-09-07'
-- and customer = '6194420230811213333'
group by transaction_ref 
having COUNT(transaction_ref) > 1
order by transaction_ref;

SELECT * from mst_member mm 
-- where username in ('apptest5899+gpiguestimpact@gmail.com','apptest5899+guestimpact@gmail.com')
where cardno = '6094450088000310786'

SELECT * from trans_hdr
where uuid = 'b3a4906e-fd94-44de-a901-5d21aaab2235';

select customer , sum(points_burned) from trans_hdr
where source_channel  like '%dana%'
and date(transaction_date) = CURDATE()
GROUP  by customer;

select COUNT(a.customer) as 'Jumlah transaksi user', sum(a.points_burned) as 'Total point redeem dana',
a.customer, b.tier_current, b.point_balance, b.score, b.spent, b.hold_redemption , b.terminated_at, b.phone_verified, b.email_verified, b.is_verified,
a.transaction_id , a.transaction_type , a.source, a.source_channel, a.transaction_date 
from trans_hdr a
left join mst_member b on a.customer = b.cardno 
where a.source_channel = 'dana'
and date(a.transaction_date) >= '2023-11-15'
-- AND a.customer = '6194420230316151751'
group by a.customer
having COUNT(a.customer) >= 1
order by a.transaction_date;

select * from mst_member
where (email like '%gpites01+qa%'
or email like '%apptest5899%')
and point_balance != 0;

select * from trans_hdr
where source = 'convert_points'
and source_channel = 'bca'
order by created_at desc;

SELECT * from mst_member
where terminated_at  is not null
and (lower(email) like '%gpites01+%' or LOWER(email) like '%apptest5899%')
and is_verified = 1;

select * from mst_partner mp
where lower(partner_name) like '%Park 5%'
order by created_at desc;

SELECT * from trans_hdr th
where source_channel = 'offline_item'
order by created_at desc;

SELECT * from mst_partner
where lower(partner_name) like '%kopi 6 hari%'
order by created_at desc;

select * from mst_member
where (email like 'gpites01+qa%' or email like 'apptest5899+%')
and date(created_at) = CURDATE() 
order by date(created_at) desc;

select * from mst_member
where cardno = '6094450088003173736'
order by created_at desc;

select * from trans_hdr
WHERE source_channel = 'mcpayment'
and transaction_ref in ('20230910145649',
'20230909010301',
'20230908155619',
'20230908084943',
'20230907153919')
order by created_at desc;

select * from trans_hdr th
-- where customer = '6194420221215034621'
-- and transaction_id = 'EWT-231114-000256'
order by created_at desc;

select sum(points_burned) as total_points_burned from (select *, count(transaction_date) as 'created_date'
from trans_hdr th
where date(transaction_date) >= '2023-07-01'
and transaction_type ='EWALLET'
group by transaction_date  
having count(transaction_date) > 1
order by transaction_date desc)total_points_burned;

select *, count(transaction_date) as 'created_date'
from trans_hdr th
where date(transaction_date) = CURDATE() 
and transaction_type ='EWALLET'
group by transaction_date  
having count(transaction_date) > 1
order by transaction_date desc;

select *, count(transaction_date) as 'created_date'
from trans_hdr th
where date(transaction_date) >= '2023-01-01'
and transaction_type ='REDEMPTION'
AND source ='convert_points'
and callback_id is not null
group by transaction_date  
having count(transaction_date) > 1
order by transaction_date desc;

select b.username, a.* from trans_hdr a
left join mst_member b on a.customer = b.cardno 
where a.source = 'EWALLET'
and date(a.created_at) = CURDATE() 
order by a.created_at desc;

select count(a.transaction_date) as 'total_date_yang_sama', a.customer, b.username, b.phone_no, b.point_balance, a.points_burned, a.transaction_id, a.transaction_type, a.transaction_date, a.partner_name, a.source, a.source_channel, a.uuid, 
a.posting_date, a.created_at, a.updated_at, a.notes, a.callback_id from trans_hdr a
left join mst_member b on a.customer = b.cardno
where a.transaction_type = 'EWALLET'
and date(a.transaction_date) >= '2023-07-01'
and a.points_burned > 1
and (b.username like '%fonsayan%' or b.username like '%fafataqil%' or b.username like '%mumunnakal%')
group by a.transaction_date , a.customer 
-- having COUNT(a.transaction_date) > 1 
order by a.transaction_date desc;

select * from mst_member
where username like '%gpites01+rebuild%';

select sum(total) as total from (select a.*, b.username from trans_hdr a
left join mst_member b on a.customer = b.cardno 
where a.source = 'buy_points'
and (b.username like '%fonsayan%' or b.username like '%fafataqil%' or b.username like '%mumunnakal%')
order by a.created_at desc)total;

select b.username, th.notes , th.* from trans_hdr th left join mst_member b on th.customer = b.cardno where th.transaction_id in (
'EWT-231109-000093',
'EWT-231109-000094'
);

Select b.customer, b.source, a.store_parent as 'merchant_id', a.partner_id as 'location_id', b.merchant_name, b.merchant_location, b.transaction_date as 'date', b.total, b.points_earned, b.uuid from mst_partner a
left join trans_hdr b on a.partner_name = b.partner_name
where (lower(b.merchant_name) like '%rantang%' or lower(b.merchant_name) like '%park 5%')
and date(b.transaction_date) BETWEEN '2023-05-01' and '2023-07-31';

select mm.username, th.* from trans_hdr th 
left join mst_member mm on th.customer = mm.cardno
where th.customer = '6194420221125115318'
and th.source = 'EWALLET'
order by th.transaction_date desc;

select * from trans_hdr
where source = 'EWALLET'
and date(created_at) = curdate()
order by created_at desc;

SELECT * FROM (
  SELECT *,
         LEAD(transaction_date) OVER (ORDER BY transaction_date) AS next_timestamp
  FROM trans_hdr
) next_timestamp
WHERE TIMESTAMPDIFF(SECOND, transaction_date, next_timestamp) <= 30
and date(transaction_date) >= '2023-07-01'
and transaction_type = 'EWALLET'
and points_burned > 1
order by transaction_date desc;

SELECT count(*) FROM trans_hdr
WHERE transaction_type = 'ACTIVITY'
AND points_earned = 300;

select opening_hours , mp.* from mst_partner mp where partner_id ='326394';

select DISTINCT email, phone_no from mst_member
where phone_no in (select phone_no from mst_member
group by phone_no
having count(*) > 1);

select * from mst_merchant
where partner_category = 'groceries'
and store_type = 'merchant'
and partner_sub_category != 'FMCG';

select * from mst_member
-- WHERE (phone_no like '%81261199330%' or phone_no like '%08170140486%' or phone_no like '%081210347070' or phone_no like '%082246839050%' or phone_no like '%85624554462%');
where email like '%guestgetplus%';

select cardno, username, score , spent from mst_member
where spent > score;

SELECT th.customer, mm.email, mm.point_balance, mm.score, mm.spent, mm.reserved, th.transaction_date , th.transaction_ref, th.transaction_type, 
th.transaction_date, th.partner_name, th.total, th.created_at, th.points_earned, th.points_burned, th.source, th.status 
from trans_hdr th 
left join mst_member mm on th.customer = mm.cardno
where th.customer in ('6194420240511170335', '6194420240511035030', '6194420240510145523');

select mm.email, mm.phone_no, mm.first_name as 'name', th.points_burned as 'Poin GetPlus', th.partner_name from mst_member mm
left join trans_hdr th on mm.cardno = th.customer 
where mm.email like '%gpitesuat%'
and th.source_channel like '%map%'
order by th.created_at desc;

select th.* from trans_hdr th 
where partner_name = 'BCA Rewards'
and status = 'failed'
and lower(notes) like '%"title":"BCA Rewards","description":"Convert berhasil, poin sudah ditambahkan"%';

SELECT mm.email, mr.* from mst_registrations mr
left join mst_member mm on mr.cardno = mm.cardno
where mr.phone_verified = 1 and mr.email_verified = 1 and mr.is_verified = 0
and mm.email is NULL
and mr.email like '%gpites%';

select * from mst_sku
where partner_name like '%Blibli%';

select store_parent, store_parent_name, count(store_parent) from mst_merchant mm
where store_type = 'OUTLET'
group by store_parent
having count(store_parent) = 1;

select partner_name, min_trans from mst_merchant
where min_trans != 0;

SELECT mm.email, th.* from trans_hdr th
left join mst_member mm on th.customer = mm.cardno
where th.partner_name = 'BCA Rewards'
and mm.email = 'jeanetelleng+gpitest13@gmail.com'
ORDER by th.created_at DESC ;

select count(th.transaction_id), mm.email, mm.phone_no, th.customer, th.transaction_type, th.partner_name from trans_hdr th
left join mst_member mm on th.customer = mm.cardno
WHERE th.transaction_type = 'EWALLET'
and date(th.transaction_date) >= '2024-03-13'
group by th.customer , th.partner_name 
having count(th.transaction_id) > 20
order by th.created_at desc;