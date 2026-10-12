#Задание 1
select *
from delivery_batches
where lower(batch_name) like '%airport%'

#Задание 2
select *
from delivery_batches
where batch_name like 'Resolve%'


#Задание 3
select *
from delivery_batches
where batch_name like '%Hub'


#Задание 4
select batch_name, length(batch_name)
from delivery_batches
order by length(batch_name) desc,batch_name


#Задание 5
select batch_name || ' | binus_rub=' || bonus_rub
from delivery_batches
where bonus_rub is not NULL


#Задание 6
select *
from delivery_batches
where lower(batch_name) like '%optimize%' or lower(batch_name) like '%resolve%'


#Задание 7
select batch_id, substr(batch_name,1,5)
from delivery_batches


#Задание 8
select replace(batch_name, ' ', '-') as dash_title
from delivery_batches


#Задание 9
select batch_id, batch_name, length(batch_name)
from delivery_batches
where length(batch_name)>(select avg(length(batch_name)) from delivery_batches)


#Задание 10
select batch_name, position('darkstore' in lower(batch_name))
from delivery_batches