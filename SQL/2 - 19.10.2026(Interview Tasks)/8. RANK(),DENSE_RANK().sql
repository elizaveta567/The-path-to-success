#Задание 1
Найдите сотрудников со второй уникальной зарплатой в департаменте.

employees
dep_id	name	salary
10	    Иванов	100
10	    Петрова	90
10	    Сидоров	90


with t as(
    select *, dense_rank()over(partition by dep_id order by salary desc) as rn
    from employees
)
select dep_id, name, salary
from t
where rn=2



#Задание 2
Покажите разницу RANK и DENSE_RANK на одинаковых баллах.

scores
name	score
A	    100
B	    90
C	    90


select name, score, rank() over(order by score desc) as rnk, dense_rank() over(order by score desc) as drnk 
from scores

scores
name	score  rnk  drnk
A	    100    1    1
B	    90     2    2
C	    90     2    2



#Задание 3
Выведите товары, попавшие в топ-3 мест по выручке с учетом ties.

products
product_id	revenue
1	        1000
2	        900
3	        900


with t as (select *, dense_rank() over(order by revenue desc) as drnk
from products)
select product_id, revenue
from t
where drnk<=3

'''В эталонном решении просто rank(), но dense_rank() так то тоже подходит'''



#Задание 4
Посчитайте место каждой команды по очкам.

teams
team	points
A	    10
B	    8
C	    8


select team, points, dense_rank() over(order by points desc) as place
from teams



#Задание 5
Найдите клиентов с третьей уникальной суммой покупок.

client_totals
client_id 	total_amount
1	        1000
2	        800
3	        700


with t as(
    select client_id, total_amount, dense_rank() over(order by total_amount desc) as drnk
    from client_totals
)
select client_id, total_amount
from t
where drnk=3



#Задание 6
Присвойте товарам ранг по продажам внутри месяца.

sales
month_dt	product_id	revenue
2026-01-01	1	        100
2026-01-01	2	        200
2026-02-01	1	        300


select *, dense_rank() over(partition by month_dt order by revenue desc)
from sales



#Задание 7
Найдите худшие 2 результата по score.

results
name	score
A	    10
B	    5
C	    5


with t as(
    select name, score, dense_rank() over(order by score) as rnk
    from results
)
select name,score
from t
where rnk<=2



#Задание 8
Сначала посчитайте выручку по категориям, затем ранжируйте категории.

orders
category	amount
books	    100
books	    200
games	    500


with t as(
    select category, sum(amount) as revenue
    from order 
    group by category
)
select category, revenue, dense_rank() over(order by revenue desc) as drnk
from t



#Задание 9
Выведите всех участников с максимальным баллом.

scores
name	score
A	    100
B	    100
C	    90


with t as(
    select name, score, rank() over(order by score desc) as rnk
    from scores
)
select name, score
from t
where rnk=1



#Задание 10
Для списка значений найдите второе уникальное значение.

numbers
value
5
5
3

with t as(
    select value, dense_rank() over(order by value desc) as drnk
    from numbers
)
select distinct value
from t
where drnk=2