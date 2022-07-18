-- join
select department_id, department_name, location_id
from departments;

select location_id, city
from locations;

-- equi join
select department_id, department_name, location_id, city
from departments natural join locations;

select department_id, department_name, location_id, city
from departments natural join locations
where department_id in (20, 50);

select employee_id, last_name, department_id, location_id
from employees natural join departments;

select employee_id, last_name, department_id, location_id
from employees join departments
using (department_id);

-- ����] ������ ������ 1���� �̸�, �μ���ȣ�� ��ȸ�϶�.
select last_name, department_id
from employees
where department_id is null;

select locations.city, departments.department_name
from locations join departments
using (location_id)
where location_id = 1400;

select l.city, d.department_name
from locations l join departments d
using (location_id)
where location_id = 1400; -- ���̺� ������ ���̸� select������ ��밡���ϴ�.

select l.city, d.department_name
from locations l join departments d
using (location_id)
where d.location_id = 1400; -- error

select l.city, d.department_name, d.location_id
from locations l join departments d
using (location_id)
where location_id = 1400; -- error (using Į���� ����ϸ� �ش� Į������ ������ ����Ҽ�����.)

select e.last_name, d.department_name
from employees e join departments d
using(department_id)
where manager_id = 100; -- error

select e.last_name, d.department_name
from employees e join departments d
using(department_id)
where d.manager_id = 100; 

select e.last_name, d.department_name
from employees e join departments d
using(department_id)
where e.manager_id = 100; -- using Į���� ������� �ʾ������ ���λ�(����)�� �ٿ��� ����ؾ��Ѵ�.
--------------------------

select e.employee_id, e.last_name, e.department_id,
    d.department_id, d.location_id
from employees e join departments d
on (e.department_id = d.department_id);

select employee_id, city, department_name
from employees e join departments d
on e.department_id = d.department_id
join locations l
on d.location_id = l.location_id;

-- ����] �� ������, using ���� refactioring �϶�.
select employee_id, city, department_name
from employees join departments
using(department_id)
join locations
using(location_id);

select e.employee_id, e.last_name, e.department_id,
    d.department_id, d.location_id
from employees e join departments d
on e.department_id = d.department_id
where e.manager_id = 149;

select e.employee_id, e.last_name, e.department_id,
    d.department_id, d.location_id
from employees e join departments d
on e.department_id = d.department_id
and e.manager_id = 149;

-- ����] Toronto �� ��ġ�� �μ����� ���ϴ� ������� 
--      �̸�, ����, �μ���ȣ, �μ���, ���ø� ��ȸ�϶�.
select e.last_name, e.job_id, e.department_id, 
    d.department_name , l.city
from employees e join departments d
on e.department_id = d.department_id
join locations l
on d.location_id = l.location_id 
and l.city = 'Toronto';

select e.last_name, e.salary, e.job_id
from employees e join jobs j
on e.salary between j.min_salary and j.max_salary
and j.job_id = 'IT_PROG';
-----------------------------

-- self join
select worker.last_name emp, manager.last_name mgr
from employees worker join employees manager
on worker.manager_id = manager.employee_id; 

select worker.last_name emp, manager.last_name mgr
from employees worker join employees manager
on manager_id = employee_id; -- error : self ���ν� ���λ簡 �ʼ�

-- ����] ���� �μ����� ���ϴ� ������� �̸�, �μ���ȣ, ������ �̸��� ��ȸ�϶�.
select e.department_id, e.last_name employee, c.last_name colleague
from employees e join employees c
on e.department_id = c.department_id
and e.employee_id != c.employee_id
order by 1, 2, 3;

-- ����] Davies ���� �Ŀ� �Ի��� ������� �̸�, �Ի����� ��ȸ�϶�.
select e.last_name, e.hire_date
from employees e join employees c
on e.hire_date > c.hire_date
and c.last_name = 'Davies'
order by 2;

select last_name, hire_date
from employees
where last_name = 'Davies';