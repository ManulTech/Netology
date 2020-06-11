

explain with staff_rental as (
	select rental_id, s.first_name || ' ' || s.last_name as staff_name
	from rental r
	join staff s on s.staff_id = r.staff_id
)
select sr.staff_name, count(rental_id) 
from staff_rental sr
group by sr.staff_name;


explain WITH cte_rental AS (
    SELECT staff_id,
        COUNT(rental_id) rental_count
    FROM   rental
    GROUP  BY staff_id
)
SELECT s.staff_id,
    first_name,
    last_name,
    rental_count
FROM staff s
    INNER JOIN cte_rental USING (staff_id);
   
   

select 1 as i, 1 as factorial
union
select 1 as i, 1 as factorial

select 1 as i, 1 as factorial
union 
select 2 as i, 1 as factorial
union all
select 1 as a, 1 as fact




with recursive r as (
	select 1 as i, 1 as factorial
	union
	
	select i+1 as i, factorial * (i+1)  as factorial
	from r
	where i < 10
)
select * from r;



	
with r as (
	select 1 as i, 1 as factorial
	union
	select 1+1 as i, 1 * (1 + 1) as factorial
	union
	select 2+1 as i, 2 * (2 + 1) as factorial
	union
	select 3+1 as i, 6 * (3 + 1) as factorial
)
select i+1 as i, factorial * (i+1)  as factorial
from r
where i < 10
union 
select 1 as i, 1 as factorial



select 1 as i, 1 as factorial
union
select 1+1 as i, 1 * (1 + 1) as factorial
union
select 2+1 as i, 2 * (2 + 1) as factorial
union
select 3+1 as i, 6 * (3 + 1) as factorial

with f as (
select 10 as i, 777 as factorial
)
select *
from f
where i = 10



with customer_film as (
select c.first_name || ' ' || c.last_name as customer_name, c.email,
f.title, row_number() over (partition by c.customer_id order by r.rental_date desc) as rn
from customer c 
join rental r on r.customer_id = c.customer_id 
join inventory i on r.inventory_id = i.inventory_id 
join film f on i.film_id = f.film_id 
)
select customer_name, email, title 
from customer_film
where rn = 1;



create view last_film as (
select cu.last_name ||' '||cu.first_name as full_name, fi.title, cu.email 
from customer cu
join rental re using (customer_id)
join inventory inv using (inventory_id)
join film fi using (film_id)
where re.rental_date = (select max (rental_date) from rental r2 where r2.customer_id = re.customer_id )
order by full_name
);



create view customer_last_film 
as
(
	with customer_film as (
	select c.first_name || ' ' || c.last_name as customer_name, c.email,
	f.title, row_number() over (partition by c.customer_id order by r.rental_date desc) as rn
	from customer c 
	join rental r on r.customer_id = c.customer_id 
	join inventory i on r.inventory_id = i.inventory_id 
	join film f on i.film_id = f.film_id 
	)
	select customer_name, email, title 
	from customer_film
	where rn = 1
)


select *
from public.customer_last_film 


create materialized view customer_last_film_mat 
as
(
	with customer_film as (
	select c.first_name || ' ' || c.last_name as customer_name, c.email,
	f.title, row_number() over (partition by c.customer_id order by r.rental_date desc) as rn
	from customer c 
	join rental r on r.customer_id = c.customer_id 
	join inventory i on r.inventory_id = i.inventory_id 
	join film f on i.film_id = f.film_id 
	)
	select customer_name, email, title 
	from customer_film
	where rn = 1
)


select * 
from customer_last_film_mat


refresh materialized view customer_last_film_mat;

drop materialized view customer_last_film_mat;
drop view customer_last_film;

select * from film f 