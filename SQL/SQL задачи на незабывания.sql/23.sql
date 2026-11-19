Выведите заказы с указанием, 
сколько заказов было сделано клиентом до текущего заказа.

select c.customer_name, o.order_id, o.order_date, o.amount,
       count(o.order_id) over(partition by c.customer_id order by o.order_date 
       rows between unbounded preceding and current row)-1 as cnt
from orders o join customers c on o.customer_id=c.customer_id