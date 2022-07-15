-- datatype conversion

select hire_date
from employees
where hire_date = '2003/06/17';

select salary
from employees
where salary = '7000';

select hire_date || ''
from employees;

select salary || ''
from employees;
----------------

select to_char(hire_date)
from employees;

select to_char(sysdate, 'yyyy-mm-dd') 
from dual;

select to_char(sysdate, 'YEAR MONTH DDsp DAY(DY)')
from dual;

select to_char(sysdate, 'Year Month Ddsp Day(Dy)')
from dual;

select to_char(sysdate, 'd')
from dual;

select last_name, hire_date, 
    to_char(hire_date, 'day'), 
    to_char(hire_date, 'd')
from employees;    

-- 과제] 위 테이블을 월요일부터 입사일순 오름차순 정렬하라.
select last_name, hire_date, 
    to_char(hire_date, 'day')
from employees
order by to_char(hire_date -1, 'd');

select to_char(sysdate, 'hh24:mi:ss am')
from dual;

select to_char(sysdate, 'DD "of" Month')
from dual;

select to_char(hire_date, 'fmDD Month RR') --fill mode(fm) : 스페이스 최소화하여 붙인다
from employees;

-- 과제] 사원들의 이름, 입사일, 인사평가일을 조회하라.
--       인사평가일은 입사한지 3개월 후 첫번째 월요일이다.
--       날짜는 YYYY.MM.DD 로 표시한다.
select last_name, to_char(hire_date, 'YYYY.MM.DD') hire_date, 
    to_char(next_day(add_months(hire_date, 3), 'monday'), 'YYYY.MM.DD') review_date
from employees;
---------------------------

select to_char(salary)
from employees;

select to_char(salary, '$99,999.99'),
    to_char(salary, '$00,000.00')
from employees
where last_name = 'Ernst';

select '|' || to_char(12.12, '9999.999') || '|',
    '|' || to_char(12.12, '0000.000') || '|'
from dual;

select '|' || to_char(12.12, 'fm9999.999') || '|',
    '|' || to_char(12.12, 'fm0000.000') || '|'
from dual;

select to_char(1237, 'L9999') -- L : 원 단위 표시
from dual;

-- 과제] <이름> earns <$,월급> monthly but wants <$,월급x3>. 로 조회하라.
select last_name || ' earns ' || to_char(salary, 'fm$99,999') || ' monthly but wants ' || to_char(salary * 3, 'fm$99,999')
from employees;
----------------------------------

select last_name, hire_date
from employees
where hire_date = to_date('Sep 21, 2005', 'Mon dd, yyyy');

select last_name, hire_date
from employees
where hire_date = to_date('Sep 21, 2005', 'Mon  dd yy');

select last_name, hire_date
from employees
where hire_date = to_date('Sep 21, 2005', 'fxMon  dd yy');  -- Format eXtract(fx) : 정확히 일치해야한다.
-------------------------------

select to_number('1237')
from dual;

select to_number('1,237.12')
from dual; -- error

select to_number('1,237.12', '9,999.99')
from dual;
--------------------------------

-- etc
select nvl(null, 0)
from dual;

select job_id, nvl(commission_pct, 0)
from employees;

-- 과제] 사원들의 이름, 직업 ,연봉을 조회하라
select last_name, job_id, salary * (1 + nvl(commission_pct, 0)) * 12 ann_sal
from employees
order by ann_sal desc;

select job_id, nvl2(commission_pct, 'SAL+COMM', 'SAL') income
from employees;

select first_name, last_name, 
    nullif(length(first_name), length(last_name))
from employees; -- nullif : 파라미터 값이 같으면 null 다르면 첫번째 파라미터 값을 리턴

select to_char(null), to_number(null), to_date(null)
from dual;

select last_name, job_id,
    coalesce(to_char(commission_pct), to_char(manager_id), 'None')
from employees;   -- coalesce : 처음으로 null이 아닌값을 리턴한다. 
