Найдите отделы, где максимальная зарплата превышает 100000,
и выведите сотрудников с их долей от максимальной зарплаты.


with df as (
    select department_id, max(salary) as mx_salary
    from employees
    group by department_id
    having max(salary)>100000
)
select d.department_name, e.first_name, e.last_name, 1.0*e.salary/df.mx_salary as share
from employees e join departments d on e.department_id=d.department_id
join df on df.department_id=e.department_id
