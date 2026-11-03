Покажите сотрудников, чья зарплата входит в топ-10% по их отделу, с указанием ранга.

with df as (
    select department_id, ceil(count(*)*0.1) as top_10
    from employees
    group by department_id
),
df_rnk as (
    select e.first_name, e.last_name,d.department_name, df.top_10, e.salary,
    row_number() over(partition by e.department_id order by e.salary desc) as rnk
    from df join employees e on df.department_id=e.department_id
    join departments d on d.department_id=e.department_id
)
select first_name, last_name, department_name, salary, rnk
from df_rnk
where rnk<=top_10



with df_init as (
    select e.first_name, e.last_name, d.deparment_name, e.salary,
    rank()over(partition by d.department_id order by e.salary desc) as rnk,
    count(*) over(partition by d.department_id) as cnt 
    from employees e join departments d on e.department_id=d.department_id
)
select first_name, last_name, department_name, salary, rnk
from df_init
where rnk<=ceil(cnt*0.1)


