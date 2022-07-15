--group function �̱�, �׷� ���ϰ��� 1����� �������� �ִ�.
select avg(salary), max(salary), min(salary), sum(salary)
from employees;

select min(hire_date), max(hire_date) -- ���� ���� , ���� �ֱ� ��¥
from employees;

-- ����] �ְ���ް� �ּұ��� ���̸� ��ȸ�϶�.
select max(salary) - min(salary)
from employees;

select count(*)
from employees; -- count : �׷�ȿ� ���ڵ� ������ �������ش�

-- ����] 70�� �μ����� ������� ��ȸ�϶�.
select count(*)
from employees
where department_id = 70;

select count(employee_id)
from employees;

select count(manager_id)
from employees;

select avg(commission_pct)
from employees;

-- ����] ������ ��� Ŀ�̼����� ��ȸ�϶�.
select avg(nvl(commission_pct, 0))
from employees;
---------------------------

select avg(salary)
from employees;

select avg(distinct salary) -- distinct : �ߺ��� �����ϰ� ����Ѵ�
from employees;

select avg(all salary)
from employees;

-- ����] ������ ��ġ�� �μ� ������ ��ȸ�϶�.
select count(distinct department_id)
from employees;

-- ����] �Ŵ��� ���� ��ȸ�϶�.
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
order by department_id; -- error / group by �� ������ Į���� select�� ���尡���ϴ�(+group function�� ����). �ݴ�X

-- ����] ������ ������� ��ȸ�϶�.
select job_id, count(employee_id)
from employees
group by job_id;
----------------------

select department_id, max(salary)
from employees
group by department_id
having department_id > 50;  -- having(�׷��� ������ �ִ� �ʵ��߿� �ϳ��� ���ǹ����� ����Ѵ�.) : �׷��� ��󳽴�.

select department_id, max(salary)
from employees
group by department_id
having max(salary) > 10000;

select department_id, max(salary) max_sal
from employees
group by department_id
having max_sal > 10000; -- error (having ������ ������ ����Ҽ� ����.)

select department_id, max(salary)
from employees
where department_id > 50
group by department_id; -- where�� ���� group by���� ���� ����ؾ��Ѵ�. 
                        -- (group by having�� �׷��� ����� ��󳽰�, where group by�� ��󳻰� �׷��� �����)
                      
select department_id, max(salary)
from employees
where max(salary) > 50
group by department_id; -- error                