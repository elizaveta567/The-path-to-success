Выведите сотрудников, чья зарплата выше медианной по их отделу.


with df as (select e.first_name, e.last_name,d.department_name, e.salary,
    percentile_cont(0.5) within group (order by e.salary) over(partition by d.department_id) as median
from employees e join departments d on e.department_id = d.department_id)
select first_name, last_name, department_name, salary
from df
where salary>median


with df as (
    select e.first_name, e.last_name, d.department_name, e.salary,
            row_number()over(partition by d.department_id order by e.salary) as rnk,
            1.0*count(*)over(partition by d.department_id)/2 as cnt_employees
    from employees e join departments d on e.department_id = d.department_id
)
select first_name, last_name, department_name, salary
from df
where rnk>cnt_employees+0.5



#Эталонное решение
with dept_counts as (
    select department_id, count(*) as emp_count
    from employees
    group by department_id
),
median_salary as (
    select department_id, avg(salary) as median_salary
    from (
        select e.department_id, e.salary,
            row_number()over(partition by e.department_id order by e.salary) as rn,
            d.emp_counts
        from employees e join dept_counts d on e.department_id=d.department_id
    )
    where rn in (floor((emp_count+1)/2.0), ceil((emp_count+1)/2.0))
    group by department_id
)
select e.first_name, e.last_name, d.department_name, e.salary
from employees e join departments d on e.department_id=d.department_id
join median_salary ms on e.department_id=ms.department_id
where e.salary>ms.median_salary