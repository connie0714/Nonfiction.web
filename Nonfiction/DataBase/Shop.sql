
DROP TABLE admins;
DROP TABLE cart;
DROP TABLE order_detail;
DROP TABLE orders;
DROP TABLE qna;
DROP TABLE member;
DROP TABLE product;

select * from orders order by oseq desc

select * from product

/* Create Tables */

CREATE TABLE admins
(
	adminid varchar2(30) NOT NULL,
	pwd varchar2(30) NOT NULL,
	name varchar2(30) NOT NULL,
	phone varchar2(30) NOT NULL,
	PRIMARY KEY (adminid)
);

drop table cart
CREATE TABLE cart
(
	cseq NUMBER(6) NOT NULL,
	userid varchar2(30) NOT NULL,
	pseq  NUMBER(6) NOT NULL,
	quantity  NUMBER(6) NOT NULL,
	result char(1) DEFAULT '1' NOT NULL,
	indate date DEFAULT SYSDATE,
	PRIMARY KEY (cseq)
);


CREATE TABLE member
(
	userid varchar2(30) NOT NULL,
	pwd varchar2(20) NOT NULL,
	name varchar2(30) NOT NULL,
	phone varchar2(30) NOT NULL,
	email varchar2(50) NOT NULL,
	zip_num varchar2(20),
	address1 varchar2(100),
	address2 varchar2(100),
	address3 varchar2(100),
	indate date DEFAULT SYSDATE,
	useyn char(1) DEFAULT 'Y',
	PRIMARY KEY (userid)
);

drop table orders
CREATE TABLE orders
(
	oseq NUMBER(6) NOT NULL,
	userid varchar2(30) NOT NULL,
	indate date DEFAULT SYSDATE NOT NULL,
	PRIMARY KEY (oseq)
);

drop table order_detail
CREATE TABLE order_detail
(
	odseq NUMBER(6) NOT NULL ,
	oseq  NUMBER(6) NOT NULL,
	pseq  NUMBER(6) NOT NULL,
	quantity  NUMBER(6) DEFAULT 1 NOT NULL,
	result char(1) DEFAULT '1' NOT NULL,
	PRIMARY KEY (odseq)
);


CREATE TABLE product
(
	pseq NUMBER(6) NOT NULL,
	name varchar2(100) NOT NULL,
	kind char(1) NOT NULL,
	price1 NUMBER(6) NOT NULL,
	price2 NUMBER(6) NOT NULL,
	price3 NUMBER(6),
	content varchar2(1000) NOT NULL,
	image varchar2(255) NOT NULL,
	useyn char(1) DEFAULT 'Y',
	bestyn char(1) DEFAULT 'N',
	indate date DEFAULT SYSDATE,
	PRIMARY KEY (pseq)
);


CREATE TABLE qna
(
	qseq  NUMBER(6) NOT NULL ,
	userid varchar2(30) NOT NULL,
	subject varchar2(100) NOT NULL,
	content varchar2(1000) NOT NULL,
	reply varchar2(500),
	indate date DEFAULT SYSDATE,
	PRIMARY KEY (qseq)
);



/* Create Foreign Keys */

ALTER TABLE cart
	ADD FOREIGN KEY (userid)
	REFERENCES member(userid)
	ON DELETE CASCADE;


ALTER TABLE orders
	ADD FOREIGN KEY (userid)
	REFERENCES member (userid)
	ON DELETE CASCADE;


ALTER TABLE qna
	ADD FOREIGN KEY (userid)
	REFERENCES member (userid)
	ON DELETE CASCADE;
;


ALTER TABLE order_detail
	ADD FOREIGN KEY (oseq)
	REFERENCES orders (oseq)
	ON DELETE CASCADE;


ALTER TABLE cart
	ADD FOREIGN KEY (pseq)
	REFERENCES product (pseq)
	ON DELETE CASCADE;


ALTER TABLE order_detail
	ADD FOREIGN KEY (pseq)
	REFERENCES product (pseq)
	ON DELETE CASCADE;


