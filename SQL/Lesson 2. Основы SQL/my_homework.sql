select 
	count(customer_id),
	store_id
from 
	customer
group by store_id
having count(customer_id) > 300

select
	first_name || ' ' || last_name as "Full Name",
	city
from 
	city c
inner join address addr on c.city_id = addr.city_id 
inner join customer cst on addr.address_id = cst.address_id 

