Найдите клиентов, у которых максимальная сумма
заказа превышает 5000, и выведите их заказы с рангом по сумме.


with df as (
    select customer_id
    from orders
    group by customer_id
    having max(amount)>5000
)
select c.customer_name, o.order_id, o.amount,
    dense_rank()over(partition by c.customer_id order by o.amount desc) as rnk
from orders o join customers c on c.customer_id=o.customer_id
join df on df.customer_id=o.customer_id