-- 제약사항과 동시에 테이블 삭제
DROP TABLE address CASCADE CONSTRAINTS;
DROP TABLE cart CASCADE CONSTRAINTS;
DROP TABLE order_detail CASCADE CONSTRAINTS;
DROP TABLE orders CASCADE CONSTRAINTS;
DROP TABLE qna CASCADE CONSTRAINTS;
DROP TABLE member CASCADE CONSTRAINTS;
DROP TABLE product CASCADE CONSTRAINTS;
DROP TABLE admins CASCADE CONSTRAINTS;

DROP SEQUENCE cart_seq;
DROP SEQUENCE orders_seq;
DROP SEQUENCE order_detail_seq;
DROP SEQUENCE product_seq;
DROP SEQUENCE qna_seq;

CREATE SEQUENCE cart_seq INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE orders_seq INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE order_detail_seq INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE product_seq INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE qna_seq INCREMENT BY 1 START WITH 1;


-- 관리자 입력
insert into admins values('admin', 'admin', '관리자', '010-7777-7777');
insert into admins values('scott', 'tiger', '홍길동', '010-6400-6068');

-- 회원 입력
insert into member(userid, pwd, name, zip_num, address1, address2, phone, email) values
('one', '1111', '김나리', '133-110', '서울시 성동구 성수동1가' , '1번지21호', '017-777-7777','acc@abc.com');
insert into member(userid, pwd, name, zip_num, address1, address2, phone, email)values
('two', '2222', '김길동', '130-120', '서울시 송파구 잠실2동', '리센츠 아파트 201동 505호','011-123-4567','acc@abc.com');

insert into product(pseq, name, kind, price1, price2, price3, content, image) 
values(product_seq.nextval, '크로그다일부츠', '2', 40000, 50000, 10000, '오리지날 크로그다일부츠 입니다.', 'w2.jpg');

insert into product(pseq, name, kind, price1, price2, price3, content, image, bestyn) 
values(product_seq.nextval, '롱부츠', '2', 40000, 50000, 10000, '따뜻한 롱부츠 입니다.', 'w-28.jpg', 'N');

insert into product(pseq,  name, kind, price1, price2, price3, content, image, bestyn) 
values(product_seq.nextval, '힐', '1', 10000, 12000, 2000, '여성용전용 힐', 'w-14.jpg', 'N');

insert into product(pseq,  name, kind, price1, price2, price3, content, image, bestyn)
values(product_seq.nextval, '슬리퍼', '4', 5000, 5500, 500, '편안한 슬리퍼입니다.', 'w-25.jpg', 'Y');

insert into product(pseq,  name, kind, price1, price2, price3, content, image, bestyn)
values(product_seq.nextval, '회색힐', '1', 10000, 12000, 2000, '여성용전용 힐', 'w-23.jpg', 'N');

insert into product(pseq,  name, kind, price1, price2, price3, content, image) 
values(product_seq.nextval, '여성부츠', '2', 12000, 18000, 6000, '여성용 부츠', 'w4.jpg');

insert into product(pseq,  name, kind, price1, price2, price3, content, image, bestyn)
values(product_seq.nextval,  '핑크샌달', '3', 5000, 5500, 500, '사계절용 샌달입니다.', 'w-24.jpg', 'Y');

insert into product(pseq,  name, kind, price1, price2, price3, content, image, bestyn)
values(product_seq.nextval, '슬리퍼', '3', 5000, 5500, 500, '편안한 슬리퍼입니다.', 'w11.jpg', 'Y');

insert into product(pseq,  name, kind, price1, price2, price3, content, image) 
values( product_seq.nextval,  '스니커즈', '4', 15000, 20000, 5000, '활동성이 좋은 스니커즈입니다.', 'w-13.jpg');

insert into product(pseq,  name, kind, price1, price2, price3, content, image, bestyn)
values( product_seq.nextval,  '샌달', '3', 5000, 5500, 500,'사계절용 샌달입니다.', 'w-09.jpg','N');

insert into product(pseq,  name, kind, price1, price2, price3, content, image,bestyn)
values( product_seq.nextval,  '스니커즈', '5', 15000, 20000, 5000,'활동성이 좋은 스니커즈입니다.', 'w-05.jpg','N');




