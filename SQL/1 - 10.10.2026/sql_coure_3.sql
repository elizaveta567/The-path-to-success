#Задание 1
select store_type, count(*) as cnt
from stores
group by store_type


#Задание 2
select store_type, avg(load_level) as average
from stores
group by store_type


#Задание 3
select created_by, count(*) as cnt
from delivery_batches
group by created_by


#Задание 4
select created_by, sum(bonus_rub)
from delivery_batches
where bonus_rub is not null
group by created_by


#Задание 5
select order_status, avg(priority_level)
from orders
group by order_status
having avg(priority_level)>=7


#Задание 6
select role, avg(experience_level) as average_experience_level
from employees
group by role
having avg(experience_level)>6


#Задание 7
select role_in_order, count(*) as cnt
from order_staff
group by role_in_order


#Задание 8
select store_id, count(*)
from orders
group by store_id
having count(*)>=2


#Задание 9
select store_id, max(priority_level)
from orders
group by store_id


#Задание 10
select role, count(*) as cnt
from employees
where status='blocked'
group by role