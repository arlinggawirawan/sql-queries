#by mobile phone
SELECT lo.loan_number, lo.state,lo.applied_at,lo.rejected_at,kup.name,kup.nik,kup.mobile,kup.email, abc.created_at 
FROM approval.approval_black_account abc
JOIN komodo.user_profiles kup ON kup.mobile=abc.account
JOIN komodo.loans lo ON lo.user_id=kup.user_id 
WHERE abc.type='1'

#by bank acct
SELECT lo.loan_number, lo.state,lo.applied_at,lo.rejected_at,kup.name,kup.nik,kup.mobile,kup.email, abc.created_at 
FROM approval.approval_black_account abc
LEFT JOIN (SELECT *,CONCAT(bank_code,"&",bank_account_number,"&",bank_account_holder_name) acct FROM finance.finance_user_bankcard) fub ON abc.account=fub.acct
JOIN komodo.user_profiles kup ON fub.user_id=kup.user_id
JOIN komodo.loans lo ON lo.user_id=kup.user_id 
WHERE abc.type='2'

#from asli backtest
SELECT lo.loan_number, lo.state,lo.applied_at,lo.rejected_at,kup.name,kup.nik,kup.mobile,kup.email
FROM komodo.user_profiles kup 
JOIN komodo.loans lo ON lo.user_id=kup.user_id 
WHERE kup.nik IN 
('3272020107940041',
'6271011405920003',
'3175080309771001',
'3205016609750001',
'3521114510910005',
'3174091109800001',
'3273224508810001',
'3273120511870005',
'3173071201890003',
'3274030810830004',
'3375031806880001',
'3273234908890004',
'3671014511860006',
'1671040910810013',
'3314096911970004',
'3278064312980003',
'1271114908800001',
'3275061209690002',
'3172037004970004',
'3215016504950003',
'3603112906570001',
'7371062603980003',
'1271181410810001')

select * from komodo.loans where loan_number='20010915311144241140706'
