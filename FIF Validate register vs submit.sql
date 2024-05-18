select count(a.mobile)registered, sum(case when b.mobile is not null then 1 else 0 end)third_party_submitted,
sum(case when a.state=2 then 1 else 0 end)submitted
from
(select distinct mobile, state from komodo.fif_user_data)a
left join
(select distinct b.mobile from
(select distinct user_id from komodo.auth_logs)a
left join
(select * from komodo.user_profiles)b
on a.user_id=b.user_id)b
on a.mobile=b.mobile;