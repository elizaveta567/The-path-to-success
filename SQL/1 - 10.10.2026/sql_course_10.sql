#Задание 1
select 'employees' as type ,employee_id as registry, experience_level as src
from employees
union all
select 'orders' as type, order_id as registry, priority_level as src
from orders


#Задание 2
select role as list
from employees
union
select store_type
from stores 


#Задание 3 dq
select 'employees: '||employee_id as entity_id
from employees
union all
select 'stores: '||store_id
from stores
union all
select 'orders: '||order_id
from orders


#Задание 4
with t as (select 'employees' as object, name, experience_level as score
from employees
union all 
select 'stores', name, load_level
from stores)
select *
from t
order by score desc
limit 10


#Задание 5
select 'employees' as object, count(*) as src
from employees
union all
select 'stores', count(*)
from stores
union all
select 'orders', count(*)
from orders 
union all
select 'delivery_batches', count(*)
from delivery_batches


#Задание 6
select batch_id, 'completed' as status
from delivery_batches
where completed=1
union
select batch_id, 'fail'
from delivery_batches
where completed=0


#Задание 7
select name as title
from employees
union
select batch_name
from delivery_batches


#Задание 8
select name as title
from stores
where store_type = 'darkstore'
union all 
select batch_name
from delivery_batches
where lower(batch_name) like '%darkstore%' 


#Задание 9
select order_status as title
from orders
union
select created_by
from delivery_batches


#Задание 10
select name, (case when experience_level>=8 then 'high' else 'low' end) as bucket
from employees
union all 
select name, (case when load_level>=8 then 'high' else 'low' end)
from stores