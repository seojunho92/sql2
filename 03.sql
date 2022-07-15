-- single function

desc dual
select * from dual;

select lower('SQL Course') -- lower : 소문자로 만든다.
from dual;

select upper('SQL Course') -- upper : 대문자로 만든다.
from dual;

select initcap('SQL Course') -- initcap : 각 단어의 첫글자를 대문자로 만든다
from dual;

select last_name
from employees
where last_name = 'higgins';

select last_name
from employees
where last_name = 'Higgins';

select last_name
from employees
where lower(last_name) = 'higgins';

select concat('Hello', 'World') -- concat : 단어를 붙여준다.
from dual;

select substr('HelloWorld', 2, 5) -- substr : 특정 위치의 단어를 자른다.
from dual;
select substr('Hello', -1, 5)
from dual;

select length('Hello') -- length : 단어 길이를 알려준다.
from dual;

select instr('Hello', 'l')
from dual;
select instr('Hello', 'w') -- instr : 특정 값이 있는지 없는지 알수있다.
from dual;

select lpad(salary, 5, '*') -- lpad : 필드의 너비를 정하고 왼쪽을 채운다. 
from employees;

select rpad(salary, 5, '*') -- rpad : 필드의 너비를 정하고 오른쪽을 채운다. 
from employees;

select replace('JACK and JUE', 'J', 'BL') -- replace : 특정 글자를 바꾼다.
from dual;

select trim('H' from 'Hello')
from dual;

select trim('l' from 'Hello')
from dual;

select trim(' ' from ' Hello ')
from dual;
-- 과제] 위 query에서 ' '가 trim 됐음을 눈으로 확인
select '|' || trim(' ' from ' Hello ') || '|'
from dual;

select trim(' Hello World ')
from dual;

select employee_id , concat(first_name, last_name) name,
    job_id, length(last_name), instr(last_name, 'a') "Contains 'a'?"
from employees
where substr(job_id, 4) = 'PROG';

-- 과제] 아래 문장에서, where 절을 like 로 refactoring 하라.
select employee_id , concat(first_name, last_name) name,
    job_id, length(last_name), instr(last_name, 'a') "Contains 'a'?"
from employees
where job_id like '%PROG';

-- 과제] 이름이 J나 A로 M으로 시작하는 사원들의 이름, 이름의 글자수를 조회하라.
--      이름은 대문자 출력한다. 
select initcap(last_name), length(last_name)
from employees
where last_name like 'J%' or
    last_name like 'A%' or
    last_name like 'M%';
-----------------------
    
select round(45.926, 2) -- round : 반올림 (숫자, 자리수)
from dual;
select trunc(45.926, 2) -- trunc : 버림
from dual;
select mod(1600, 300) -- mod : 나머지
from dual;

select round(45.923, 0), round(45.923)
from dual;
select trunc(45.923, 0), trunc(45.923)
from dual;

select last_name, salary, salary - mod(salary, 10000)
from employees;

-- 과제] 사원들의 이름, 월급, 15.5% 이상된 월급(New Salary, 정수), 인상액(Increase)을 조회하라.
select last_name, salary, round(salary * 1.155) "New Salary", round(salary * 1.155) - salary "Increase" 
from employees;
--------------------------

select sysdate  -- sysdate : 서버의 현재시각을 알려준다.
from dual;

select sysdate + 1
from dual;
select sysdate - 1
from dual;

select sysdate - sysdate
from dual;

select last_name, sysdate - hire_date
from employees
where department_id = 90;

-- 과제] 90번 부서 사원들의 이름, 근속년수를 조회하라.
select last_name, trunc((sysdate - hire_date) / 365)
from employees
where department_id = 90;

select months_between('2022/12/31', '2022/12/31') -- months_between : 몇달차이인지 구해주는 API
from dual;

select add_months('2022/07/14', 1) -- add_months : 몇달 뒤의 날짜를 알수있는 AIP
from dual;

select next_day('2022/07/14', 6) -- next_day : 해당 날짜 후 첫번째 요일을 알려준다. (1~7 / 일~토)
from dual;

select next_day('2022/07/14', 'friday') -- next_day : 해당 날짜 후 첫번째 요일을 알려준다. (1~7 / 일~토)
from dual;

select last_day('2022/07/14') -- last_day : 말일 구하기
from dual;

-- 과제] 20년 이상 재작한 사원들의 이름, 첫 월급일을 조회하라.
--       월급을 매월 말일에 지급한다.
select last_name, last_day(hire_date)
from employees
where months_between(sysdate, hire_date) >= 12 * 20;

-- 과제] 사원들의 이름, 월급그래프를 조회하라.
--      그래프는 $1000 당 * 하나를 표시한다.
select last_name, lpad(' ', salary / 1000 + 1, '*') sal
from employees
order by sal desc;