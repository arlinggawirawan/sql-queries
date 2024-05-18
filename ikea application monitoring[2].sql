
-- 8pm yesterday to 8am today

select loan_number, user_id, state, applied_at, second_prod_code, amount as applied_amount, tenor as applied_tenor
from komodo.loans 
where promotion_code='MAUIKEA'
and applied_at>=concat(date(curdate())-interval 1 day,' ','20:00:00')
and applied_at<concat(date(curdate()),' ','08:00:00');

-- 8am today to 12pm today

select loan_number, user_id, state, applied_at, second_prod_code, amount as applied_amount, tenor as applied_tenor
from komodo.loans 
where promotion_code='MAUIKEA'
and date(applied_at)=date(curdate())
and time(applied_at)>='08:00:00' and time(applied_at)<'12:00:00'; 

-- 12pm today to 4pm today

select loan_number, user_id, state, applied_at, second_prod_code, amount as applied_amount, tenor as applied_tenor
from komodo.loans 
where promotion_code='MAUIKEA'
and date(applied_at)=date(curdate())
and time(applied_at)>='12:00:00' and time(applied_at)<'16:00:00'; 

-- 4pm today to 8pm today

select loan_number, user_id, state, applied_at, second_prod_code, amount as applied_amount, tenor as applied_tenor
from komodo.loans 
where promotion_code='MAUIKEA'
and date(applied_at)=date(curdate())
and time(applied_at)>='16:00:00' and time(applied_at)<'20:00:00';
