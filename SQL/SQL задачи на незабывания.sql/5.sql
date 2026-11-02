Найдите сотрудников, нанятых последними в 
своих отделах, с указанием их имени, отдела и даты найма.


with df_init as (
    select e.first_name, e.last_name, d.department_name, e.hire_date,
    row_number()over(partition by d.department_id order by e.hire_date desc) as rnk
    from employees e join departments d on e.department_id=d.department_id)
select first_name, last_name, department_name, hire_date
from df_init
where rnk=1


with df as (
    select department_id, max(hire_date) as last_employee
    from employees
    group by department_id
)
select e.first_name, e.last_name, d.department_name, e.hire_date
from df join employees e on df.department_id=e.department_id and df.last_employee=e.hire_date
join departments d on d.department_id=e.department_id
