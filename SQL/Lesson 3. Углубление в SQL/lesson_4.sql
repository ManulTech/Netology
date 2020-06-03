--Создать другую схему
create schema book_store;

--Сменить схему
set search_path to book_store;


CREATE TABLE author(
	author_id Serial PRIMARY KEY,
	full_name varchar(30) NOT null,
	nickname varchar(30),
	born_date date not null
);


create table book(
	book_id serial primary key,
	book_name varchar(100) not null,
	pub_year int,
	check (pub_year > 0)
);





insert into author 
(full_name, nickname, born_date)
values 
('Жюль Габриэ́ль Верн', null, '08.02.1828'),
('Михаи́л Ю́рьевич Ле́рмонтов', 'Гр. Диарбекир', '03.10.1814'),
('Харуки Мураками', null, '12.01.1949');

select * from public.film f ;

insert into book
(book_name, pub_year)
values
('Двадцать тысяч льё под водой', 1916),
('Бородино', 1837),
('Герой нашего времени', 1840),
('Норвежский лес', 1980),
('Хроники заводной птицы', 1994);

insert into book
(book_name, pub_year)
values
('Двадцать тысяч льё под водой', -1916);



alter table author 
add column born_place varchar(150);

alter table book 
add column author_id int;

--alter table author 
--drop column born_place;

alter table book 
add constraint book_author foreign key (author_id) references author(author_id);


alter table автор
add column книга_айди int;

alter table автор
add column дополнение varchar(100);

alter table автор
add constraint автор_бук foreign key (книга_айди) references book(book_id);

alter table автор
add constraint автор_бук_2 foreign key (дополнение) references book(book_name);


update author
set born_place = 'Франция';

update author
set born_place = 'Российская империя'
where author_id in (2, 3);

update author
set born_place = 'Япония 2'
where (author_id = 3) and (full_name like '%Мураками%');



update book 
set author_id = 1
where book_id = 1

update book 
set author_id = 2
where book_id in (2, 3)

update book 
set author_id = 3
where book_id not in (1, 2, 3)


select *
from book b 
join author a on a.author_id = b.author_id ;


delete from book 
where author_id = 1;

delete from author 
where author_id = 1;

delete from book;
delete from author ;

select * from book b;
select * from author a ;

drop table book ;
drop table author ;


create table orders (
	order_id serial primary key,
	info json not null
)

select * from orders;


INSERT INTO orders (info)
VALUES
 (
'{ "customer": "John Doe", "items": {"product": "Beer","qty": 6}}'
 ),
 (
'{ "customer": "Lily Bush", "items": {"product": "Diaper","qty": 24}}'
 ),
 (
'{ "customer": "Josh William", "items": {"product": "Toy Car","qty": 1}}'
 ),
 (
'{ "customer": "Mary Clark", "items": {"product": "Toy Train","qty": 2}}'
 );


select info -> 'customer'
from orders;

select order_id, info ->> 'customer'
from orders
where order_id = 1;


select avg((info -> 'items' ->> 'qty')::int)
from orders;


select film_id, special_features 
from public.film
order by film_id ;



select film_id, unnest(special_features)
from public.film
order by film_id ;


select film_id, special_features, array_length(special_features, 1)
from public.film
order by film_id ;



select film_id, special_features, array_length(special_features, 1)
from public.film
where special_features <@ array['Trailers', 'Deleted Scenes']
order by film_id ;


select film_id, special_features, array_length(special_features, 1)
from public.film
where special_features @> array['Trailers', 'Deleted Scenes']
order by film_id ;


select film_id, special_features, array_length(special_features, 1)
from public.film
where special_features = array['Trailers', 'Deleted Scenes']
order by film_id ;

select film_id, array_append(special_features, 'Val'), array_length(special_features, 1)
from public.film
where special_features = array['Trailers', 'Deleted Scenes']
order by film_id ;

select film_id, unnest(special_features)
from public.film
order by film_id ;
