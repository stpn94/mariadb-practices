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
    sex CHAR(1),
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
  
LOAD data local infile 'c:\\pet.txt' INTO Table pet;

-- 1998년 이 후에 태어난 동물을 조회할 때:
SELECT *
  FROM pet 
 WHERE birth >= '1998-1-1'; 

-- 암컷 강아지들을 조회 할 때, 논리 연산자 AND를 함께 사용해서:
SELECT *
  FROM pet
 WHERE species = 'dog' || sex = 'm';


-- 뱀과 새를 모두 조회할 때는 논리 연산자 OR와 함께:
SELECT * FROM pet WHERE species = 'snake' OR species ='bird'; 

-- 특정 Row select
select name, birth from pet;



