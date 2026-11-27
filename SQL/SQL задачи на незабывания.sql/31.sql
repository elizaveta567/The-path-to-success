Выведите заказы, где сумма заказа составляет
более 50% от максимальной суммы заказа клиента.

with df_mx as (
    select customer_id, max(amount) as mx_amount
    from orders
    group by customer_id
)
select o.order_id, c.customer_name, o.amount
from orders o join customers c on o.customer_id=c.customer_id
join df_mx df on df.customer_id=o.customer_id
where o.amount > df.mx_amount*0.5