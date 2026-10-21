#Задание 1
Посчитайте выручку и количество заказов по категориям.

orders
order_id	category	amount
1	        books	    1000
2	        games	    2500
3	        books	    1500


select category,count(amount) as cnt, sum(amount) as total_amount
from orders
group by category



#Задание 2
Найдите пользователей, у которых были заказы во всех трех месяцах.

orders
user_id	order_dt
10	    2026-01-05
10	    2026-02-12
20	    2026-01-20


select user_id
from orders
where order_dt>= date '2026-01-01' and order_dt< date '2026-04-01' \\эту строку не написала, так как
подумала, что в задаче информация только о трех месяцах
group by user_id
having count(distinct date_trunc('month',order_dt))=3



#Задание 3
Посчитайте средний чек по тарифу, оставив тарифы с минимум двумя платежами.

payments
payment_id	tariff	amount
1	        A	    100
2	        A	    200
3	        B	    500


select tariff, avg(amount) as avarage_check
from payments
group by tariff
having count(amount)>=2



#Задание 4
Посчитайте количество уникальных товаров в каждом заказе.

order_items
order_id	sku_id
1	        10
1	        10
1	        20


select order_id, count(distinct sku_id)
from order_items
group by order_id



#Задание 5
По каждому клиенту посчитайте успешные и неуспешные платежи.

payments
client_id	status
1	        success
1	        fail
2	        success


select client_id, sum(case when status='success' then 1 else 0 end), 
sum(case when status='fail' then 1 else 0 end)
from payments
group by client_id



#Задание 6
Для каждого клиента найдите первую и последнюю дату заказа.

orders
client_id	order_dt
1	        2026-01-01
1	        2026-03-01
2	        2026-02-10


select client_id, min(order_dt) as first_date, max(order_dt) as last_date
from orders
group by client_id



#Задание 7
Посчитайте месячную выручку.

orders
order_dt	amount
2026-01-01	100
2026-01-20	200
2026-02-01	300


select date_trunc('month',order_dt), sum(amount) as total
from orders
group by date_trunc('month',order_dt)



#Задание 8
Найдите клиентов с суммарными покупками больше 1000.

orders
client_id	amount
1	        400
1	        700
2	        300


select client_id, sum(amount) as total
from orders
group by client_id
having sum(amount)>1000



#Задание 9
Посчитайте выручку по категориям и долю категории от общей выручки.

orders
category	amount
books	    100
games	    300
books	    100


with t as(
    select sum(amount) as total_revenue from orders
)
select category, sum(amount) as total, 1.0*sum(amount)/(select total_revenue from t)
from orders
group by category


Эталонное решение:
with t as(
    select category, sum(amount) as revenue
    from orders
    group by category
)
select category, revenue, 1.0*revenue / sum(revenue) over() as share
from t



#Задание 10
Разбейте заказы на крупные и мелкие, посчитайте количество.

orders
order_id	amount
1	        300
2	        1500
3	        900


select (case when amount<=1000 then 'low' else 'high' end) as name, count(*) as cnt 
from orders
group by (case when amount<=1000 then 'low' else 'high' end)

