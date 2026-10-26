#Задание 1
Есть все события пользователей, как определить частоту заходов в приложение и длительность
сессии? Сессия обнуляется, если между событиями прошло 30 минут.
Таблица = table
Доступные поля = event_datetime, user_id, event_name

with t as (
    select user_id, event_datetime,
    lag(event_datetime) over(partition by user_id order by event_datetime) as shift
    from table
),
q as (
    select user_id, event_datetime,event_datetime - shift as diff,
    case when shift is null or (event_datetime - shift)> INTERVAL '30 minutes' then 1 else 0 end as flag
    from t 
),
w as (
    select user_id, event_datetime, diff,
    sum(flag) over(partition by user_id order by event_datetime) as np_sum
    from q
),
r as (
    select user_id, np_sum, max(event_datetime)-min(event_datetime) as time
    from w
    group by user_id, np_sum
)
select user_id, count(np_sum), avg(time)
from r
group by user_id



#Задание 2
Дана таблица product_sales со следующими столбцами:
prod_id - ID товара;
category - Категория товара;
id_sp - ID торговой точки;
sales - Продажи.

prod_id	category	id_sp	sales
1001	Молоко	    50001	190
1002	Молоко	    50001	180
1003	Вода	    50001	110
1004	Фрукты	    50001	120
1005	Фрукты	    50001	150
1002	Молоко	    50002	40
1003	Вода	    50002	160
1004	Фрукты	    50002	80
1001	Молоко	    50003	100
1002	Молоко	    50003	60
1003	Вода	    50003	100
1003	Вода	    50004	140
1004	Фрукты	    50004	190
1005	Фрукты	    50004	20

Необходимо получить следующий результат:
category - Категория товара;
total_sales_sp - Суммарные продажи всех торговых точек, где данная категория присутствовала.

category	total_sales_sp
Молоко	    1210
Вода	    1560
Фрукты	    1300

1) SQL запрос должен обращаться к БД максимум 1 раз;
2) Комбинация prod_id и id_sp уникальна;
3) Необходимо прислать SQL запрос и фотография с результатом его отработки;


with t as(
    select distinct category, id_sp, sum(sales) over(partition by id_sp) as total
    from product_sales
)
select category, sum(total)
from t
group by category



#Задание 3
Даны две таблицы - Products и Orders. Необходимо рассчитать, 
на какую сумму было куплено каждого продукта 01.01.2021.

Таблица Products (столбцы: product_id, price, date_from, date_to):
product_id	price	date_from	date_to
1123	    1100	01.01.2021	01.01.2021
1234	    1200	01.12.2020	30.12.2020
1234	    1150	31.12.2020	31.01.2021

Таблица Orders (столбцы: product_id, quantity, date):
product_id	quantity	date
1123	    2	    01.01.2021
1234	    1	    01.01.2021
1234	    2	    01.01.2021
1123	    1	    02.01.2021


select p.product_id, sum(o.quantity*p.price)
from products p join orders o on p.product_id=o.product_id
and o.date>=p.date_from and o.date<=p.date_to
where o.date = date '01.01.2021'
group by p.product_id