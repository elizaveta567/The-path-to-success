#Задание 1
Найдите пользователей, которые смотрели видео 101, но не смотрели 202.

views
user_id	video_id
10	    101
10	    202
20	    101


select user_id
from views
group by user_id
having sum(case when video_id=101 then 1 else 0 end)>0 and
sum(case when video_id=202 then 1 else 0 end)=0


Эталонное решение
select user_id
from views
group by user_id
having max(case when video_id=101 then 1 else 0 end)=1 and
max(case when video_id=202 then 1 else 0 end)=0



#Задание 2
Найдите пользователей, у которых есть purchase и нет refund.

events
user_id	event_type
1	    purchase
1	    refund
2	    purchase


select user_id
from events
group by user_id
having max(case when event_type='purchase' then 1 else 0)=1
and max(case when event_type='refund' then 1 else 0)=0



#Задание 3
Поставьте флаг просрочки платежа.

payments
payment_id	due_dt	    paid_dt
1	        2026-04-01	2026-04-02
2	        2026-04-01	2026-03-31
3	        2026-04-01	NULL


select *, case when paid_dt>due_dt or paid_dt is null then 1 else 0 end as flag
from payments



#Задание 4
Найдите учеников, у которых есть пятерка и нет двоек.

marks
student_id	mark
1	        5
1	        2
2	        5


select student_id
from marks
group by student_id
having max(case when mark=5 then 1 else 0 end)=1
and max(case when mark=2 then 1 else 0 end)=0



#Задание 5
Для каждого клиента постройте флаги наличия debit и credit.

operations
client_id	operation_type
1	        debit
1	        credit
2	        debit


select client_id, max(case when operation_type='debit' then 1 else 0 end) as has_debit,
max(case when operation_type='credit' then 1 else 0 end) as has_credit
from operations
group by client_id



#Задание 6
Найдите пользователей, дошедших до оплаты.

events
user_id	event_type
1	    visit
1	    pay
2	    visit


select user_id
from events
group by user_id
having max(case when event_type='visit' then 1 else 0 end)=1
and min(case when event_type='pay' then 1 else 0 end)=1



#Задание 7
Найдите клиентов, активных и в web, и в mobile.

activity
client_id	channel
1	        web
1	        mobile
2	        web


select client_id
from activity
group by client_id
having max(case when channel='web' then 1 else 0)=1
and max(case when channel='mobile' then 1 else 0)=1


Эталонное решение:
select client_id
from activity
group by client_id
having sum(distinct(case when channel in ('web','mobile') then channel end))=2



#Задание 8
Поставьте флаг, достиг ли клиент суммы покупок 1000.

orders
client_id	amount
1	        400
1	        700
2	        300


select client_id, sum(amount), case when sum(amount)>=1000 then 1 else 0 end as flag
from orders
group by client_id



#Задание 9
Найдите пользователей с регистрацией, но без первого заказа.

events
user_id	event_type
1	    registration
1	    first_order
2	    registration


select user_id
from events
group by user_id
having max(case when event_type='registration' then 1 else 0)=1
and max(case when event_type='first_order' then 1 else 0)=0



#Задание 10
Отметьте первую покупку клиента.

orders
client_id	order_id	order_dt
1	        10	        2026-01-01
1	        11	        2026-01-05
2	        12	        2026-01-03


select o1.client_id, o1.order_id, o1.order_dt, 
(case when o1.order_dt =(select min(o2.order_dt) from orders as o2 where o1.client_id=o2.client_id) then 1 else 0 end) as flag
from orders o1


with t as(
    select client_id, order_id, order_dt, min(order_dt) over(partition by client_id) as mn
    from orders
)
select client_id, order_id, order_dt, case when order_dt=mn then 1 else 0 end as flag
from t