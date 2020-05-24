--выведите магазины, имеющие больше 300-от покупателей
select 
	count(customer_id) as "Amount of customers",
	store_id
from 
	customer
group by store_id
having count(customer_id) > 300

---выведите у каждого покупател€ город в котором он живет
select
	first_name || ' ' || last_name as "Full Name",
	city
from 
	city c
inner join address addr on c.city_id = addr.city_id 
inner join customer cst on addr.address_id = cst.address_id 

--выведите ‘»ќ сотрудников и города магазинов, имеющих больше 300-от покупателей
select
	first_name || ' ' || last_name as "Full Name",
	city 	
from 
	staff as stf
inner join address addr on stf.address_id = addr.address_id 
inner join city on addr.city_id = city.city_id 
where 
	store_id = (
	select 
		store_id 
	from 
		customer
	group by store_id 
	having count(customer_id) > 300
	)

---выведите количество актеров, снимавшихс€ в фильмах, которые сдаютс€ в аренду за 2,99
select 
	f.title,
	f.rental_rate,
	count(actor_id)
from 
	film f
inner join film_actor f_a on f.film_id = f_a.film_id 
where
	f.rental_rate = 2.99
group by f.title, f.rental_rate
