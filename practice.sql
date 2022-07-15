select last_name || ', ' || job_id "Emp and Title"
from Employees;

select employee_id, last_name, department_id
from employees
where employee_id = 100;

select last_name, hire_date
from employees
where hire_date between '2002/01/01' and '2002/12/31';

select last_name, hire_date
from employees
where hire_date in ('2003/06/17', '2005/09/21');

select last_name, hire_date
from employees
where hire_date like '2005%';

select last_name, job_id
from employees
where job_id like '%\_R%' escape '\';

select last_name, manager_id
from employees
where manager_id is null;