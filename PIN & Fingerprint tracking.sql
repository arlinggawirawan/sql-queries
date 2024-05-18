Select COUNT(user_id)total_user_active_pin,
(Select COUNT(user_id)total_user_active_fingerprint
    from user.user_pin
    where fingerprint_state = '1') as total_user_active_fingerprint
    from user.user_pin
    where pin_state = '1'