SELECT a.loan_number, a.state, b.auth_type, b.status, a.applied_at
FROM komodo.loans a
left join
komodo.auth_logs b on a.user_id = b.user_id
where b.auth_type in
('bpjs', 'bcabank', 'mandiri', 'bni', 'bribank', 'cimb')
and a.applied_at >= '2020-08-01'
and a.applied_at <= '2020-08-31';