#Задание 1
select *
from employees
limit 12


#Задание 2
select distinct role
from employees
order by role


#Задание 3
select *
from stores
order by load_level desc, name
limit 5


#Задание 4
select order_id, order_status, priority_level
from orders
order by priority_level desc
limit 5


#Задание 5
select distinct role_in_order
from order_staff


#Задание 6
select batch_id,batch_name
from delivery_batches
order by batch_id 
limit 10


#Задание 7
select distinct created_by
from delivery_batches
order by created_by


#Задание 8
select name, experience_level 
from employees
order by experience_level desc, name asc


#Задание 9
select order_id, order_status, created_day
from orders
order by created_day, order_id


#Задание 10
select distinct role, is_courier
from employees
order by role, is_courier
