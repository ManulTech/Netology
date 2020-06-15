--В каких городах больше одного аэропорта?
-- -> достаёт по ключу ru название города, having используется вместо where потому что аггрегирующая функция
select 
	city ->> 'ru' as city,
	count(airport_name) as airports_amount
from airports_data
group by city
having count(airport_name) > 1
order by airports_amount desc

--В каких аэропортах есть рейсы, которые обслуживаются самолетами с максимальной дальностью перелетов?
--Так кака названия аэропортов и дальность полётов хранятся в разных таблицах использовал inner join.
--максимальная дальность select max(range) from aircrafts_data. 
select 
	airport_name ->> 'en' as airport_name
from airports_data as ad
join flights as f on f.arrival_airport = ad.airport_code 
join aircrafts_data as craftdata using(aircraft_code)
where craftdata.range = (select max(range) from aircrafts_data)
group by airport_name, craftdata.range

--Были ли брони, по которым не совершались перелеты?
-- в запросе отсутствует таблица ticket_flighs 
-- использую left join чтобы оставить ВСЕ брони из таблицы boarding_passes
select 
	b.book_ref,
	bp.boarding_no
from bookings b
left join tickets as t using(book_ref)
left join boarding_passes as bp using(ticket_no)
where boarding_no is null

--Самолеты каких моделей совершают наибольший % перелетов?
-- считаю количество всех рейсов для каждой модели и делю на количество всех рейсов. Сортирую по убыванию, показываю только первое значение limit 1
select 
	model ->> 'en' as Plane,
	round(count(flight_id)::numeric * 100 / (select count(*) from flights), 2) as "Percent, %"
from aircrafts_data as craftdata
join flights as f using(aircraft_code)
group by aircraft_code
order by "Percent, %" desc
limit 1

--Были ли города, в которые можно  добраться бизнес - классом дешевле, чем эконом-классом?
-- ищу максимальное значение economy и минимальное для business для каждого города 
select 
	city ->> 'ru' as city,
	max(amount) filter (where fare_conditions = 'Economy') as "Max economy price",
	min(amount) filter (where fare_conditions = 'Business') as "Min business price"
from airports_data as ad
join flights f on ad.airport_code = f.departure_airport
join ticket_flights using(flight_id) 
group by city
having max(amount) filter (where fare_conditions = 'Economy') > min(amount) filter (where fare_conditions = 'Business')
order by city

--Узнать максимальное время задержки вылетов самолетов
-- с помощью extcract epoch считаю разницу актуальным временем прибытия и запланированным. Далее считаю максиммум. CTE использовал потому что могу
with cte_delay as (
select 
	max(extract(epoch from (actual_departure - scheduled_departure))) as Seconds
from flights
)
select Seconds from cte_delay
where Seconds = (select max(Seconds) from cte_delay )

--Между какими городами нет прямых рейсов*?
-- сначала составляю полный список уникальных городов в cte
-- соединяю таблицу с самой собой, где c1.city <> c2.city исключает строчки вида Абакан Абакан
-- where not exists исключает строчки, в которых departure_city = c1.city and r.arrival_city = c2.city. Возвращает булево значение. Если убать not, то будет вернёт список городов с пямым авиасообщением
with cte_cities(city) as (
   select distinct departure_city
   from routes
)
select distinct 
	c1.city as depart_city,
	c2.city as arrival_city
from cte_cities as c1 
join cte_cities as c2 on c1.city <> c2.city
where not exists (select * from routes as r
                  where r.departure_city = c1.city and r.arrival_city = c2.city)
order by c1.city asc, c2.city asc

-- Мастер, я справился?
--P.S. не стал разворачивать у себя СУБД по причине катастрофического отсутствия времени (работа + параллельный курс по python). Предупреждал координатора об этом. 