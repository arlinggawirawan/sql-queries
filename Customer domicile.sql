select up.user_id, upa.postcode, upa.city, upa.province from
	(select up.id, up.user_id				
	from komodo.user_profiles up)up
left join
	(select addresses.location_id,ir.province,ir.city,ir.area,ir.village,ir.postcode, addresses.street_line 
    from addresses 
	left join indo_regions ir 
    on (addresses.province_id = ir.province_id and addresses.city_id = ir.city_id 
    and addresses.area_id = ir.area_id and addresses.village_id = ir.village_id)
	where location = 'work_profiles')upa
on up.id = upa.location_id