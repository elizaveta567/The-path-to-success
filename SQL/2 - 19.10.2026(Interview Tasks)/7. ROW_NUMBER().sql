#Задание 1
 Для каждого объекта выберите самую свежую запись.

history
entity_id	event_dt	value
1	        2026-01-01	A
1	        2026-03-15	B
2	        2026-02-20	C


with t as (
    select entity_id, event_dt, value, row_number() over(partition by entity_id order by event_dt desc) as rn
    from history
)
select entity_id, event_dt,velue
from t
where rn=1



#Задание 2
Выведите первые 3 заказа каждого клиента.

orders
client_id	order_id	order_dt
1	        10	        2026-01-01
1	        11	        2026-01-05
1	        12	        2026-01-10


with t as (select client_id, order_id, order_dt, row_number() over(partition by client_id order by order_dt) as rn
from orders)
select client_id, order_id, order_dt
from t
where rn<=3



#Задание 3
Оставьте по одному событию на пару user_id + event_id, самое позднее.

events
user_id	event_id	loaded_at
1	    A	        10:00
1	    A	        10:05
2	    B	        11:00


with t as(
    select user_id, event_id, loaded_at, row_number() over(partition by user_id, event_id order by loaded_at desc) as rn
    from events
)
select user_id, event_id, loaded_at
from t
where rn=1



#Задание 4
Найдите самый крупный платеж каждого пользователя.

payments
user_id	payment_id	amount
1	    10	        500
1	    11	        700
2	    12	        300


with t as(
    select *, row_number() over(partition by user_id order by amount desc, payment_id) as rn
    from payments
)
select user_id, payment_id, amount
from t
where amount=1



#Задание 5
Найдите первую покупку каждого клиента.

orders
client_id	order_id	order_dt
1	        1	        2026-02-01
1	        2	        2026-01-01
2	        3	        2026-03-01


with t as(
    select *, row_number() over(partition by client_id order by order_dt, order_id) as rn
    from orders
)
select client_id, order_id, order_dt
from t
where rn=1



#Задание 6
Выведите последний статус каждой заявки.

ticket_status
ticket_id	status	changed_at
1	        new	    09:00
1	        done	10:00
2	        new	    11:00


with t as(
    select ticket_id, status, changed_at, row_number()over(partition by ticket_id order by changed_at desc) as rn
    from ticket_status
)
select ticket_id, status
from t
where rn=1



#Задание 7
Оставьте одного пользователя на email: самого нового.

users
user_id	email	created_at
1	    a@x.ru	2026-01-01
2	    a@x.ru	2026-02-01
3	    b@x.ru	2026-01-10


with t as(
    select user_id, email, created_at, row_number() over(partition by lower(email) order by created_at desc) as rn
    from users
)
select user_id, email, created_at
from t
where rn=1



#Задание 8
Выведите второй заказ каждого клиента.

orders
client_id	order_id	order_dt
1	        10	        2026-01-01
1	        11	        2026-01-02
2	        12	        2026-01-03


with t as(
    select *, row_number()over(partition by client_id order by order_dt, order_id) as rn
    from orders
)
select client_id, order_id, order_dt
from t
where rn=2



#Задание 9
Найдите актуальный адрес на 2026-04-30.

address_history
client_id	address	valid_from
1	        A	    2026-01-01
1	        B	    2026-04-01
2	        C	    2026-05-01


with t as (select *, row_number() over(partition by client_id order by valid_from desc) as rn
from address_history
where valid_from <= date '2026-04-30')
select client_id, address
from t
where rn = 1




#Задание 10
Выберите одну максимальную транзакцию на клиента, при равенстве суммы берите меньший id.

transactions
client_id	transaction_id	amount
1	        10	            100
1	        11	            100
2	        12	            50



with t as(
    select *, row_number() over(partition by client_id order by amount desc, transaction_id) as rn
    from transactions
)
select client_id, transaction_id, amount
from transactions
where rn=1