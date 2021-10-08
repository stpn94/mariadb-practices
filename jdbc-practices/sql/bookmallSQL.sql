-- DML test
select user(),database();
show tables;
insert into category values(null,'history');
insert into book values(null,'title',10000,1);
insert into cart values(1,1,2);
insert into member values(1,'name',"010-1000-0000","ssss@ssss.sss",password(123));


select * from member;


-- book
select * from book;
insert into book values(null,'title',10000,1);

-- category
select * from category;
insert into category values(null,'history');

-- cart
-- 도서제목 수량 가격

desc cart;

select * from cart;
desc book;
select m.name as name, b.title as title, quantity, b.price*quantity as price from cart c , book b, member m where b.no=c.book_no and m.no = c.member_no;

insert into cart values(1,1,2);

-- member
desc member;
select no, name, phone, email, password from member;
insert into member values(1,'name',"1-1","stpn@sss",password(123));
delete from member where no=5;
delete from member;
update member set name='change' where name ='name'; 


-- order
-- 주문 번호
-- 주문자(이름/이메일)
-- 결제금액
-- 배송지
select cast(o.order_no as int) as orderNo ,m.name as name, price, address from `order` o,member m where o.member_no=m.no;

insert into `order`(no,price,address,member_no) values (null,10000,'대구',1);

select * from `order`;
delete from `order`;


-- orderbook
select * from order_book;

select ,b.no as no, b.title as title, b.price*quantity as price, ob.quantity as quantity, cast(o.order_no as int) as orderNo from book b, `order` o, order_book ob where ob.book_no = b.no and ob.order_no = o.no;


insert into order_book values(1,1,1);
delete from order_book;

