Топ-3 зарплат в каждом отделе
employees
departments

Что нужно получить
Найдите топ-3 сотрудников в каждом отделе по зарплате, выведите их имена, отделы и ранг.
Исключите сотрудников с зарплатой ниже 30000.


with df_init as (select e.first_name, e.last_name, d.department_name, d.department_id, e.salary
from employees e join departments d on e.department_id=d.department_id
where e.salary>=30000),
rn as (
    select first_name, last_name, department_name, salary,
    dense_rank() over(partition by department_id order by salary desc) as rn
    from df_init
)
select *
from rn
where rn<=3