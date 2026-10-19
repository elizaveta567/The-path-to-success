#Задание 1
select e1.name, e2.name, e1.role
from employees e1 join employees e2 on e1.role=e2.role and e1.name<e2.name


#Задание 2
select *
from stores s1 join stores s2 on s1.store_type = s2.store_type and s1.load_level <> s2.load_level and s1.store_id < s2.store_id


#Задание 3
select distinct e1.name, e1.role,e1.experience_level 
from employees e1 join employees e2 on e1.role = e2.role and e1.experience_level = e2.experience_level and e1.name <> e2.name


#Задание 4
select *
from orders o1 join orders o2 on o1.order_status = o2.order_status and o1.store_id = o2.store_id and o1.order_id<o2.order_id 


#Задание 5
select e1.name, e2.name,e1.role, e1.is_courier, e2.is_courier 
from employees e1 join employees e2
on e1.role= e2.role and (e1.is_courier = 1 and e2.is_courier = 0)

