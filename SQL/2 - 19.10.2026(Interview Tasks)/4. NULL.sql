#Задание 1
Найдите счета без даты закрытия.

accounts
account_id	close_dt
1	        NULL
2	        2026-02-01
3	        NULL

select account_id
from accounts
where close_dt is NULL



#Задание 2
Выведите баланс, заменив NULL на 0.

accounts
account_id	balance
1	        500
2	        NULL
3	        700


select account_id, coalesce(balance,0) as balance
from accounts



#Задание 3
Посчитайте все строки и строки с заполненным телефоном.

clients
client_id	phone
1	+7900
2	NULL
3	+7911

select count(*), count(phone)
from clients



#Задание 4
Найдите клиентов, у которых нет заказов.

clients
client_id
1
2
3


orders
order_id	client_id
10	        1
11	        1
12	        3


select c.client_id
from clients c left join orders o on c.client_id = o.client_id
where o.order_id is null


select c.client_id
from clients c
where not exists (select 1 from orders o where c.client_id = o.client_id)



#Задание 5
Найдите клиентов, которых нет в blacklist. Учтите, что в blacklist может быть NULL.

clients
client_id
1
2
3


blacklist
client_id
2
NULL
5


select client_id
from clients
where client_id not in (select client_id from blacklist where client_id is not null)
'''Наивное client_id NOT IN (SELECT client_id FROM blacklist) встретит NULL и для неподходящих 
номеров может дать неизвестность вместо истины. 
Здесь NOT EXISTS выражает именно отсутствие найденной пары.'''

select c.client_id
from clients c
where not exists (select 1 from blacklist b where c.client_id=b.client_id)



#Задание 6
Посчитайте клиентов по городу, заменив NULL на 'unknown'.

clients
client_id	city
1	        Москва
2	        NULL
3	        Москва


select coalesce(city,'unknown'), count(client_id)
from clients
group by coalesce(city,'unknown')



#Задание 7
Посчитайте итоговую сумму как price * qty, если скидка может быть NULL.

sales
sale_id	price	qty	discount
1	    100	    2	10
2	    200	    1	NULL
3	    50	    3	5


select sale_id, price*qty-coalesce(discount,0)
from sales



#Задание 8
Выведите заявки со статусом error или без статуса.

tickets
ticket_id	status
1	        ok
2	        error
3	        NULL

select ticket_id
from tickets
where status='error' or status is null



#Задание 9
Найдите строки, где old_value и new_value отличаются, включая NULL.

changes
id	old_value	new_value
1	A	        A
2	NULL	    B
3	C	        NULL

select id, old_value, new_value
from changes
where (old_value is not null and new_value is not null and old_value<>new_value)
or (old_value is not null and new_value is null) or (old_value is null and new_value is not null)


Эталонное решение
select id
from changes
where old_value IS DISTINCT FROM new_value



#Задание 10
Постройте флаг: заполнен ли email.

clients
client_id	email
1	        a@x.ru
2	        NULL
3	        b@y.ru


select client_id, case when email is null then 0 else 1 end as flag
from clients