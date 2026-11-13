Выведите сотрудников, чья зарплата выше медианной по их отделу.


with df as (select e.first_name, e.last_name,d.deparment_name, e.salary,
    percentile_cont(0.5) within group (order by e.salary) over(partition by d.deparment_id) as median
from employees e join departments d on e.department_id = d.department_id)
select first_name, last_name, department_name, salary
from df
where salary>median


