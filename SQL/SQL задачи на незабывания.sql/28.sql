Найдите сотрудников, чья зарплата входит в нижние 25% по отделу, и выведите их отдел.

with df as (
    select first_name, last_name, department_id, salary,
           row_number()over(partition by department_id order by salary) as rnk,
           1.0*count(*)over(partition by department_id)/4 as cnt
    from employees
)
select d.department_name, df.first_name, df.last_name, df.salary
from df join departments d on df.department_id=d.department_id
where df.rnk<=ceil(df.cnt)