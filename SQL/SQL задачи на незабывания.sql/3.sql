Для каждого отдела найдите сотрудника с самой высокой зарплатой 
и выведите его имя, отдел и зарплату. 
Исключите отделы с менее чем 3 сотрудниками.


with df_init as (
    select department_id
    from employees
    group by department_id
    having count(*)>=3
),
df_rnk as (
    select e.first_name, e.last_name, e.salary, d.department_name,
    dense_rank() over(partition by d.department_id order by e.salary desc) as rnk
    from df_init df join employees e on e.department_id=df.department_id
    join departments d on d.department_id=e.department_id
)
select first_name, last_name, salary, department_name
from df_rnk
where rnk=1



with df_init as (
    select department_id
    from employees
    group by department_id
    having count(*)>=3
),
df_max_salary as (
    select d.department_id, max(e.salary) as mx
    from employees e join df_init d on e.department_id=d.department_id
    group by d.department_id
)
select e.first_name, e.last_name, e.salary, d.department_name
from employees e
join df_max_salary df on e.department_id=df.department_id and df.mx=e.salary
join departments d on d.department_id=e.department_id


