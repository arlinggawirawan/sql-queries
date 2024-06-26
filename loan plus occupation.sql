SELECT l.user_id, l.loan_number, l.state, l.rejected_at, l.not_approved_desc,
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
	END AS Occupation
FROM komodo.loans l
Inner join
komodo.work_profiles wp on l.user_id = wp.user_id
where l.state = 'rejected'
