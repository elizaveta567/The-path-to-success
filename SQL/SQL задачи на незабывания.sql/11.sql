Выведите сотрудников и их зарплаты, добавив столбец с общей суммой зарплат
в их отделе, но только для отделов с более чем 5 сотрудниками.


with df as (
    select department_id
    from employees
    group by department_id
    having count(*)>5
)
select d.department_name,e.first_name, e.last_name, e.salary,
    sum(e.salary)over(partition by e.department_id) as total
from df join employees e on df.department_id=e.department_id
join departments d on d.department_id=e.department_id
