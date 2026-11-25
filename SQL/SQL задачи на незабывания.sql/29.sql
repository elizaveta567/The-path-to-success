Выведите клиентов, у которых средняя сумма
заказа выше средней суммы всех заказов, и их общее количество заказов.

with df_total_avg as (
    select avg(amount) as total_avg
    from orders
),
df_avg_per_customer as (
    select c.customer_id, c.customer_name, avg(o.amount) as avg_customer, count(*) as cnt
    from orders o join customers c on c.customer_id=o.customer_id
    group by c.customer_id, c.customer_name
)
select c.customer_name, c.avg_customer, c.cnt
from df_total_avg a cross join df_avg_per_customer c 
where c.avg_customer>a.total_avg '''или avg_customer>(select total_avg from df_total_avg)'''