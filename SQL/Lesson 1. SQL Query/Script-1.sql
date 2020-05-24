select title, description, round(rental_rate / rental_duration, 4) as "cost_rental"	
from film f
order by Cost_rental desc, title asc;

select title, description, round(rental_rate / rental_duration, 4) as "cost_rental"	
from film f
order by Cost_rental desc, title asc
limit 10;

select title, description, round(rental_rate / rental_duration, 4) as "cost_rental"	
from film f
order by Cost_rental desc, title asc
limit 10
offset 3;

select distinct  first_name, last_name 
from customer c;

select first_name || ' ' || last_name as "Full Name"
from customer c;

select title, rating, description, release_year
from film f 
where rating = 'PG-13';

select title, description, round(rental_rate / rental_duration, 4) as "cost_rental"	
from film f
where round(rental_rate / rental_duration, 4) > 0.8
order by Cost_rental asc, title asc;

select title, rating, description, release_year
from film f 
where rating::varchar like 'PG%';

select title, rating, description, release_year
from film f 
where rating::varchar similar to 'PG+';

select title, last_update, description 
from film f 
where last_update between '2013-05-26' and '2013-05-27'
order by last_update desc
