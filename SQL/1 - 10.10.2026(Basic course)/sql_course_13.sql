#Задание 1
select e.name, count(order_id), e.is_courier,
case when e.status='active' then 1 else 0 end as active,
case when e.status='vacation' then 1 else 0 end as vacation,
case when e.status='blocked' then 1 else 0 end as blocked
from employees e left join order_staff os
on e.employee_id = os.employee_id
group by e.name,e.is_courier,e.status 
order by e.name


#Задание 2
with t as(select e.name, os.order_id,
case when coalesce(rating,0)<=5 then 'loser' when rating<=7 then 'good bro' else 'super dude' end as scr
from employees e left join order_staff os on e.employee_id = os.employee_id)
select scr,count(distinct name) as employees_cnt, round(1.0*count(order_id)/count(distinct name),4) as avg_orders
from t
group by scr


#Задание 3
select created_by, count(*), round(avg(coalesce(bonus_rub,0)),4), round(avg(completed),4)
from delivery_batches
where completed is not NULL
group by created_by
order by created_by


'''Может быть ситуация - делание на ноль'''
round(avg(completed),4) --> round(sum(coalesce(bonus_rub,0)) / NULLIF(count(*),0),4)


#Задание 4
'''Одна из самых тяжелых для меня задач, не могла понять условие'''
with t as (select db.batch_id, 1.0*db.bonus_rub/avg(o.priority_level) as bonus_per_priority
from delivery_batches db join
batch_orders bo on db.batch_id = bo.batch_id
join orders o on o.order_id = bo.order_id
where db.bonus_rub is not NULL
group by db.batch_id,db.bonus_rub
)
select *
from t
where bonus_per_priority > (select avg(bonus_per_priority) from t)
order by batch_id 


#Задание 5
select s.name, sum(o.priority_level )
from stores s inner join orders o
on s.store_id = o.store_id
group by s.name
order by sum(o.priority_level) desc
limit 5


#Задание 6
select e.name, count(order_id)
from employees e left join order_staff os
on e.employee_id = os.employee_id 
group by e.name 
order by count(order_id) desc, e.name
limit 10


#Задание 7
with t as(select s.name,o.order_id, case when o.priority_level>=8 then 1 else 0 end as high_orders
from stores s inner join orders o
on s.store_id = o.store_id)
select name, 1.0*sum(high_orders)/NULLIF(count(order_id),0) as res
from t
group by name


#Задание 8
select 'employees' as type, name, experience_level as scr
from employees
union all
select 'orders', order_status, priority_level
from orders
union all
select 'stores',name,load_level
from stores
order by scr desc
limit 15


#Задание 9
with t as (select e.name, e.status,os.order_id
from employees e left join order_staff os
on e.employee_id = os.employee_id)
select t1.order_id, t1.name, t2.name, t1.status, t2.status
from t as t1 join t as t2 on t1.status<>t2.status and t1.name<t2.name and t1.order_id = t2.order_id
order by t1.order_id, t1.name, t2.name


#Задание 10
with t as(select o.order_id, sum(case when e.experience_level>=o.priority_level then 1 else 0 end) as flag
from employees e 
left join order_staff os 
on e.employee_id = os.employee_id
inner join orders o
on os.order_id = o.order_id
group by o.order_id)
select order_id, flag
from t
where flag=0 



