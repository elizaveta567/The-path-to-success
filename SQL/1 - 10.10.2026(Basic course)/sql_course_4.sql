#Задание 1
select o.order_id, o.order_status, s.name ,s.store_type
from orders o inner join stores s on o.store_id= s.store_id


#Задание 2
select o.order_id, o.order_status
from order_staff s inner join orders o on o.order_id = s.order_id
inner join employees e on s.employee_id = e.employee_id
where e.name = 'Maria Volkova'


#Задание 3
select db.batch_id,db.batch_name, db.completed,count(bo.order_id )
from delivery_batches db left join batch_orders bo on db.batch_id = bo.batch_id
group by db.batch_id


#Задание 4
select distinct(o.order_id), o.order_status 
from orders o inner join order_staff os on o.order_id = os.order_id
where os.role_in_order = 'customer_contact'


#Задание 5
select o.order_id,s.name, e.name,os.role_in_order 
from orders o inner join stores s on o.store_id = s.store_id
inner join order_staff os on o.order_id = os.order_id
inner join employees e on e.employee_id = os.employee_id


#Задание 6
select distinct s.name
from orders o inner join order_staff os on o.order_id = os.order_id
inner join employees e on e.employee_id = os.employee_id
inner join stores s on s.store_id = o.store_id 
where e.name = 'Alexey Morozov'


#Задание 7
select o.order_id, o.order_status, e.name, os.role_in_order 
from orders o inner join order_staff os on o.order_id = os.order_id
inner join employees e on e.employee_id = os.employee_id 
where e.status = 'blocked'
order by o.order_id,e.name


#Задание 8
select db.batch_id, db.batch_name, sum(o.priority_level)
from delivery_batches db inner join batch_orders bo on db.batch_id = bo.batch_id
inner join orders o on bo.order_id = o.order_id
where o.priority_level >= 8
group by db.batch_id


#Задание 9
select o.order_id, count(distinct os.employee_id)
from orders o inner join order_staff os on o.order_id = os.order_id
group by o.order_id


#Задание 10
select *
from employees e left join order_staff os on e.employee_id = os.employee_id
where os.order_id is NULL