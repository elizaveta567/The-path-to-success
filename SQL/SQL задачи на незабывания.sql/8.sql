Выведите заказы с указанием, сколько дней прошло с предыдущего заказа того же клиента.

select  c.customer_name,o.order_id, o.order_date
o.order_date-lag(o.order_date)over(partition by c.customer_id order by o.order_date) as prev_day_diff
from orders o join customers c on o.customer_id=c.customer_id