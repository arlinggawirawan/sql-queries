select c.mobile, a.*
from finance.loan_coupon a
join komodo.loans b on a.loan_number = b.loan_number
join user.user_info c on b.user_id = c.id
where a.loan_number  not in
(select loan_number from finance.finance_repayment_track where promotion_code = 'SAYANG2_JUN1')
and a.promotion_code = 'SAYANG2_JUN1';