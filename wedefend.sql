SELECT distinct user_id, channel, status,
date(created_at)created_at
FROM komodo.auth_logs
where date(created_at) = '2020-07-17'
and channel = 'wedefend'
and status = 'pass';