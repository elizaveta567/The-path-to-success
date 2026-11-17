Выведите клиентов и их заказы, добавив столбец с максимальной суммой
заказа по клиенту. Показать только заказы за последние 6 месяцев.

select c.customer_name, o.order_id, o.order_date, o.amount,
    max(o.amount)over(partition by c.customer_id) as mx_amount
from orders o join customers c on o.customer_id=c.customer_id
where o.order_date>= CURRENT_DATE-INTERVAL '6 months'