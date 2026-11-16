Покажите сотрудников, чья зарплата составляет
более 20% от общей суммы зарплат в их отделе.

with df_init as (
    select e.first_name, e.last_name, d.department_name, e.salary,
        sum(e.salary)over(partition by d.department_id) as total
    from employees e join departments d on e.department_id=d.department_id
)
select first_name, last_name, department_name, salary
from df_init
where salary > total*0.2