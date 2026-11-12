Покажите общее количество заказов по клиентам
и их долю от всех заказов, но только для заказов за 2024 год.


with df as (
    select customer_id, count(*) as cnt, sum(count(*))over() as total_cnt
    from orders
    where extract(year from order_date)=2024
    group by customer_id
)
select c.customer_name, 1.0*df.cnt/nullif(df.total_cnt,0)
from df join customers c on df.customer_id=c.customer_id