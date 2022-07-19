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
from employees e join employees d
on d.last_name = 'Davies'
and e.hire_date > d.hire_date
order by 2;

-- ����] �Ŵ������� ���� �Ի��� ������� �̸�, �Ի���, �Ŵ�����, �����Ի����� ��ȸ�϶�.
select e.last_name emp, e.hire_date, m.last_name mgr, m.hire_date
from employees e join employees m
on e.manager_id = m.employee_id
and e.hire_date < m.hire_date;
-----------------------------------

-- inner join
select e.last_name, e.department_id, d.department_name
from employees e join departments d
on e.department_id = d.department_id;

select e.last_name, e.department_id, d.department_name
from employees e left outer join departments d -- ���ʿ��� �� �̾Ƴ���.
on e.department_id = d.department_id; 

select e.last_name, e.department_id, d.department_name
from employees e right outer join departments d -- �����ʿ��� �� �̾Ƴ���.
on e.department_id = d.department_id; 

select e.last_name, e.department_id, d.department_name
from employees e full outer join departments d -- ����
on e.department_id = d.department_id; 

-- ����] ������� �̸�, ���, �Ŵ�����, �Ŵ����ǻ���� ��ȸ�϶�.
--      king ���嵵 ���̺� �����Ѵ�.
select e.last_name employee, e.employee_id, m.last_name mgr, m.employee_id "MGR_ID"
from employees e left outer join employees m
on e.manager_id = m.employee_id
order by 2;
-----------------------------------

select d.department_id, d.department_name, d.location_id, l.city
from departments d, locations l
where d.location_id = l.location_id;

select d.department_id, d.department_name, d.location_id, l.city
from departments d, locations l
where d.location_id = l.location_id
and d.department_id in (20, 50);

select e.last_name, d.department_name, l.city
from employees e, departments d, locations l
where e.department_id = d.department_id
and d.location_id = l.location_id;

select e.last_name, e.salary, e.job_id
from employees e, jobs j
where e.salary between j.min_salary and j.max_salary
and j.job_id = 'IT_PROG';

select e.last_name, e.department_id, d.department_name
from employees e, departments d
where e.department_id(+) = d.department_id;

select e.last_name, e.department_id, d.department_name
from employees e, departments d
where e.department_id = d.department_id(+);

select e.last_name, e.department_id, d.department_name
from employees e, departments d
where e.department_id(+) = d.department_id(+); -- error : full outer join �� ����.

select worker.last_name || ' works for ' || manager.last_name
from employees worker, employees manager
where worker.manager_id = manager.employee_id;