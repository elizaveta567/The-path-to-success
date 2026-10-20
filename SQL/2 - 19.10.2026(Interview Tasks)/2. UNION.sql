#Задание 1
Получите единый список id из двух таблиц без дублей.

web_clients
client_id
101
102
102

app_clients
client_id
102
103
104


Решение:
select client_id as unique_id
from web_clients
union
select app_clients
from app_clients

Результат:
unique_id
101
102
103
104
'''Без ORDER BY их порядок вывода SQL не гарантирует!'''



#Задание 2
Соберите общий лог событий из двух источников, сохранив повторяющиеся события.

web_events
user_id	event_name
1	login
1	pay
2	login

mobile_events
user_id	event_name
1	pay
3	login
3	logout


Решение:
select user_id,event_name from web_events
union all
select user_id, event_name from mobile_events

Результат:
1	login
1	pay
2	login
1	pay
3	login
3	logout



#Задание 3
Получите уникальные пары client_id + city из двух витрин.

crm_clients
client_id	city
1	Москва
1	Москва
2	Казань

billing_clients
client_id	city
2	Казань
3	Самара
3	Уфа


Решение:
select client_id, city from crm_clients
union
select client_id, city from billing_clients


Результат:
1 Москва
2 Казань
3 Самара
3 Уфа



#Задание 4
Объедините id из двух систем, если в одной системе id хранится строкой.

old_users
user_id
101
102
103

new_users
user_id
102
104
105

Изначально я подумала, что Postgres самостоятельно приведет все к одному типу данных, но нет...
надо это делать самостоятельно через CAST.

Решение:
select cast(user_id int) from old_users
union
select user_id from new_users

Результат:
101
102
103
104
105



#Задание 5
Получите пользователей, которые сделали покупку в январе или возврат в феврале.

payments
user_id	payment_dt
1	2026-01-05
2	2026-02-10
3	2026-01-20

refunds
user_id	refund_dt
2	2026-02-15
4	2026-02-18
5	2026-03-01


Решение:
select user_id
from payments
where date_part('month',payment_dt)=1
union
select user_id
from refunds
where date_part('month',refund_dt)=2

ИЛИ
Эталонное решение:
select user_id
from payments
where payment_dt>= DATE '2026-01-01' and payment_dt<DATE'2026-02-01'
union
select user_id
from refunds
where refund_dt>= DATE '2026-02-01' and refund_dt<'2026-03-01'


Результат:
1
3
2
4



#Задание 6
Объедините два списка чисел и выведите результат по возрастанию.

a
num
3
1
2

b
num
2
4
1


Решение:
select num from a
union
select num from b
order by num


Результат:
1
2
3
4



#Задание 7
Соберите продажи из online/offline и сохраните источник строки.

online_sales
sale_id	amount
1	1000
2	1500
3	900

offline_sales
sale_id	amount
1	700
4	1200
5	300


Решение:
select sale_id, amount, 'online' as source
from online_sales
union all
select sale_id, amount, 'offline'
from offline_sales


Результат:
1 1000 'online'
2 1500 'online'
3 900 'online'
1 700 'offline'
4 1200 'offline'
5 300 'offline'



#Задание 8
Найдите клиентов, которые есть в обеих таблицах.

email_clients
client_id
10
20
30

push_clients
client_id
20
30
40


Решение:
select client_id from email_clients
intersect
select client_id from push_clients


Результат:
20
30



#Задание 9
Найдите клиентов из первой таблицы, которых нет во второй.

all_clients
client_id
1
2
3

blocked_clients
client_id
2
4
5


Решение:
select client_id from all_clients
except
select client_id from blocked_clients


Результат:
1
3



#Задание 10
Сложите продажи из двух таблиц и посчитайте общую выручку по дням.

sales_2025
sale_dt	amount
2025-12-30	100
2025-12-31	200
2025-12-31	50

sales_2026
sale_dt	amount
2026-01-01	300
2026-01-01	400
2026-01-02	500



Решение:
with t as (select sale_dt, amount
from sales_2025
union all
select sale_dt, amount
from sales_2026)
select sale_dt, sum(amount)
from t
group by sale_dt
