#Задание 1
with t as (select distinct  (case when e1.name < e2.name then e1.name else e2.name end), (case when e1.name < e2.name then e2.name else e1.name end)
from employees e1 join employees e2 on e1.role <> e2.role)
select count(*)
from t


'''Пупупу я усложнила'''
select count(*)
from employees e1 join employees e2 on e1.role <> e2.role and e1.name < e2.name


#Задание 2
select e1.name,e2.name,e1.role
from employees e1 join employees e2 on e1.role = e2.role and e1.name < e2.name and e1.status<>e2.status


#Задание 3
select o.order_id, s.name, o.priority_level, s.load_level 
from stores s join orders o on s.store_id = o.store_id and o.priority_level > s.load_level 


#Задание 4
select o1.order_id, o2.order_id, o1.created_day,o2.created_day 
from orders o1 join orders o2 on o1.created_day <> o2.created_day and o1.order_id < o2.order_id 


#Задание 5
with t as(select distinct db.created_by , e.status, db.batch_id
from employees e join delivery_batches db on 1=1
order by db.created_by , e.status)
select created_by, status, count(*)
from t
group by created_by, status
