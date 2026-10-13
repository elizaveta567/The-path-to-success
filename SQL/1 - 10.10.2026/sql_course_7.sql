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


