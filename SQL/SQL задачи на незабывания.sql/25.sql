Выведите сотрудников и их зарплаты, добавив столбец
с разницей от средней зарплаты по всем сотрудникам, нанятым позже.


with df_init as (
    select e1.department_id, e1.first_name, e1.last_name, e1.salary, e1.hire_date, avg(e2.salary) as total_avg
    from employees e1 join employees e2 on e1.hire_date<e2.hire_date and e1.department_id=e2.department_id
    group by e1.department_id, e1.first_name, e1.last_name, e1.salary, e1.hire_date
)
select d.department_name, df.first_name, df.last_name, df.salary, df.hire_date, df.salary-df.total_avg as diff
from df_init df join departments d on df.department_id=d.department_id

