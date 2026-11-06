Выведите клиентов, у которых есть заказы с суммой выше средней
по всем заказам, и добавьте их общее количество заказов.

with df as (
    select avg(amount) as total_avg
    from orders
),
df_1 as (
    select distinct o.customer_id
    from orders o cross join df
    where o.amount>df.total_avg
)
select c.customer_id, c.customer_name, count(*) as total_cnt
from df_1 join orders o on df_1.customer_id=o.customer_id
join customers c on c.customer_id=o.customer_id
group by c.customer_id, c.customer_name



with df as (
    select customer_id, amount, avg(amount)over() as total_avg
    from orders
),
df_1 as (
    select distinct customer_id
    from df
    where amount>total_avg
)
select c.customer_id, c.customer_name, count(*) as total_cnt
from df_1 join orders o on o.customer_id=df_1.customer_id
join customers c on c.customer_id=o.customer_id
group by c.customer_id, c.customer_name


