select 
	f.title,
	l.name
from 
	film f
inner join "language" l on f.language_id = l.language_id;

select 
	f.title,
	a.first_name || ' ' || a.last_name as "Actors"
from 
	actor a
inner join film_actor f_a on a.actor_id = f_a.actor_id
inner join film f on f_a.film_id = f.film_id 
where f.film_id = 508
order by "Actors" asc

select 
	count(actor_id)
from 
	film_actor
where
	film_id = 384
	
select
	f.title,
	count(f_a.actor_id) as "Amount of actors"
from 
	film f
inner join film_actor f_a on f.film_id = f_a.film_id
group by f.title
having count(f_a.actor_id) > 10
	
select 
	f.title,
	a.first_name || ' ' || a.last_name as "Actor name",
	count(f_a.film_id) over (partition by a.first_name || ' ' || a.last_name) as "Starred in movies amount" ---бнопня!!!
from 
	film f
inner join film_actor f_a on f_a.film_id = f.film_id
inner join actor a on a.actor_id = f_a.actor_id	


select 
	a.first_name || ' ' || a.last_name as "Actor name",
	f_a.actor_id as actor_id,
	f.film_id
from 
	actor a
inner join film_actor f_a on a.actor_id = f_a.actor_id	
inner join film f on f_a.film_id = f.film_id

	
	
 