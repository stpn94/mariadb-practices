select version();
select version(), now();
select version(), current_date();
select 10 + 20 as 연산;
select version(), current_time();
select user();

create database webdb;
select database();
use webdb;
show tables;
-- 테이블 생성
CREATE TABLE pet (
    name VARCHAR(20),
    owner VARCHAR(20),
    species VARCHAR(20),
    gender CHAR(1),
    birth DATE,
    death DATE
);
-- describe 테이블 구조 확인
describe pet;

-- Table 삭제
drop table pet;

-- table에 데이터 입력
insert into pet values
('Fluffy','Harold','cat','f','1999-02-04',null),
('Claws','Gwen','cat','m','1994-03-17',null),
('Buffy','Harold','dog','f','1989-05-13',null),
('Fang','Gwen','dog','m','1990-08-27',null),
('Bowser','Diane','dog','m','1998-08-31','1995-07-29'),
('Chirpy','Gwen','bird','f','1998-09-11',null),
('Whistler','Gwen','bird','','1997-12-09',null),
('Slim','Benny','snake','m','1996-04-29',null);

select *
  from pet;
  
LOAD data local infile "pet.txt" INTO Table pet;

