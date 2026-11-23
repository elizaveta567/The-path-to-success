Выведите заказы, где сумма заказа
выше средней суммы предыдущих заказов клиента.

with df_init as (
    select o1.customer_id,o1.order_id, o1.order_date, o1.amount, avg(o2.amount) as avg_prev
    from orders o1 join orders o2 on o1.order_date>o2.order_date and o1.customer_id=o2.customer_id
    group by o1.customer_id,o1.order_id, o1.order_date, o1.amount
)
select c.customer_name, df.order_id, df.order_date, df.amount
from df_init df join customers c on df.customer_id=c.customer_id
where df.amount>df.avg_prev