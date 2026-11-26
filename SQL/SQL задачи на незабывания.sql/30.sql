Покажите сотрудников, нанятых в первые 10%
по дате найма в их отделе, и выведите их зарплату.


with df_init as (
    select d.department_name, e.first_name, e.last_name, e.salary, e.hire_date,
           dense_rank()over(partition by d.department_id order by e.hire_date) as rnk,
           count(*)over(partition by d.department_id) as cnt
    from employees e join departments d on e.department_id=d.department_id
)
select department_name, first_name, last_name, salary, hire_date
from df_init
where rnk<=ceil(cnt*0.1)