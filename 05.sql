--group function 싱글, 그룹 리턴값은 1개라는 공통점이 있다.
select avg(salary), max(salary), min(salary), sum(salary)
from employees;

select min(hire_date), max(hire_date) -- 가장 과거 , 가장 최근 날짜
from employees;

-- 과제] 최고월급과 최소급의 차이를 조회하라.
select max(salary) - min(salary)
from employees;

select count(*)
from employees; -- count : 그룹안에 레코드 갯수를 리턴해준다

-- 과제] 70번 부서원이 몇명인지 조회하라.
select count(*)
from employees
where department_id = 70;

select count(employee_id)
from employees;

select count(manager_id)
from employees;

select avg(commission_pct)
from employees;

-- 과제] 조직의 평균 커미션율을 조회하라.
select avg(nvl(commission_pct, 0))
from employees;
---------------------------

select avg(salary)
from employees;

select avg(distinct salary) -- distinct : 중복을 제거하고 계산한다
from employees;

select avg(all salary)
from employees;

-- 과제] 직원이 배치된 부서 개수를 조회하라.
select count(distinct department_id)
from employees;

-- 과제] 매니저 수를 조회하라.
select count(distinct manager_id)
from employees;
--------------------------

select department_id, count(employee_id)
from employees
group by department_id
order by department_id;

select employee_id
from employees
where department_id = 30;

select department_id, job_id, count(employee_id)
from employees
group by department_id
order by department_id; -- error / group by 에 등장한 칼럼은 select에 등장가능하다(+group function도 가능). 반대X

-- 과제] 직업별 사원수를 조회하라.
select job_id, count(employee_id)
from employees
group by job_id;
----------------------

select department_id, max(salary)
from employees
group by department_id
having department_id > 50;  -- having(그룹이 가지고 있는 필드중에 하나를 조건문으로 사용한다.) : 그룹을 골라낸다.

select department_id, max(salary)
from employees
group by department_id
having max(salary) > 10000;

select department_id, max(salary) max_sal
from employees
group by department_id
having max_sal > 10000; -- error (having 에서는 별명을 사용할수 없다.)

select department_id, max(salary)
from employees
where department_id > 50
group by department_id; -- where절 사용시 group by보다 먼저 사용해야한다. 
                        -- (group by having은 그룹을 만들고 골라낸것, where group by는 골라내고 그룹을 만든것)
                      
select department_id, max(salary)
from employees
where max(salary) > 50
group by department_id; -- error   

select job_id, sum(salary) payroll
from employees
where job_id not like '%REP%'
group by job_id
having sum(salary) > 13000
order by payroll;

-- 과제] 매니저ID, 매니저별 관리 직원들 중 최소월급을 조회하라.
--      최소월급이 $6,000 초과여야 한다.
select manager_id, min(salary)
from employees
where manager_id is not null
group by manager_id
having min(salary) > 6000
order by 2 desc;
---------------------------

select max(avg(salary))
from employees
group by department_id;

select sum(max(avg(salary)))
from employees
group by department_id; -- error, to deeply (너무 깊다) 그룹함수는 2개까지 중첩가능하다.

select department_id, round(avg(salary))
from employees
group by department_id;

select department_id, round(avg(salary))
from employees; -- error 싱글과 그룹을 중첩시킬때는 group by가 필요하다.

--과제] 2001년, 2002년, 2003년도별 입사자 수를 찾는다.
select sum(decode(to_char(hire_date, 'yyyy'), '2001', 1, 0)) "2001년",
    sum(decode(to_char(hire_date, 'yyyy'), '2002', 1, 0)) "2002년",
    sum(decode(to_char(hire_date, 'yyyy'), '2003', 1, 0)) "2003년"
from employees;

select count(case when hire_date like '2001%' then 1 else null end) "2001년",
    count(case when hire_date like '2002%' then 1 else null end) "2002년",
    count(case when hire_date like '2003%' then 1 else null end) "2003년"
from employees;   

-- 과제] 직업별, 부서별 월급합을 조회하라.
--      부서는 20, 50, 80 이다.
select job_id, sum(decode(department_id, 20, salary)) "20번부서", 
            sum(decode(department_id, 50, salary)) "50번부서",
            sum(decode(department_id, 80, salary)) "80번부서"
from employees
group by job_id;