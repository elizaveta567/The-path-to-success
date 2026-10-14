#Задание 1
select *
from orders
where delivered_day is null


#Задание 2
select count(*) as cnt
from orders
where delivered_day is null


#Задание 3
select avg((case when delivered_day is null then created_day else delivered_day end)+1- created_day)
from orders

select avg(coalesce(delivered_day,created_day)+1-created_day)
from orders


#Задание 4
select max(coalesce(bonus_rub,0)),min(coalesce(bonus_rub,0))
from delivery_batches


#Задание 5
select bonus_rub, coalesce(bonus_rub,0) as bonus_filled
from delivery_batches


#Задание 6
select *
from employees
where rating is null and is_courier =1


#Задание 7
select count(*) as cnt
from delivery_batches
where completed is null


#Задание 8
select 1.0*sum(coalesce(completed,0))/count(*) as completion_rate
from delivery_batches


select avg(coalesce(completed,0)) as completion_rate
from delivery_batches


#Задание 9
select employee_id,name,coalesce(rating,-1)
from employees


#Задание 10
select status, round(avg(rating),4),count(*)
from employees
where rating is not null
group by status