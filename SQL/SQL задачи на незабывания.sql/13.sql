Выведите сотрудников с их зарплатами и кумулятивной
суммой зарплат по отделу, отсортированной по дате найма.


select d.department_name, e.first_name, e.last_name, e.salary, e.hire_date
    sum(e.salary)over(partition by d.department_id order by e.hire_date) as np_sum
from employees e join departments d on e.department_id=d.department_id