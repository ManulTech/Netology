SELECT 
	userId,
	movieId,
	rating,
row_number() OVER (PARTITION BY userId ORDER BY rating DESC) AS movie_rank
FROM (
	SELECT DISTINCT
		userId, 
		movieId, 
		rating
	from 
		ratings
	WHERE
		userId <> 1 LIMIT 100
	)
	AS sample
ORDER BY 
	userId,
	rating DESC,
	movie_rank

select * from ratings

select
	title,
	first_name || ' '|| last_name as full_name,
	count(f.film_id) over (partition by f.film_id) as movies_count 	
from film f
join film_actor as fa on f.film_id = fa.film_id 
join actor as a on fa.actor_id = a.actor_id 
order by movies_count desc

-----
with cte_name (column_list) as (
	cte_query_definition
	)
statement ;
----

with recursive r as (...)
select 	
	1 as i,
	1 as factorial
union
	select
	 	i + 1 as i,
	 	factorial  (i + 1) as factorial 
	from r
	where
		i < 10
	)

	select * from r

	
with sold_by_person as (
	select
		first_name || ' '|| last_name as full_name,
		count (p.amount)
	from 
		staff s
join payment p on p.staff_id = s.staff_id
group by full_name)
select *
--	full_name
--	amount
from 
	sold_by_person
--group by full_name

drop view view_name

create or replace view view_name as (
	select 
		c.first_name || ' '|| c.last_name as full_name,
		c.email,
		f.title,
		i.film_id,
		max(r.last_update)
		from customer as c
	join rental as r using (customer_id)
	join inventory as i using (inventory_id)
	join film as f using (film_id)
	group by (full_name, c.email, f.title, i.film_id, r.last_update)
--	where r.last_update = (select max(r.last_update) from rental as r) 
)
	
select * from view_name

select r.last_update from rental as r

create materialized view some_view as (
select 
)
with data

drop materialized some_view

select 
 film_id,
 count(*) rating
 from film f 
 where f.film_id > 100
 group by film_id
 
 select rating from film f 
 
 select 
 	customer_id,
 	rental_date,
 	row_number() over (partition by customer_id order by rental_date desc) as rental_number 	 
 from rental
 join inventory as i using (inventory_id)
 join film as f using (film_id)
 order by customer_id desc 
 
 with create materialized view my_view as (
 select
 	c.customer_id,
 	count(f.film_id),
 	f.special_features
 from 
 	customer as c
 join 
 	staff s using(staff_id)
 )

 
 select
	c.customer_id,
 	sum(r.rental_id) as rental_amount
 from 
 	customer as c
 join rental as r using(customer_id)
 join inventory as i using(inventory_id)
 join film as f using(film_id)
 where 'Behind the Scenes'  = any (f.special_features)
 group by (c.customer_id, f.special_features)
 order by customer_id desc