#Задание 1
select store_id, order_id, priority_level, rank() over(partition by store_id order by priority_level desc)
from orders
order by store_id


#Задание 2
with t as(select employee_id, name, role, experience_level, row_number() over(partition by role order by experience_level desc,name) as rn
from employees)
select *
from t 
where rn in (1,2)


#Задание 3
select employee_id,name, status, experience_level,avg(experience_level) over(partition by status)
from employees
order by status


#Задание 4
with t as (select employee_id, name, role, experience_level, avg(experience_level) over(partition by role) as avg
from employees)
select *
from t 
where experience_level > avg


#Задание 5
with t as(select batch_id,batch_name, created_by, bonus_rub, sum(bonus_rub) over(partition by created_by) as sum
from delivery_batches
where bonus_rub is not null)
select *,round(bonus_rub *1.0/sum,4)
from t


#Задание 6
with t as(select batch_id, created_by, bonus_rub, coalesce( lag(bonus_rub) over(partition by created_by order by batch_id ),0) as value_before
from delivery_batches
where bonus_rub is not null)
select batch_id, created_by, bonus_rub, bonus_rub - value_before 
from t


'''Я забыла, что у lag есть еще параметры'''
with t as(select batch_id, created_by, bonus_rub, lag(bonus_rub,1,0) over(partition by created_by order by batch_id ) as value_before
from delivery_batches
where bonus_rub is not null)
select batch_id, created_by, bonus_rub, bonus_rub - value_before 
from t


#Задание 7
with t as(select created_day, count(*) as cnt
from orders
group by created_day )
select *, sum(cnt) over(order by created_day ) as total
from t


#Задание 8
select order_status, 1.0/count(*)over() as res
from orders


select distinct order_status, 1.0 * count(*) over(partition by order_status) / count(*) over() as res
from orders


#Задание 9
with t as(select store_id,priority_level, row_number() over(partition by store_id order by priority_level desc) as mx
from orders)
select *
from t
where mx=1


#Задание 10
select *, row_number() over(partition by created_by order by batch_id )
from delivery_batches