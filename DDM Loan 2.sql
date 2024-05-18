select kl.user_id, kl.loan_number, kl.second_prod_code as sub_loan_type,
case when kl.second_prod_code like 'old%' then 'RO User' else 'New User' end as customer_type,
kl.state as loan_status, kl.approved_amount, kl.approved_tenor,
CASE 
	WHEN wp.salary_method = '13' THEN 'Bulanan'
    WHEN wp.salary_method = '12' THEN 'Dua Kali Sebulan'
    WHEN wp.salary_method = '11' THEN 'Mingguan'
    WHEN wp.salary_method = '10' THEN 'Harian'
    END AS cycle_gajian
, wp.salary_day as tanggal_gajian, 
	CASE
		WHEN wp.occupation = '1' THEN 'Pemilik Usaha'
		WHEN wp.occupation = '2' THEN 'ABRI'
        WHEN wp.occupation = '3' THEN 'Pengacara'
        WHEN wp.occupation = '4' THEN 'Pegawai Swasta'
        WHEN wp.occupation = '5' THEN 'Pegawai Negeri'
        WHEN wp.occupation = '6' THEN 'Lain-Lain'
        WHEN wp.occupation = '7' THEN 'Ibu Rumah Tangga'
        WHEN wp.occupation = '8' THEN 'Petani'
        WHEN wp.occupation = '9' THEN 'Nelayan'
		WHEN wp.occupation = '10' THEN 'Seniman'
        WHEN wp.occupation = '11' THEN 'Pensiunan/Purnawirawan'
        WHEN wp.occupation = '12' THEN 'Pelayaran/Pelaut'
        WHEN wp.occupation = '13' THEN 'Guru/Pendidikan'
        WHEN wp.occupation = '14' THEN 'Jasa'
		WHEN wp.occupation = '15' THEN 'Dokter/Bidan/Mantri'
		WHEN wp.occupation = '16' THEN 'Ojek Motor'
        WHEN wp.occupation = '17' THEN 'Sopir'
		WHEN wp.occupation = '18' THEN 'Peternak'
		WHEN wp.occupation = '19' THEN 'Pelajar/Mahasiswa'
		WHEN wp.occupation = '20' THEN 'Buruh/PRT'
		WHEN wp.occupation = '21' THEN 'Pengrajin Tangan'
		WHEN wp.occupation = '23' THEN 'Pedagang'
		WHEN wp.occupation = '24' THEN 'Produksi'
        WHEN wp.occupation = '26' THEN 'Sewa/Rent'
		WHEN wp.occupation = '27' THEN 'Transportasi & Komunikasi'
        WHEN wp.occupation = '28' THEN 'Hiburan'
		WHEN wp.occupation = '29' THEN 'Pendidikan Non Formal'
        WHEN wp.occupation = '30' THEN 'Hotel'
		WHEN wp.occupation = '31' THEN 'Perangkat Desa'
        WHEN wp.occupation = '32' THEN 'TNI/Polri'
		WHEN wp.occupation = '33' THEN 'Atlet'
		WHEN wp.occupation = '34' THEN 'Pengobatan Alternatif'
        WHEN wp.occupation = '35' THEN 'Jurnalis / Wartawan'
		WHEN wp.occupation = '36' THEN 'Wartawan'
        WHEN wp.occupation = '37' THEN 'Profesi'
		WHEN wp.occupation = '38' THEN 'Pekerja Lepas'
	END AS tipe_pekerjaan,
	CASE
		WHEN wp.employment_status = '10' THEN 'Tetap'
        WHEN wp.employment_status = '11' THEN 'Kontrak'
        WHEN wp.employment_status = '12' THEN 'Outsourcing'
        WHEN wp.employment_status = '13' THEN 'Pekerja Lepas'
        WHEN wp.employment_status = '14' THEN 'Pemilik Usaha'
	END AS status_karyawan,
    CASE
		WHEN wp.industry = '10' THEN 'Perdagangan Eceran / Grosir'
        WHEN wp.industry = '11' THEN 'Perbankan / Keuangan / Asuransi / Investasi'
        WHEN wp.industry = '12' THEN 'Manufaktur'
        WHEN wp.industry = '13' THEN 'Properti / Konstruksi'
        WHEN wp.industry = '14' THEN 'Pertambangan / Minyak / Gas'
        WHEN wp.industry = '15' THEN 'Pendidikan'
        WHEN wp.industry = '16' THEN 'Telekomunikasi'
        WHEN wp.industry = '17' THEN 'Pariwisata / Hotel / Perhotelan'
        WHEN wp.industry = '18' THEN 'Angkutan'
        WHEN wp.industry = '19' THEN 'PNS (Pemerintah)'
        WHEN wp.industry = '20' THEN 'Konsultan / Akuntansi / Jasa Profesional'
        WHEN wp.industry = '21' THEN 'BUMN (Badan Usaha Milik Negara)'
        WHEN wp.industry = '22' THEN 'Perkebunan / Pertanian'
        WHEN wp.industry = '23' THEN 'TNI / Polisi (Militer / Polisi)'
        WHEN wp.industry = '24' THEN 'Hukum'
        WHEN wp.industry = '25' THEN 'Teknologi'
        WHEN wp.industry = '26' THEN 'Media / Hiburan'
        WHEN wp.industry = '27' THEN 'Pemasaran iklan'
        WHEN wp.industry = '28' THEN 'Makanan & Minuman'
        WHEN wp.industry = '29' THEN 'Layanan medis'
        WHEN wp.industry = '30' THEN 'Perikanan'
	End as jenis_industry,
ui.created_at as tgl_registration, kl.applied_at as tgl_application, kl.disbursed_at as tgl_disbursement,
frt.repayment_at as tgl_actual_repayment, fdu.total_outstanding,
	CASE
		When loi.overdue_days is null Then 0
        else loi.overdue_days
	End As DPD, loi.last_overdue_date
from komodo.loans kl
left join
komodo.work_profiles wp on wp.user_id = kl.user_id
left join
user.user_info ui on ui.id = kl.user_id
left join
finance.finance_repayment_track frt on frt.loan_number = kl.loan_number
left join
finance.loan_overdue_info loi on loi.loan_number = kl.loan_number
left join														
	(select loan_id,													
	sum(principal_amount)+sum(admin_fee_amount)+sum(fund_interest_amount)+sum(service_fee_amount) 													
	as amount,													
	sum(principal_pay)+sum(admin_fee_pay)+sum(fund_interest_pay)+sum(service_fee_pay) 													
	as amount_paid, 													
	sum(principal_unpay)+sum(admin_fee_unpay)+sum(fund_interest_unpay)+sum(service_fee_unpay) as total_outstanding,													
	sum(principal_unpay)principal_outstanding,sum(admin_fee_unpay)admin_fee_outstanding,													
	sum(fund_interest_unpay)fund_interest_outstanding,sum(service_fee_unpay)service_fee_outstanding													
	from finance.finance_dues													
	group by loan_id)fdu													
on kl.loan_number=fdu.loan_id
where date(kl.approved_at) between '2020-08-31' and '2020-10-12'
and kl.rejected_at is null