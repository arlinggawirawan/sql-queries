select b.fund_code, a.state, FORMAT(sum(a.approved_amount) ,'#') amount
from komodo.loans a
join fund.fund_base_info b
on a.lender_id = b.id
where a.lender_id in (3,5,7)
group by b.fund_code, a.state;