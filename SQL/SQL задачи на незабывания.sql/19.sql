Выведите отделы с более чем 4 сотрудниками и
их среднюю зарплату, добавив ранг отделов по средней зарплате.


with df as (
    select department_id, avg(salary) as avg_salary
    from employees
    group by department_id
    having count(*)>4
)
select d.department_name, df.avg_salary, rank()over(order by df.avg_salary desc) as rnk 
from df join departments d on df.department_id=d.department_id