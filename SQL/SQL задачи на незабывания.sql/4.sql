Выведите клиентов и их заказы, добавив ранг заказов по сумме для каждого клиента. 
Показать только заказы с суммой > 1000.


select c.customer_name, o.order_id, o.amount,
    dense_rank() over(partition by c.customer_id order by o.amount desc) as rnk
from orders o join customers c on o.customer_id=c.customer_id
where o.amount>1000