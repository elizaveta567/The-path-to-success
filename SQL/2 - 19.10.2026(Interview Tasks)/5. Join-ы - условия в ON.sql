#Задание 1
Подтяните цену товара, действующую на дату продажи.

sales
sale_id	product_id	sale_dt
1	    10	        2026-04-01
2	    10	        2026-04-20
3	    20	        2026-04-10

prices
product_id	price	valid_from	valid_to
10	        500	    2026-01-01	2026-04-15
10	        550	    2026-04-15	2026-12-31
20	        900	    2026-01-01	2026-12-31


select s.sale_id, s.product_id, s.sale_dt, p.price
from sales s join prices p on s.product_id = p.product_id
and s.sale_dt >= p.valid_from and s.sale_dt<p.valid_to

'''Нужно аккуртано смотреть на границы'''



#Задание 2
Подтяните ставку комиссии по диапазону суммы платежа.

payments
payment_id	amount
1	        500
2	        5000
3	        20000

commission_rules
amount_from	amount_to	rate
0	        1000	    0.03
1000	    10000	    0.02
10000	    999999	    0.01


select p.payment_id, p.amount, c.rate
from payments p join commission_rules c on p.amount>=c.amount_from and p.amount<c.amount_to



#Задание 3
Переведите операции в рубли по курсу на дату операции.

operations
operation_id	currency	operation_dt	amount
1	            USD	        2026-04-01	    100
2	            EUR	        2026-04-01	    50
3	            USD	        2026-04-02	    80

rates
currency	rate_dt	    rate
USD	        2026-04-01	92
EUR	        2026-04-01	100
USD	        2026-04-02	93


select o.operation_id, o.currency, o.operation_dt, o.amount*r.rate as rub
from operations o join rates r on
o.currency=r.currency and o.operation_dt=r.rate_dt



#Задание 4
Подтяните сегмент клиента, который действовал на дату заказа.

orders
order_id	client_id	order_dt
1	        1	        2026-01-10
2	        1	        2026-03-10
3	        2	        2026-02-01


client_segments
client_id	segment	valid_from	valid_to
1	        new	    2026-01-01	2026-02-01
1	        vip	    2026-02-01	2026-12-31
2	        base	2026-01-01	2026-12-31


select o.order_id, o.client_id, o.order_dt, c.segment
from orders o join client_segments c on o.client_id=c.client_id 
and o.order_dt >= c.valid_from and o.order_dt < c.valid_to



#Задание 5
Найдите заказы, к которым применим введенный промокод.

orders
order_id	promo_code	order_dt
1	        NY	        2026-01-05
2	        SPRING	    2026-04-10
3	        NY	        2026-02-01

promos
promo_code	date_from	date_to
NY	        2026-01-01	2026-01-31
SPRING	    2026-04-01	2026-05-01
SUMMER	    2026-06-01	2026-07-01


select order_id
from orders o join promos p on o.promo_code=p.promo_code
and o.order_dt>=p.date_from and o.order_dt<p.date_to



#Задание 6
Найдите бронирования, пересекающиеся с ремонтными окнами по одной комнате.

bookings
room_id	start_ts	end_ts
1	    10:00	    12:00
1	    13:00	    14:00
2	    10:00	    11:00

repairs
room_id	start_ts	end_ts
1	    11:00	    13:30
2	    12:00	    13:00
3	    09:00	    10:00


select b.room_id
from bookings b join repairs r
on b.room_id = r.room_id
and b.start_ts<r.end_ts and b.end_ts>r.start_ts



#Задание 7
Соедините пользователей по email без учета регистра.

site_users
user_id	email
1	    A@MAIL.RU
2	    b@mail.ru
3	    c@mail.ru

crm_users
crm_id	email
10	    a@mail.ru
11	    B@MAIL.RU
12	    d@mail.ru

select s.user_id, c.crm_id
from site_users s join crm_users c on lower(s.email)=lower(c.email)



#Задание 8
Подтяните грейд скидки, если сумма заказа попадает в диапазон.

orders
order_id	amount
1	        900
2	        1500
3	        7000

discounts
min_amount	max_amount	discount_pct
0	        1000	    0
1000	    5000	    5
5000	    999999	    10


select o.order_id, o.amount, d.discount_pct
from orders o join discount d on
o.amount>=d.min_amount and o.amount<d.max_amount



#Задание 9
Подтяните отдел сотрудника на дату операции.

operations
operation_id	employee_id	operation_dt
1	            100	        2026-02-01
2	            100	        2026-05-01
3	            200	        2026-03-01

employee_dept
employee_id	department	valid_from	valid_to
100	        sales	    2026-01-01	2026-04-01
100	        risk	    2026-04-01	2026-12-31
200	        sales	    2026-01-01	2026-12-31



select o.operation_id, e.department
from operations o join employee_dept e on o.employee_id=e.employee_id
and o.operation_dt>=e.valid_from and o.operation_dt<e.valid_to



#Задание 10
Выведите всех клиентов и их заказы за апрель, сохранив клиентов без заказов.

clients
client_id
1
2
3

orders
order_id	client_id	order_dt
10	        1	        2026-04-05
11	        1	        2026-03-01
12	        2	        2026-04-10


select c.client_id, o.order_id
from clients c left join orders o on c.client_id = o.client_id
and o.order_dt >= '2026-04-01' and o.order_dt < '2026-05-01'