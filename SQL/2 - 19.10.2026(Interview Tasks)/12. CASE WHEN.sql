#Задание 1
Разбейте заказы на low/middle/high по сумме.

orders
order_id	amount
1	        500
2	        5000
3	        20000

select order_id, amount,
case when amount<=5000 then 'low'
when amount<=15000 then 'middle'
else 'high' end as segment
from orders



#Задание 2
Разбейте клиентов на возрастные группы.

clients
client_id	age
1	        17
2	        35
3	        70

select client_id, age,
case when age<=20 then 'young'
when age<=35 then 'middle age'
when age<=60 then 'adult'
else 'old' end as segment
from clients



#Задание 3
Приведите технические статусы платежей к бизнес-статусам.

payments
payment_id	status
1	        done
2	        ok
3	        error


select payment_id, status,
case when status in ('done','ok') then 'Всё прошло успешно'
else 'Произошла ошибка' as new_status
from payments



#Задание 4
Определите приоритет заявки по срочности и VIP-флагу.

tickets
ticket_id	is_vip	hours_left
1	        true	10
2	        false	2
3	        false	20


select ticket_id, is_vip, hours_left,
case when is_vip=true and hours_left>=5 then '1'
when is_vip=true and hours_left<5 then '2'
when is_vip=false and hours_left>10 then '3'
else '4' end as priority
from tickets



#Задание 5
Расшифруйте код канала продаж.

sales
sale_id	channel_code
1	    W
2	    M
3	    P


select sale_id, channel_code,
case when channel_code='W' then 'web'
when channel_code='M' then 'mobile'
else 'partner' end
from sales



#Задание 6
Разбейте клиентов по давности активации относительно 2026-04-30.

clients
client_id	activation_date
1	        2026-04-28
2	        2026-03-10
3	        2024-12-15


select client_id, activation_date,
case when date '2026-04-30' - activation_date>=100 then 'a long time ago'
when date '2026-04-30' - activation_date>=30 then 'not so long ago'
else 'recently'
from clients



#Задание 7
Определите риск по просрочке и сумме долга.

debts
client_id	days_overdue	debt_amount
1	        0	            500
2	        10	            2000
3	        40	            10000


select client_id, days_overdue, debt_amount,
case when days_overdue<=5 or debt_amount<=1000 then 'low risk'
when days_overdue<=20 or debt_amount<=5000 then 'middle risk'
else 'high risk' end as risk_status
from debts



#Задание 8
Сегментируйте клиентов по количеству заказов.

client_orders
client_id	orders_cnt
1	        0
2	        2
3	        10


select client_id, orders_cnt,
case when orders_cnt<=2 then 'loser'
when orders_cnt<=5 then 'middle'
else 'top'
from client_orders



#Задание 9
Разбейте товары по уровню остатка.

stock
sku_id	stock_cnt
1	    0
2	    5
3	    100


select sku_id, stock_cnt,
case when stock_cnt=0 then 'terrible'
when stock between 1 and 5 then 'not bad'
else 'good'
from stock



#Задание 10
Посчитайте сумму успешных и неуспешных платежей.

payments
payment_id	status	amount
1	        success	100
2	        fail	200
3	        success	300


select sum(case when status='success' then amount else 0 end) as success, sum(case when status='fail' then amount else 0 end) as fail
from payments