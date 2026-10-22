#Задание 1
Найдите сотрудников, которые старше руководителя своего отдела.

employees
employee_id	department_id	birth_dt	is_manager
1	        10	            1980-05-10	true
2	        10	            1975-03-20	false
3	        20	            1988-11-01	true


select e1.employee_id
from employees e1 join employees e2 on e1.department_id = e2.department_id
and e1.is_manager=false and e2.is_manager=true and e1.birth_dt < e2.birth_dt

'''Надо аккуратно работать с сравнениями дат'''



#Задание 2
Выведите уникальные пары клиентов из одного города.

clients
client_id	city
1	        Москва
2	        Москва
3	        Казань



select c1.client_id, c2.client_id, c1.city
from clients c1 join clients c2 on c1.city=c2.city and c1.client_id < c2.client_id



#Задание 3
Найдите пары разных клиентов с одинаковым телефоном.

clients
client_id	phone
1	        900
2	        900
3	        911


select c1.client_id, c2.client_id
from clients c1 join clients c2 on c1.phone=c2.phone and c1.client_id < c2.client_id



#Задание 4
Посчитайте место команды по очкам через self join.

teams
team	points
A	    10 
B	    8  
C	    8  


select t1.team, count(distinct t2.team)+1
from teams t1 left join teams t2 on t1.points<t2.points
group by t1.team



#Задание 5
Найдите товары дороже товара с product_id = 1.

products
product_id	price
1	        100
2	        150
3	        90


select p2.product_id, p2.price
from products p1 join products p2 on p1.product_id=1
where p2.price > p1.price



#Задание 6
Найдите пары интервалов одного пользователя, которые пересекаются.

sessions
session_id	user_id	start_ts	end_ts
1	        10	    10:00	    11:00
2	        10	    10:30	    12:00
3	        20	    09:00	    10:00


select s1.start_ts, s1.end_ts, s2.start_ts, s2.end_ts
from sessions s1 join sessions s2 on s1.user_id=s2.user_id and s1.session_id < s2.session_id
and s1.start_ts < s2.end_ts and s2.end_ts > s1.start_ts



#Задание 7
Выведите сотрудника и имя его менеджера.

employees
employee_id	name	manager_id
1	        Иванов	NULL
2	        Петрова	1
3	        Сидоров	1


select e1.name, e2.name
from employees e1 left join employees e2 on e1.manager_id = e2.employee_id

'''В этой задаче нужно вывести как сотрудинков, так и менеджеров(они же тоже сотрудники)'''



#Задание 8
Для каждого результата найдите количество результатов больше него.

scores
id	score
1	100
2	80
3	80


select s1.id, count(s2.score)
from scores s1 left join score s2 on s1.score>s2.score
group by s1.id



#Задание 9
Найдите пары сотрудников из одного отдела, исключая пару с самим собой.

employees
employee_id	department_id
1	        10
2	        10
3	        20


select e1.employees_id, e2.employees_id
from employees e1 join employees e2 on e1.department_id=e2.department_id
and e1.employees_id < e2.employees_id



#Задание 10
Найдите пары заказов одного клиента, где второй заказ дороже первого.

orders
order_id	client_id	amount
1	        10	        100
2	        10	        200
3	        20	        150


select o1.order_id, o2.order_id
from orders o1 join orders o2 on o1.client_id=o2.client_id
and o1.order_id < o2.order_id and o2.amount>o1.amount
