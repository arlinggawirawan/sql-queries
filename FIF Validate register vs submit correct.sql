-- fif_user_data.org_id = 12  is FIF Insigh ,  fif_user_data.org_id = 11 is SKA
-- fif_user_data.user_id is not null or fif_user_data.state > 0 which means it is registered
-- fif_user_data.state = 2 which means it is submitted
SELECT
 count( kf.user_id ) AS registered,
 count( DISTINCT ka.user_id ) AS third_party_submitted,
 sum(IF(kf.state = 2,1,0) ) submitted 
FROM
 komodo.fif_user_data kf
 LEFT JOIN komodo.auth_logs ka ON kf.user_id = ka.user_id 
WHERE
 kf.org_id = 12