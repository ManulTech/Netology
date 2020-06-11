--сделайте запрос к таблице rental. Используя оконую функцию добавьте колонку с порядковым номером аренды для каждого пользователя (сортировать по rental_date)

select 
	customer_id,
	rental_id,
	row_number() over (partition by customer_id order by rental_date asc) as order_number
from 
	rental r
order by 
	customer_id desc,
	order_number desc

--для каждого пользователя подсчитайте сколько он брал в аренду фильмов со специальным атрибутом Behind the Scenes
drop materialized view my_view

create materialized view my_view as(
select 
	c.customer_id,
	f.special_features,
	r.rental_id as rental_amount
from 
	customer c
join rental as r using(customer_id)
join inventory as i using(inventory_id)	
join film as f using(film_id)
--group by c.customer_id, f.special_features
order by c.customer_id desc
)

select * from my_view

---------1--------
select 
	customer_id,
	count(rental_amount) as rental_amount
from my_view
where 'Behind the Scenes' = any(special_features)
group by customer_id
order by customer_id desc

---------2--------
select 
	customer_id,
	count(rental_amount) as rental_amount
from my_view
where array_to_string(special_features, ',') like '%Behind the Scenes%' 
group by customer_id
order by customer_id desc

---------3--------
select 
	customer_id,
	count(rental_amount)
from my_view
where 
	special_features[1] = 'Behind the Scenes' or
	special_features[2] = 'Behind the Scenes' or
	special_features[3] = 'Behind the Scenes' or
	special_features[4] = 'Behind the Scenes'
group by customer_id
order by customer_id desc

--select customer_id, unnest(special_features) as "Behind the scenes" from my_view

refresh materialized view my_view

drop materialized view my_view

----additional task------
select 
	distinct cu.customer_id as name, 
	count(rental_id) over (partition by cu.customer_id)
from customer cu
join rental as r on r.customer_id = cu.customer_id
join inventory as i on i.inventory_id = r.inventory_id
join film as f on f.film_id = i.film_id 
where 'Behind the Scenes' = any(special_features)
order by count desc


explain select distinct cu.first_name  || ' ' || cu.last_name as name, 
	count(ren.iid) over (partition by cu.customer_id)
from customer cu
full outer join 
	(select *, r.inventory_id as iid, inv.sf_string as sfs, r.customer_id as cid
	from rental r 
	full outer join 
		(select *, unnest(f.special_features) as sf_string
		from inventory i
		full outer join film f on f.film_id = i.film_id) as inv 
		on r.inventory_id = inv.inventory_id) as ren 
	on ren.cid = cu.customer_id 
where ren.sfs like '%Behind the Scenes%'
order by count desc