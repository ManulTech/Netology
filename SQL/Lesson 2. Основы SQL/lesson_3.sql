select f.title, f.description, l."name" 
from film f join "language" l on f.language_id = l.language_id;

select f.title, f.description, f.language_id, l.language_id,  l."name" 
from film f right join "language" l on f.language_id = l.language_id;


select *
from "language" l;


select f.title, a.first_name || ' ' || a.last_name as actor_name
from film f
join film_actor fa on fa.film_id = f.film_id 
join actor a on a.actor_id = fa.actor_id
order by f.title;


select avg(rental_duration)
from film f;

select count(*)
from film f;

select sum(rental_duration)
from film f;



select f.rating, avg(f.rental_rate / f.rental_duration)
from film f
group by f.rating;



select a.first_name || ' ' || a.last_name as actor_name, count(f.film_id) 
from film f
join film_actor fa on fa.film_id = f.film_id 
join actor a on a.actor_id = fa.actor_id
group by a.actor_id;



select avg(f.rental_rate / f.rental_duration)
from film f;


select f.title, f.rental_rate / f.rental_duration as daily_rental_rate
from film f
where f.rental_rate / f.rental_duration > (select avg(f.rental_rate / f.rental_duration) from film f)
order by daily_rental_rate asc;


select f.title, f.rental_rate / f.rental_duration as daily_rental_rate
from film f
where f.rental_rate / f.rental_duration > (select 1)
order by daily_rental_rate, f.title ;


select f.title, f.rental_rate / f.rental_duration as daily_rental_rate
from film f
where f.rental_rate / f.rental_duration > 1
order by daily_rental_rate asc;



select f.title, f.description, a.first_name || ' ' || a.last_name as actor_name,
	count(f.film_id) over (partition by a.actor_id ) as films_count
from film f
join film_actor fa on fa.film_id = f.film_id 
join actor a on a.actor_id = fa.actor_id;

-- ФУНКЦИЯ_ПРИМЕНЯЕМАЯ_К_ОКНУ over (partition by СТОЛБЕЦ_ПО_КОТОРОМУ_ФОРМИРУЕТСЯ ОКНО )
-- ОКНО - АНАЛОГ ГРУППИРОВКИ, ТОЛЬКО МОЖНО ОТОБРАЗИТЬ РЕЗУЛЬТАТ В КАЖДОЙ СТРОКЕ ГРУППЫ


select f.title, f.description, count(a.actor_id) as actors_count
from film f
join film_actor fa on fa.film_id = f.film_id 
join actor a on a.actor_id = fa.actor_id
group by f.title, f.description
order by actors_count desc
limit 5;



select f.title, f.description, a.first_name || ' ' || a.last_name as actor_name,
	count(a.actor_id) over (partition by f.film_id) as actors_count
from film f
join film_actor fa on fa.film_id = f.film_id 
join actor a on a.actor_id = fa.actor_id
order by actors_count desc;


