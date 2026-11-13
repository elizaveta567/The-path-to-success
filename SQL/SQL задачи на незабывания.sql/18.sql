Найдите заказы, где сумма превышает сумму следующего заказа того же клиента.


with df as (
    select c.customer_name, o.order_id, o.amount,
    lead(o.amount)over(partition by c.customer_id order by o.order_date) as next_order
    from orders o join customers c on o.customer_id=c.customer_id
)
select customer_name, order_id, amount
from df
where amount>next_order