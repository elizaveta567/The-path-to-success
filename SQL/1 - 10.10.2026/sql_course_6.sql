#Part 1

#Задание 1
select *
from delivery_batches
where lower(batch_name) like '%airport%'

#Задание 2
select *
from delivery_batches
where batch_name like 'Resolve%'


#Задание 3
select *
from delivery_batches
where batch_name like '%Hub'


#Задание 4
select batch_name, length(batch_name)
from delivery_batches
order by length(batch_name) desc,batch_name


#Задание 5
select batch_name || ' | binus_rub=' || bonus_rub
from delivery_batches
where bonus_rub is not NULL


#Задание 6
select *
from delivery_batches
where lower(batch_name) like '%optimize%' or lower(batch_name) like '%resolve%'


#Задание 7
select batch_id, substr(batch_name,1,5)
from delivery_batches


#Задание 8
select replace(batch_name, ' ', '-') as dash_title
from delivery_batches


#Задание 9
select batch_id, batch_name, length(batch_name)
from delivery_batches
where length(batch_name)>(select avg(length(batch_name)) from delivery_batches)


#Задание 10
select batch_name, position('darkstore' in lower(batch_name))
from delivery_batches


---------------------


#Part 2

#Задание 1
'''Гляну в интернете такую функцию'''
select order_id, order_status, make_date(2024,1,created_day) as created_day, make_date(2024,1,delivered_day) as delivered_day
from orders
where delivered_day is not null


select order_id, order_status, date '2024-01-01'+(created_day - 1) as created_day , date '2024-01-01'+(delivered_day-1) as delivered_day 
from orders
where delivered_day is not null


#Задание 2
'''Мой вариант'''
with t as (select order_id, order_status, date '2024-01-01'+(created_day - 1) as created_day , date '2024-01-01'+(delivered_day-1) as delivered_day 
from orders
where delivered_day is not null)
select *
from t
where date_trunc('month', created_day)='2024-01-01'

'''Вариант готового решения'''
select order_id, order_status, date '2024-01-01'+(created_day - 1) as created_day
from orders
where delivered_day is not null and date '2024-01-01'+(created_day - 1) >= '2024-01-01' and
date '2024-01-01'+(created_day - 1) < '2024-02-01'


#Задание 3
select order_id, date '2024-01-01' + (created_day-1) as start_day, extract(dow from date '2024-01-01' + (created_day-1)) as dow
from orders
order by date '2024-01-01' + (created_day-1), order_id


#Задание 4
'''Жизнь себе усложнила'''
select order_id, ((date '2024-01-01'+(delivered_day-1)) - (date '2024-01-01'+(created_day - 1))+1) as days
from orders
where delivered_day is not null 
order by ((date '2024-01-01'+(delivered_day-1)) - (date '2024-01-01'+(created_day - 1))+1) desc
limit 3

'''Вариант готового решения'''
select order_id, delivered_day - created_day + 1 as days
from orders
where delivered_day is not null 
order by delivered_day - created_day + 1 desc
limit 3


#Задание 5
select *,date '2001-01-01'+(created_day-1)
from orders
where priority_level >=7 and (date '2001-01-01'+(created_day-1) > '2001-01-05')


#Задание 6
select order_id, order_status, DATE '2024-01-01' + (created_day - 1) as start_date, extract(dow from DATE '2024-01-01' + (created_day - 1)) as dow
from orders
where extract(dow from DATE '2024-01-01' + (created_day - 1)) in (0,6)
order by DATE '2024-01-01' + (created_day - 1), order_id


#Задание 7
select date '2024-01-01' + (created_day -1) as new_date, sum(priority_level )
from orders
group by date '2024-01-01' + (created_day -1)
order by date '2024-01-01' + (created_day -1)


#Задание 8
select date '2024-01-01' + (created_day -1) as date_start, date '2024-01-01' + (delivered_day  -1) as date_end, ((date '2024-01-01'+(delivered_day-1)) - (date '2024-01-01'+(created_day - 1))+1) as dr
from orders
where delivered_day is not null and ((date '2024-01-01'+(delivered_day-1)) - (date '2024-01-01'+(created_day - 1))+1)>=2


#Задание 9
select date '2024-01-01'+(created_day -1) as date, count(order_id) as cnt
from orders
group by date '2024-01-01'+(created_day -1)
order by count(*) desc , date '2024-01-01'+(created_day -1)
limit 5


#Задание 10
select order_id, date '2024-01-01' + (created_day-1) + time '12:00' as time
from orders