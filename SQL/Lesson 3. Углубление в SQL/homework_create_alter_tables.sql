--Основная часть:
--Спроектируйте базу данных для следующих сущностей:
--язык (в смысле английский, французский и тп)
--народность (в смысле славяне, англосаксы и тп)
--страны (в смысле Россия, Германия и тп)

DROP TABLE nation_vs_lang_komin

create table nation_komin(
	nation_id serial primary key,
	nation varchar(50) not null
)

create table lang_komin(
	lang_id serial primary key,
	lang varchar(50) not null
)

create table country_komin(	
	country_id serial primary key,
	country varchar(50) not null
)

create table nation_vs_lang_komin(
	nation_id integer not null unique,
	lang_id integer not null unique,
	FOREIGN KEY (nation_id)  REFERENCES nation_komin (nation_id),
	FOREIGN KEY (lang_id)  REFERENCES lang_komin (lang_id)
)

create table nation_vs_country_komin(
	nation_id integer not null unique,
	country_id integer not null unique,
	FOREIGN KEY (nation_id)  REFERENCES nation_komin (nation_id),
	FOREIGN KEY (country_id)  REFERENCES country_komin (country_id)
)

insert into nation_komin
(nation)
values 
('Russian'),
('French'),
('German'),
('Ukraine'),
('Italian')

insert into lang_komin
(lang)
values 
('Russian'),
('French'),
('German'),
('Ukraine'),
('Italian')

insert into country_komin 
(country)
values 
('Russia'),
('France'),
('Germany'),
('Ukraine'),
('Italy')

insert into nation_vs_lang_komin 
(nation_id, lang_id)
values 
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5)

insert into nation_vs_country_komin 
(nation_id, country_id)
values 
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5)

select * from nation_vs_lang_komin

select * from nation_vs_country_komin

-----BONUS:
ALTER TABLE nation_komin 
	ADD COLUMN something_1 timestamp;
	ADD COLUMN something_2 bool;
	ADD COLUMN something_2 text;

-----adding constraints in existing table:
ALTER TABLE nation_komin ADD CONSTRAINT some_constraint_name FOREIGN KEY (some_existing_column_name) REFERENCES some_table_nema (some_existing_column_name);


