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

-- 과제] 위에서 누락된 1인의 이름, 부서번호를 조회하라.
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
where location_id = 1400; -- 테이블에 별명을 붙이면 select절에서 사용가능하다.

select l.city, d.department_name
from locations l join departments d
using (location_id)
where d.location_id = 1400; -- error

select l.city, d.department_name, d.location_id
from locations l join departments d
using (location_id)
where location_id = 1400; -- error (using 칼럼을 사용하면 해당 칼럼에는 별명을 사용할수없다.)

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
where e.manager_id = 100; -- using 칼럼에 사용하지 않았을경우 접두사(별명)을 붙여서 사용해야한다.
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

-- 과제] 위 문장을, using 으로 refactioring 하라.
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

-- 과제] Toronto 에 위치한 부서에서 일하는 사원들의 
--      이름, 직업, 부서번호, 부서명, 도시를 조회하라.
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
on manager_id = employee_id; -- error : self 조인시 접두사가 필수

-- 과제] 같은 부서에서 일하는 사원들의 이름, 부서번호, 동료의 이름을 조회하라.
select e.department_id, e.last_name employee, c.last_name colleague
from employees e join employees c
on e.department_id = c.department_id
and e.employee_id != c.employee_id
order by 1, 2, 3;

-- 과제] Davies 보다 후에 입사한 사원들의 이름, 입사일을 조회하라.
select e.last_name, e.hire_date
from employees e join employees c
on e.hire_date > c.hire_date
and c.last_name = 'Davies'
order by 2;

select last_name, hire_date
from employees
where last_name = 'Davies';