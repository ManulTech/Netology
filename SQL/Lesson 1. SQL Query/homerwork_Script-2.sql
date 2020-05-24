select first_name || ' ' || last_name as "Full Name", activebool, active
from customer c 
where active = '0' order by "Full Name";

select title from film f 
where release_year = '2006'

select amount, payment_date from payment p 
order by payment_date desc
limit 10


select table_catalog, constraint_name, table_name 
from information_schema.table_constraints
where constraint_catalog = 'dvd-rental' and constraint_type = 'PRIMARY KEY'

