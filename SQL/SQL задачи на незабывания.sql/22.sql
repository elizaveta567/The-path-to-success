Найдите сотрудников, чья зарплата выше средней
зарплаты сотрудников, нанятых в том же году, и выведите их отдел.


with df as (
    select date_trunc('year', hire_date) as year, avg(salary) as total_avg
    from employees
    group by date_trunc('year', hire_date)
)
select e.first_name, e.last_name, e.salary, d.department_name
from employees e join departments d on e.department_id=d.department_id
join df on df.year=date_trunc('year', e.hire_date)
where e.salary>df.total_avg