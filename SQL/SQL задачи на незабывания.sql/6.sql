Выведите сумму заказов по клиентам и их долю от общей суммы всех заказов,
но только для клиентов с более чем 2 заказами.


with sum_customer as (
    select customer_id, sum(amount) as amount
    from orders
    group by customer_id
    having count(*)>2
),
total_amount as (
    select sum(amount) as total
    from orders
)
select s.customer_id, c.customer_name, s.amount, 1.0*s.amount/NULLIF(t.total,0) as share
from sum_customer s join customers c on s.customer_id=c.customer_id
cross join total_amount t



with cnt_customer as (
    select customer_id
    from orders
    group by customer_id
    having count(*)>2
)
select c.customer_name, sum(o.amount),
1.0*sum(amount)/sum(sum(amount))over() as amount_share
from orders o join customers s on o.customer_id=c.customer_id
join cnt_customer c on c.customer_id=o.customer_id
group by c.customer_id, c.customer_name