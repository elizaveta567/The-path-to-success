#Задание 1
with t as(
	select max(delivered_day -created_day)
	from orders
	where delivered_day is not null
)
select *
from orders
where delivered_day is not null and (delivered_day -created_day)=(select * from t)

"В видео говорили, что использовать подзапросы не самая хорошая идея, я про это забыла.
Решение я посмотрела и попробовала самостоятельно переписать:"

with t as (select order_id, (delivered_day - created_day+1) as days
from orders
where delivered_day is not null),
a as (select max(delivered_day - created_day+1) as mx_day
from orders
)
select t.*
from t inner join a on t.days = a.mx_day


#Задание 2
with t as (select s.name, count(*) as cnt
from stores s inner join orders o on s.store_id = o.store_id
group by s.store_id),
a as (select max(cnt) as mx_cnt from t
)
select t.*
from t inner join a on t.cnt=a.mx_cnt


#Задание 3
'''Но как будто еще раз лишний раз вызывать select бессмысленно'''
with t as (select e.name, count(*)
from orders o inner join order_staff os on o.order_id = os.order_id
inner join employees e on os.employee_id = e.employee_id
where o.priority_level >=8
group by e.employee_id
having count(*)>1)
select *
from t

'''Еще вариант'''
with t as (select order_id
from orders
where priority_level >=8),
a as (select os.order_id, e.employee_id, e.name
from order_staff os inner join employees e on os.employee_id = e.employee_id
)
select a.name,count(*)
from t inner join a on t.order_id = a.order_id
group by a.name
having count(*)>1

'''Вариант готового решения'''
with t as(
select os.employee_id, count(*) as cnt
from orders o inner join order_staff os on o.order_id = os.order_id
where o.priority_level >=8
group by os.employee_id
)
select e.name, t.cnt
from t inner join employees e on t.employee_id = e.employee_id
where cnt>1


#Задание 4
with t as(
select avg(priority_level)
from orders
),
a as(
select db.batch_name, avg(o.priority_level) as avg_p
from delivery_batches db inner join batch_orders bo on db.batch_id = bo.batch_id
inner join orders o on bo.order_id = o.order_id
group by db.batch_name
)
select *
from a
where avg_p > (select * from t)


'''Так лучше'''
with a as(
select db.batch_name, avg(o.priority_level) as avg_p
from delivery_batches db inner join batch_orders bo on db.batch_id = bo.batch_id
inner join orders o on bo.order_id = o.order_id
group by db.batch_name
)
select *
from a
where avg_p > (select avg(priority_level)
from orders)