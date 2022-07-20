-- DDL(Data Definition Language)
drop table hire_dates;

create table hire_dates(
id number(8),
hire_date date default sysdate);

select tname from tab; -- data dicitionary

-- 과제] drop table 후, 위 문장을 실행 결과에서, 쓰레기는 제하고, 조회하라.
select tname from tab
where tname not like 'BIN%';

insert into hire_dates values(1, to_date('2025/12/21'));
insert into hire_dates values(2, null);
insert into hire_dates(id) values(3);

commit;

select * from hire_dates;
------------------------------

-- DCL(Data Control Language)
-- system user
create user you identified by you;  -- 유저생성
grant connect, resource to you; -- 권한부여

-- you user
select tname from tab;

create table depts( -- constraint : 제약조건 
department_id number(3) constraint depts_deptid_pk primary key,
department_name varchar2(20));

desc user_constraints

select constraint_name, constraint_type, table_name
from user_constraints;

create table emps(
employee_id number(3) primary key, -- primary : not null + unique
emp_name varchar2(10) constraint emps_empname_nn not null,
email varchar2(20),
salary number(6) constraint emps_sal_ck check(salary > 1000),
department_id number(3),
constraint emps_email_uk unique(email), -- unique : 유일한 값
constraint emps_deptid_fk foreign key(department_id)
    references depts(department_id));
    
select constraint_name, constraint_type, table_name
from user_constraints;  

insert into depts values(100, 'Development');
insert into emps values(500, 'musk', 'musk@gamil.com', 5000, 100);
commit;
delete depts; -- error : foreign key를 쓰는순간 부모자식 관계가 되어 자식이 있을때 부모를 삭제할수없다.

insert into depts values(100, 'Marketing'); -- error : (YOU.DEPTS_DEPTID_PK) violated 
insert into depts values(null, 'Marketing'); -- error : cannot insert NULL
insert into emps values(501, null, 'good@gmail.com', 6000, 100); -- error : cannot insert NULL
insert into emps values(501, 'label', 'musk@gmail.com', 6000, 100); -- error, (YOU.EMPS_EMAIL_UK) violated
insert into emps values(502, 'abel', 'good@gmail.com', 6000, 200); --error : parent key not found

drop table emps cascade constraints;    -- 제약 조건까지 삭제
select constraint_name, constraint_type, table_name
from user_constraints;

-- system user
grant all on hr.departments to you; -- hr 스키마의 departments를 you가 사용할수있게한다.

drop table employees cascade constraints;
create table employees(
employee_id number(6) constraint emp_empid_pk primary key,
first_name varchar2(20),
last_name varchar2(25) constraint emp_lastname_nn not null,
email varchar2(25) constraint emp_email_nn not null
                    constraint emp_email_pk unique,
phone_number varchar2(20),
hire_date date constraint emp_hiredate_nn not null,
job_id varchar2(10) constraint emp_jobid_nn not null,
salary number(8) constraint emp_salary_ck check(salary > 0),
commission_pct number(2, 2),
manager_id number(6) constraint emp_managerid_fk references employees(employee_id),
department_id number(4) constraint emp_dept_fk references hr.departments(department_id));
--------------------------

-- on delete
drop table gu cascade constraints;
drop table dong cascade constraints;
drop table dong2 cascade constraints;

create table gu(
gu_id number(3) primary key,
gu_name char(9) not null);

create table dong(
dong_id number(4) primary key,
dong_name varchar2(12) not null,
gu_id number(3) references gu(gu_id) on delete cascade); -- on delete cascade : 부모에서 delete되면 자신도 delete 된다.

create table dong2(
dong_id number(4) primary key,
dong_name varchar2(12) not null,
gu_id number(3) references gu(gu_id) on delete set null); -- on delete set null : 부모가 delete되면 null로 바꾼다.

insert into gu values(100, '강남구');
insert into gu values(200, '노원구');

insert into dong values(5000, '압구정동', null);
insert into dong values(5001, '삼성동', 100);
insert into dong values(5002, '역삼동', 100);
insert into dong values(6001, '상계동', 200);
insert into dong values(6002, '중계동', 200);

insert into dong2
select * from dong;

delete gu
where gu_id = 100;

select * from dong;
select * from dong2;

commit;
------------------------

-- disable fk
drop table a cascade constraints;
drop table b cascade constraints;

create table a(
aid number(1) constraint a_aid_pk primary key);

create table b(
bid number(2),
aid number(1),
constraint b_aid_fk foreign key(aid) references a(aid));

insert into a values(1);
insert into b values(31, 1);
insert into b values(32, 9); -- error : parent key not found

alter table b disable constraint b_aid_fk; -- 제약조건을 없앤다
insert into b values(32, 9);

alter table b enable constraint b_aid_fk; -- error : 제약조건을 살린다. (하지만 없는 부모가있을경우 error)
alter table b enable novalidate constraint b_aid_fk; -- 기존 위배 데이터는 무시하고 제약조건을 살린다.

insert into b values(33, 8); -- error : parent key not found
------------------------------

drop table sub_departments;

create table sub_departments as
    select department_id dept_id, department_name dept_name
    from hr.departments;

desc sub_departments

select * from sub_departments;
--------------------------

drop table user cascade constraints;

create table users(
user_id number(3));

desc users

alter table users add(user_name varchar2(10));
desc users  -- 칼럼 추가

alter table users modify(user_name number(7));
desc users  -- 칼럼 수정

alter table users drop column user_name;
desc users  -- 칼럼 삭제
-------------------------------

insert into users values(1);

alter table users read only; -- 읽기 전용으로 바꿈
insert into users values(2); -- error : 읽기 전용

alter table users read write; -- 읽기 쓰기로 바꿈
insert into users values(2);

commit;