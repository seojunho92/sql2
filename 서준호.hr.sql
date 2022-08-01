drop user hr2 cascade;

create user hr2 identified by hr2 default tablespace users;
grant connect, resource to hr2;

create table hr2.laborers (
    laborer_id number(3) constraint laborers_laborerid_pk primary key,
    laborer_name varchar2(25) not null,
    hire_date date not null);

create sequence hr2.laborers_laborerid_seq
    start with 1
    increment by 1
    maxvalue 999;

