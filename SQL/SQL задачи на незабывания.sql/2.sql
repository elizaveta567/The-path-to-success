Выведите сотрудников, чья зарплата выше средней по их отделу,
с указанием отдела и разницы от средней зарплаты.


with df_init as (select e.first_name, e.last_name, d.department_name, e.salary,
avg(salary) over(partition by d.department_id) as avg_department
from employees e join departments d on e.department_id=d.department_id)
select first_name, last_name, department_name, salary, salary-avg_department as diff
from df_init
where salary>avg_department


with avg_department as (
    select department_id, avg(salary) as avg_salary
    from employees
    group by department_id
)
select e.first_name, e.last_name, d.department_name,e.salary, e.salary-ad.avg_salary as diff
from employees e join department d on e.department_id=d.department_id
join avg_department_id ad on e.department_id=ad.department_id
where e.salary>ad.avg_salary