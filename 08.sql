-- set
select employee_id, job_id
from employees
union
select employee_id, job_id
from job_history;               -- 합집합 (중복제거됨)

select employee_id, job_id
from employees
union all
select employee_id, job_id
from job_history;

-- 과제] 과거 직업을 현재 갖고 있는 사원들의 사번, 이름, 직업을 조회하라.
select e.employee_id, e.last_name, e.job_id
from employees e, job_history j
where e.employee_id = j.employee_id
and e.job_id = j.job_id;

select employee_id, job_id
from employees
intersect
select employee_id, job_id
from job_history;           -- 교집합

select employee_id, job_id
from employees
minus
select employee_id, job_id
from job_history;           -- 차집합
------------------------------

select location_id, department_name
from departments
union
select location_id, state_province
from locations;

-- 과제] 위 문장을, service 관점에서 고쳐라.
--      union 을 사용해라
select location_id, department_name, null
from departments
union
select location_id, null, state_province
from locations;

select employee_id, job_id, salary
from employees
union
select employee_id, job_id
from job_history; -- error

-- 과제] 위 문장을 persistence 관점에서 고쳐라.
select employee_id, job_id, salary
from employees
union
select employee_id, job_id, 0
from job_history
order by salary;