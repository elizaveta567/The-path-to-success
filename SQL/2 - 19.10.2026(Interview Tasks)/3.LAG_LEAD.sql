#Задание 1
Для каждого месяца посчитайте изменение выручки относительно прошлого месяца.

monthly_revenue

month_dt	revenue
2026-01-01	100000
2026-02-01	130000
2026-03-01	120000


select month_dt, revenue, revenue - lag(revenue) over(order by month_dt) as diff
from monthly_revenue



#Задание 2
Для каждого заказа покажите дату следующего заказа этого же клиента.


orders
client_id	order_id	order_dt
10	        1	        2026-01-05
10	        2	        2026-01-20
20	        3	        2026-01-09



select client_id, order_id, order_dt, lead(order_dt) over(partition by client_id order by order_dt) as next_order_dt
from orders



#Задание 3
Покажите, как менялась цена товара относительно предыдущей записи.

price_history
product_id	changed_at	price
1	        2026-01-01	500
1	        2026-02-01	550
2	        2026-01-15	900

'''Нужно обратить внимание на то, что считать разницу не надо'''
select product_id, changed_at, price, lag(price) over(partition by product_id order by changed_at)
from price_history



#Задание 4
Посчитайте процентный рост метрики к предыдущему дню.


daily_metrics
dt	        metric
2026-04-01	100
2026-04-02	125
2026-04-03	150


select dt, metric, metric*100/NULLIF(lag(matric) over(order by dt),0)-100
from daily_metrics



#Задание 5
Найдите события пользователя, между которыми прошло больше 7 дней.

events
user_id	event_dt
1	    2026-01-01
1	    2026-01-12
2	    2026-01-03


with t as (select user_id, event_dt, lag(event_dt) over(partition by user_id order by event_dt) as previous_event
from events)
select user_id, event_dt,previous_event
from t
where event_dt - previous_event>7



#Задание 6
Выведите строки, где статус заявки изменился относительно предыдущего статуса.

ticket_status
ticket_id	changed_at	status
1	        2026-01-01	new
1	        2026-01-02	work
1	        2026-01-03	work


with t as (select ticket_id, changed_at, status, lag(status) over(partition by ticket_id order by changed_at) as previous_status
from ticket_status)
select *
from t
where previous_status is null or previous_status<>status



#Задание 7
Для каждого визита покажите количество дней до следующего визита клиента.

visits

client_id	visit_dt
1	        2026-03-01
1	        2026-03-10
2	        2026-03-05


select client_id, visit_dt, lead(visit_dt) over(partition by client_id order by visit_dt) - visit_dt as diff
from visits



#Задание 8
Посчитайте изменение остатка товара относительно предыдущей инвентаризации.

stock
sku_id	stock_dt	stock_cnt
10	2026-01-01	    100
10	2026-01-08	    93
20	2026-01-01	    50


select sku_id, stock_dt, stock_cnt, stock_cnt-lag(stock_cnt) over(partition by sku_id order by stock_dt) as diff
from stock



#Задание 9
Найдите дни, когда выручка стала меньше предыдущего дня.

revenue
dt	        amount
2026-04-01	500
2026-04-02	450
2026-04-03	600


with t as (select dt, amount, lag(amount) over(order by dt) as previous_amount
from revenue)
select dt
from t
where amount < previous_amount



#Задание 10
Найдите даты, после которых следующее событие наступило не на следующий день.

calendar_events
event_dt
2026-04-01
2026-04-02
2026-04-05

with t as (select event_dt, lead(event_dt) over(order by event_dt) as next_event_dt
from calendar_events)
select event_dt
from t
where next_event_dt-event_dt > 1


Эталонное решение
with t as (select event_dt, lead(event_dt) over(order by event_dt) as next_event_dt
from calendar_events)
select event_dt
from t
where next_event_dt is not NULL and next_event_dt <> event_dt + INTERVAL '1 day'