Выведите сотрудников, чья зарплата растет по
сравнению с предыдущим сотрудником в том же отделе (по дате найма).


with df as (
    select first_name, last_name, salary, hire_date, department_id,
    lag(salary)over(partition by department_id order by hire_date) as prev_salary
    from employees
)
select d.department_name, df.first_name, df.last_name, df.salary, df.hire_date
from df join departments d on d.department_id=df.department_id
where  df.salary>df.prev_salary


'''Тут важно, что первого сотрудника не выводим, его не с кем сравнивать'''