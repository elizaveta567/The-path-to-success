#Задание 1
select *, case when priority_level>=8 then 1 else 0 end as high_priority
from orders


#Задание 2
select store_id, sum(case when priority_level>=8 then 1 else 0 end) as high_priority
from orders
group by store_id
order by store_id 


#Задание 3
select role, count(*) as total_employees, sum(is_courier) as total_couriers, sum(case when experience_level>=8 then 1 else 0 end) as total_experienced
from employees
group by role
order by role


#Задание 4
select created_by, count(*) as cnt, sum(coalesce(completed,0)) as completed_cnt, sum(case when completed is null or completed=0 then 1 else 0 end) as ncomplete_or_unknown
from delivery_batches
group by created_by
order by created_by 


#Задание 5
select batch_id,batch_name, coalesce(bonus_rub,0) as bonus_rub, (case when bonus_rub>=200 then 'high' when bonus_rub>=100 then 'mid'
else 'low' end) as bucket
from delivery_batches


#Задание 6
with t as (select name, (case when status='blocked' then 'blocked_group'
when experience_level >= 8 then 'experienced'
when is_courier=1 then 'courier_group' else 'standard' end) as category
from employees)
select *
from t 
where category='blocked_group'


#Задание 7
with t as(select status,(case when experience_level<=3 then 'low' when experience_level<=6 then 'mid' else 'high' end) as pp
from employees)
select status,pp,count(*) as cnt
from t
group by status, pp


#Задание 8
select order_status,sum(case when priority_level>=9 then 1 else 0 end) as sm
from orders
group by order_status


#Задание 9
select sum(case when (coalesce(delivered_day,created_day)+1 - created_day)>1 then 1 else 0 end) as long_orders_cnt
from orders


#Задание 10
select e.name, count(order_id) as cnt, (case when count(order_id)>=2 then 1 else 0 end) as active
from employees e left join order_staff os on e.employee_id = os.employee_id
group by e.name
