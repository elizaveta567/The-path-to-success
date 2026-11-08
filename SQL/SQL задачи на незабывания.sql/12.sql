Покажите заказы, где сумма заказа выше
средней суммы заказов за тот же месяц, с указанием клиента.

with df as (
    select date_trunc('month', order_date) as order_date, avg(amount) as total_avg
    from orders 
    group by date_trunc('month', order_date)
)
select o.order_id,df.order_date as month, c.customer_name, o.amount, df.total_avg
from df join orders o on date_trunc('month', o.order_date)=df.order_date
join customers c on c.customer_id=o.customer_id
where o.amount>df.total_avg