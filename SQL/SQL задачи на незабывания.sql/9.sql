Найдите отделы, где средняя зарплата выше 50000,
и выведите сотрудников с их рангом по зарплате в этих отделах.


with df as (
    select department_id
    from employees
    group by department_id
    having avg(salary)>50000
)
select d.department_name, e.first_name, e.last_name, e.salary,
dense_rank()over(partition by d.department_id order by e.salary desc) as rnk
from employees e join df on df.department_id=e.department_id
join departments d on d.department_id=e.department_id