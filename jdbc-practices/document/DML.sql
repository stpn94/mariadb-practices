-- DML test
select user(),database();


show tables;
desc book;

insert into category values(null,'name');
delete from category;
select * from category;

insert into book values(null,'title',10000,1);
delete from book;
select * from book;

desc member;

insert into member values(null,'name',"1-1","stpn@sss",password(64));
insert into member values('s',1000,"1-1","stpn@sss",123);
select * from member;