insert into cart(cseq,userid, pseq, quantity) values(cart_seq.nextval, 'one', 2, 1); 
insert into cart(cseq,userid, pseq, quantity) values(cart_seq.nextval, 'two', 3, 1); 


insert into orders( oseq, userid) values(orders_seq.nextVal, 'one');
insert into order_detail(odseq, oseq, pseq, quantity) values(order_detail_seq.nextval, 1, 2, 1);
insert into order_detail(odseq, oseq, pseq, quantity) values(order_detail_seq.nextval, 1, 3, 2);

insert into orders(oseq, userid) values(orders_seq.nextval, 'two');
insert into order_detail(odseq, oseq, pseq, quantity) values(order_detail_seq.nextval, 2, 4, 3);
insert into order_detail(odseq, oseq, pseq, quantity) values(order_detail_seq.nextval, 2, 5, 2);

insert into orders(oseq, userid) values(orders_seq.nextval, 'one');
insert into order_detail(odseq, oseq, pseq, quantity) values(order_detail_seq.nextval, 3, 3, 1);
insert into order_detail(odseq, oseq, pseq, quantity) values(order_detail_seq.nextval, 3, 2, 1);




insert into qna (qseq, subject, content, userid) 
values(qna_seq.nextval, '배송관련 문의입니다', '현재 배송상태와 예상 배송일을 답변 부탁합니다', 'one');
insert into qna (qseq, subject, content, userid) 
values(qna_seq.nextval, '환불관련', '환불절차 안내부탁드려요.... 배송사 선택은 어떻게 되는지도...', 'two');
insert into qna (qseq, subject, content, userid) 
values(qna_seq.nextval, '사이즈 교환 하고 싶어요', '사이즈가 예상보다 작습니다. 교환절차를 안내부탁드려요', 'one');
insert into qna (qseq, subject, content, userid) 
values(qna_seq.nextval, '배송이 많이 지연되고 있습니다', '언제 받을 수 있나요', 'two');
insert into qna (qseq, subject, content, userid) 
values(qna_seq.nextval, '불량품 교환 문의', '교환 또는 환불 등의 안내가 필요합니다. 유선안내부탁드려요', 'one');







-- cart 안의 pseq로 상품이름과  그리고 id로 사용자 이름을 함꼐 조회하는  view를 생성합니다
create or replace view cart_view
as
select c.cseq, c.userid, m.name as mname, c.pseq, p.name as pname, c.quantity, p.price2, c.result, c.indate
from cart c, product p, member m
where c.pseq = p.pseq and c.userid = m.userid;

select * from cart_view;





create or replace view order_view
as
select  d.odseq, o.oseq, o.indate, o.userid, 
			m.name as mname, m.zip_num, m.address1, m.address2, m.phone,
			d.pseq, p.price2, d.quantity, d.result, p.name as pname
from orders o, order_detail d, member m, product p
where o.oseq=d.oseq and o.userid=m.userid and d.pseq=p.pseq;

select * from order_view;



-- 신상품  View 생성
create or replace view new_pro_view
as
select * from
( select rownum, pseq, name, price2, image from product  where useyn='Y'  order by indate desc )
where rownum <= 4;

select * from new_pro_view;


-- 베스트 상품 view 생성
create or replace view best_pro_view
as
select * from
(select rownum, pseq, name, price2, image from product  where bestyn='Y'  order by indate desc) 
where  rownum <=4;

select * from best_pro_view;




alter table member add provider varchar2(20) default 'shop';
select * from member



alter table qna add secret char(1) default 'N';
alter table qna add pass varchar2(30);
select * from qna;

update qna set secret='Y', pass='1234' where qseq=3

commit




create table banner(
	bseq NUMBER(5)primary key,
	order_seq NUMBER(2),
	image varchar2(30),
	subject varchar2(30),
	indate DATE default sysdate
	
);

drop table banner;

create sequence banner_seq increment by 1 start with 1;

alter table banner add useyn char(1);

