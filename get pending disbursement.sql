select count(*)
from (SELECT DISTINCT t.* , gr.request_param, gr.request_url, gr.response_body
from (
SELECT l.loan_number, l.state , l.amount , pg.thirdparty_id from komodo.loans l , pay_gateway.gateway_task pg
where l.loan_number = pg.loan_num
and pg.`status` = 3
and pg.type = 6
and l.state = 'in_disbursed' ) t ,  pay_gateway.gateway_task gt , pay_gateway.gateway_request gr
where t.thirdparty_id = gt.thirdparty_id
and gt.`status` = 4
and gt.task_id = gr.task_id
and gr.request_url != '/H2H/getpaymentstatus?access_token={token}') xx;