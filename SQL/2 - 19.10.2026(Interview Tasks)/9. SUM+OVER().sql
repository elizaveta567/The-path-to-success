#Задание 1
осчитайте running total операций клиента.

transactions
client_id	operation_dt	amount
100	        2026-04-01	    500
100	        2026-04-03	    -100
200	        2026-04-02	    700


select client_id, operation_dt, amount, sum(amount) (partition by client_id order by operation_dt) as running_total
from transactions



#Задание 2
Для каждой категории покажите долю выручки от общей выручки.

category_sales
category	revenue
books	    100
games	    300
food	    600


select category, revenue, 1.0*revenue/sum(revenue) over() as share
from category_sales



#Задание 3
Покажите долю товара в выручке своей категории.

product_sales
category	product_id	revenue
books	    1	        100
books	    2	        300
games	    3	        500


select category, product_id, revenue, 1.0*revenue / sum(revenue) over(partition by category) as share
from product_sales



#Задание 4
Посчитайте сумму за текущий и два предыдущих дня.

daily_sales
dt	        revenue
2026-04-01	100
2026-04-02	200
2026-04-03	300


select dt, revenue, sum(revenue) over(ORDER BY dt ROWS BETWEEN 2 PRECEDING AND CURRENT ROW)
from daily_sales



#Задание 5
Посчитайте баланс после каждой операции.

operations
account_id	operation_dt	amount
1	        2026-01-01	    1000
1	        2026-01-02	    -200
1	        2026-01-03	    500


select account_id, operation_dt, amount, sum(amount) over(partition by account_id order by operation_dt) as total
from operations



#Задание 6
Покажите рядом с каждым заказом общую сумму заказов клиента.

orders
client_id	order_id	amount
1	        10	        100
1	        11	        200
2	        12	        500


select client_id, order_id, amount, sum(amount) over(partition by client_id) as total
from orders



#Задание 7
Посчитайте накопительную выручку внутри каждого месяца.

orders
order_dt	amount
2026-04-01	100
2026-04-02	200
2026-05-01	300


select order_dt, amount, sum(amount) over(partition by date_trunc('month', order_dt) order by order_dt) as running_revenue
from orders



#Задание 8
Посчитайте накопленные баллы пользователя.

points
user_id	earned_at	points
1	    2026-01-01	10
1	    2026-01-03	20
2	    2026-01-02	15


select user_id, earned_at, points, sum(points) over(partition by user_id order by earned_at)
from points



#Задание 9
По движениям товара посчитайте остаток после каждого движения.

stock_movements
sku_id	movement_dt	qty_delta
10	    2026-01-01	100
10	    2026-01-05	-3
20	    2026-01-01	50

select sku_id, movement_dy, qty_delta, sum(qty_delta) over(partition by sku_id order by movement_dt)
from stock_movements




#Задание 10
Сначала посчитайте дневную выручку, затем накопительную дневную выручку.

orders
order_dt	amount
2026-04-01	100
2026-04-01	200
2026-04-02	300


with t as(
    select order_dt, sum(amount) as revenue
    from orders
    group by order_dt
)
select order_dt, revenue, sum(revenue) over(order by order_dt) as running_revenue
from t