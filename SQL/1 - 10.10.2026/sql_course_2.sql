#Задание 1
select *
from employees
where role = 'picker'


#Задание 2
select order_id, order_status, priority_level
from orders
where priority_level < 4


#Задание 3
select *
from stores
where store_type in ('darkstore','micro_hub')
order by store_type, name


#Задание 4
select name, experience_level 
from employees
where experience_level between 4 and 6


#Задание 5
select name,status
from employees
where status != 'active'


#Задание 6
select batch_id, batch_name, bonus_rub
from delivery_batches
where bonus_rub >=100


#Задание 7
select batch_id, batch_name
from delivery_batches
where bonus_rub is NULL


#Задание 8
select *
from order_staff
where role_in_order = 'customer_contact'
order by order_id,employee_id 


#Задание 9
select *
from orders
where created_day=5


#Задание 10
select *
from employees
where (is_courier=1 and rating >=7) or (status ='blocked' and experience_level >=6)
