Покажите клиентов с их общим количеством заказов и рангом
по количеству заказов, но только для клиентов с суммой заказов > 10000.

with df_init as (
    select customer_id, count(*) as total_cnt
    from orders
    group by customer_id
    having sum(amount)>10000
)
select c.customer_name, df.total_cnt, rank()over(order by df.total_cnt desc) as rnk
from df_init df join customers c on c.customer_id=df.customer_id