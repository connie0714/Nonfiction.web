
/* Drop Triggers */

DROP TRIGGER TRI_MSG_CARD_mgseq;
DROP TRIGGER TRI_orders_oseq;
DROP TRIGGER TRI_product_pseq;


select*from members;
select*from qna;
delete from qna;

/* Drop Tables */

DROP TABLE admins CASCADE CONSTRAINTS;
DROP TABLE cart CASCADE CONSTRAINTS;
DROP TABLE delivery_man CASCADE CONSTRAINTS;
DROP TABLE delivery CASCADE CONSTRAINTS;
DROP TABLE order_detail CASCADE CONSTRAINTS;
DROP TABLE orders CASCADE CONSTRAINTS;
DROP TABLE qna CASCADE CONSTRAINTS;
DROP TABLE review CASCADE CONSTRAINTS;
DROP TABLE members CASCADE CONSTRAINTS;
DROP TABLE product CASCADE CONSTRAINTS;
DROP TABLE MSG_CARD CASCADE CONSTRAINTS;
DROP TABLE banner CASCADE CONSTRAINTS;


/* Drop Sequences */

DROP SEQUENCE SEQ_MSG_CARD_mgseq;
DROP SEQUENCE SEQ_orders_oseq;
DROP SEQUENCE SEQ_product_pseq;
DROP SEQUENCE SEQ_qna_qseq;
DROP SEQUENCE banner_seq;


select*from members;

/* Create Sequences */

CREATE SEQUENCE SEQ_MSG_CARD_mgseq INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE SEQ_orders_oseq INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE SEQ_product_pseq INCREMENT BY 1 START WITH 1;


alter sequence SEQ_qna_qseq increment by -63;
select SEQ_qna_qseq.nextVal from dual;
alter sequence SEQ_qna_qseq increment by 1;



/* Create Tables */

CREATE TABLE banner(
	bseq NUMBER(5) primary key,
	order_seq NUMBER(2),
	image varchar2(30),
	subject varchar2(30),
	indate DATE default sysdate
);

CREATE SEQUENCE banner_seq INCREMENT BY 1 START WITH 1;

alter table banner add useyn char(1);


CREATE TABLE admins
(
	adminid varchar2(30) NOT NULL,
	pwd varchar2(30) NOT NULL,
	name varchar2(30) NOT NULL,
	phone varchar2(30) NOT NULL,
	PRIMARY KEY (adminid)
);


CREATE TABLE cart
(
	cseq number(10,0) NOT NULL,
	userid varchar2(30) NOT NULL,
	pseq number(10,0) NOT NULL,
	quantity number(10,0) NOT NULL,
	result char(1) DEFAULT '1' NOT NULL,
	indate date DEFAULT SYSDATE,
	PRIMARY KEY (cseq)
);


CREATE TABLE delivery
(
	delivery_id varchar2(30) NOT NULL,
	delivery_status varchar2(30) NOT NULL,
	userid varchar2(30) NOT NULL,
	tracking_number varchar2(30) NOT NULL,
	delivery_date date NOT NULL,
	PRIMARY KEY (delivery_id, delivery_status)
);


CREATE TABLE delivery_man
(
	delivery_man_id varchar2(30) NOT NULL,
	delivery_id varchar2(30) NOT NULL,
	delivery_status varchar2(30) NOT NULL,
	delivery_name varchar2(30) NOT NULL,
	PRIMARY KEY (delivery_man_id)
);


CREATE TABLE members
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

select*from members;


CREATE TABLE MSG_CARD
(
	mgseq number(10,0) NOT NULL,
	msg_content varchar2(50) NOT NULL,
	PRIMARY KEY (mgseq)
);


CREATE TABLE orders
(
	oseq number(10,0) NOT NULL,
	userid varchar2(30) NOT NULL,
	indate date DEFAULT SYSDATE NOT NULL,
	PRIMARY KEY (oseq)
);

select*from orders;

CREATE TABLE order_detail
(
	odseq number(10,0) NOT NULL,
	oseq number(10,0) NOT NULL,
	pseq number(10,0) NOT NULL,
	quantity number(10,0) DEFAULT 1 NOT NULL,
	result char(1) DEFAULT '1' NOT NULL,
	PRIMARY KEY (odseq)
);


CREATE TABLE product
(
	pseq number(10,0) NOT NULL,
	mgseq number(10,0) NOT NULL,
	name varchar2(100) NOT NULL,
	shop char(2) NOT NULL,
	-- 원가
	price1 number(10,0) NOT NULL,
	-- 판매가
	price2 number(10,0) NOT NULL,
	-- 마진
	price3 number(10,0),
	content varchar2(1000) NOT NULL,
	image varchar2(255) NOT NULL,
	bestyn char(1) DEFAULT 'N',
	indate date DEFAULT SYSDATE,
	holidayyn char(1) NOT NULL,
	acc char(1) NOT NULL,
	PRIMARY KEY (pseq)
);


CREATE TABLE qna
(
	qseq number(10,0) NOT NULL,
	userid varchar2(30) NOT NULL,
	subject varchar2(100) NOT NULL,
	content varchar2(1000) NOT NULL,
	reply varchar2(500),
	indate date DEFAULT SYSDATE,
	PRIMARY KEY (qseq)
);


CREATE TABLE review
(
	reseq number(10,0) NOT NULL,
	pseq number(10,0) NOT NULL,
	userid varchar2(30) NOT NULL,
	subject varchar2(30) NOT NULL,
	content varchar2(50) NOT NULL,
	indate date NOT NULL,
	PRIMARY KEY (reseq)
);

CREATE TABLE answer
(
	kind varchar2(100) NOT NULL,
	content varchar2(1000) NOT NULL
);

drop table answer;

/* Create Foreign Keys */

ALTER TABLE delivery_man
	ADD FOREIGN KEY (delivery_id, delivery_status)
	REFERENCES delivery (delivery_id, delivery_status)
;


ALTER TABLE cart
	ADD FOREIGN KEY (userid)
	REFERENCES members (userid)
;


ALTER TABLE delivery
	ADD FOREIGN KEY (userid)
	REFERENCES members (userid)
;


ALTER TABLE orders
	ADD FOREIGN KEY (userid)
	REFERENCES members (userid)
;


ALTER TABLE qna
	ADD FOREIGN KEY (userid)
	REFERENCES members (userid)
;


ALTER TABLE review
	ADD FOREIGN KEY (userid)
	REFERENCES members (userid)
;


ALTER TABLE product
	ADD FOREIGN KEY (mgseq)
	REFERENCES MSG_CARD (mgseq)
;


ALTER TABLE order_detail
	ADD FOREIGN KEY (oseq)
	REFERENCES orders (oseq)
;

select*from order_detail


ALTER TABLE cart
	ADD FOREIGN KEY (pseq)
	REFERENCES product (pseq)
;


ALTER TABLE order_detail
	ADD FOREIGN KEY (pseq)
	REFERENCES product (pseq)
;


ALTER TABLE review
	ADD FOREIGN KEY (pseq)
	REFERENCES product (pseq)
;





/* Comments */

COMMENT ON COLUMN product.price1 IS '원가';
COMMENT ON COLUMN product.price2 IS '판매가';
COMMENT ON COLUMN product.price3 IS '마진';

--회원

select*from members;

insert into members(userid, pwd, name, zip_num, address1, address2, phone, email) values
('hong', '1234', '홍승희', '133-110', '서울시 성동구 성수동1가' , '1번지21호', '017-777-7777','acc@abc.com');



-- 상품

ALTER TABLE product MODIFY mgseq number(10,0) NULL;

ALTER TABLE product DROP COLUMN holidayyn;
ALTER TABLE product DROP COLUMN acc;

select * from PRODUCT;

insert into product(pseq, name, shop, price1, price2, content, image, bestyn)
values(SEQ_product_pseq.nextval, '테스트상품3', '0', '3000', '6000', '테스트 상품입니다', '/CAMPAIGN/campaign3.jpg', 'N');
insert into product(pseq, name, shop, price1, price2, content, image, bestyn)
values(SEQ_product_pseq.nextval, '테스트상품', '1', '3000', '6000', '테스트 상품입니다', '/CAMPAIGN/campaign2.jpg', 'Y');
insert into product(pseq, name, shop, price1, price2, content, image, bestyn)
values(SEQ_product_pseq.nextval, '테스트상품', '2', '3000', '6000', '테스트 상품입니다', '/CAMPAIGN/campaign3.jpg', 'Y');
insert into product(pseq, name, shop, price1, price2, content, image, bestyn)
values(SEQ_product_pseq.nextval, '테스트상품', '3', '3000', '6000', '테스트 상품입니다', '/CAMPAIGN/campaign4.jpg', 'Y');
insert into product(pseq, name, shop, price1, price2, content, image, bestyn)
values(SEQ_product_pseq.nextval, '테스트상품', '4', '3000', '6000', '테스트 상품입니다', '/CAMPAIGN/campaign5.jpg', 'Y');
insert into product(pseq, name, shop, price1, price2, content, image, bestyn)
values(SEQ_product_pseq.nextval, '테스트상품', '5', '3000', '6000', '테스트 상품입니다', '/CAMPAIGN/campaign6.jpg', 'Y');
insert into product(pseq, name, shop, price1, price2, content, image, bestyn)
values(SEQ_product_pseq.nextval, '테스트상품', '6', '3000', '6000', '테스트 상품입니다', '/CAMPAIGN/campaign7.jpg', 'Y');
insert into product(pseq, name, shop, price1, price2, content, image, bestyn)
values(SEQ_product_pseq.nextval, '테스트상품', '7', '3000', '6000', '테스트 상품입니다', '/CAMPAIGN/campaign8.jpg', 'Y');
insert into product(pseq, name, shop, price1, price2, content, image, bestyn)
values(SEQ_product_pseq.nextval, '테스트상품', '8', '3000', '6000', '테스트 상품입니다', '/CAMPAIGN/campaign9.jpg', 'Y');
insert into product(pseq, name, shop, price1, price2, content, image, bestyn)
values(SEQ_product_pseq.nextval, '테스트상품', '9', '3000', '6000', '테스트 상품입니다', '/CAMPAIGN/campaign10.jpg', 'Y');
insert into product(pseq, name, shop, price1, price2, content, image, bestyn)
values(SEQ_product_pseq.nextval, '테스트상품', '10', '3000', '6000', '테스트 상품입니다', '/CAMPAIGN/campaign1.jpg', 'Y');


insert into cart(cseq,userid, pseq, quantity) values(cart_seq.nextval, 'one', 30, 1); 
insert into cart(cseq,userid, pseq, quantity) values(cart_seq.nextval, 'two', 31, 1); 

-- 메세지 카드

insert into MSG_CARD(mgseq, msg_content)
values(SEQ_MSG_CARD_mgseq.nextval, '메세지카드 테스트1');
insert into MSG_CARD(mgseq, msg_content)
values(SEQ_MSG_CARD_mgseq.nextval, '메세지카드 테스트2');


delete from product;



select * from admins;

insert into admins(adminid, pwd, name, phone)
values('admin', 'admin', 'admin', '010-1111-1111');

insert into ANSWER(kind, content) values('주문/배송', '논픽션 공식몰의 경우,<br> 평일 12시 이전 결제 완료 건에 한하여 당일발송 처리를 진행해 드리고 있습니다.<br> 1~3일 이내에 배송될 예정이며,<br> 자세한 배송문의는 운송장 번호를 통해서 저녁 7시 이후부터 조회를 부탁드립니다.<br> 배송조회 전, 운송장번호를 미리 준비해주세요');

delete answer where kind='주문/배송';
	
select * from answer;

select * from cart;
select * from cart_view;

create or replace view cart_view
as
select c.cseq, c.userid, m.name as mname, c.pseq, p.name as pname, c.quantity, p.price2, c.result, c.indate
from cart c, product p, members m
where c.pseq = p.pseq and c.userid = m.userid;

select * from cart_view;





create or replace view order_view
as
select  d.odseq, o.oseq, o.indate, o.userid, 
			m.name as mname, m.zip_num, m.address1, m.address2, m.phone,
			d.pseq, p.price2, d.quantity, d.result, p.name as pname
from orders o, order_detail d, members m, product p
where o.oseq=d.oseq and o.userid=m.userid and d.pseq=p.pseq;

select * from order_view;

alter table qna add secret char(1) default 'N';
alter table qna add pass varchar2(30);




create or replace view cart_view
as
select c.cseq, c.userid, m.name as mname, c.pseq, p.name as pname, c.quantity, p.price2, c.result, c.indate
from cart c, product p, members m
where c.pseq = p.pseq and c.userid = m.userid;

select * from cart_view;





create or replace view order_view
as
select  d.odseq, o.oseq, o.indate, o.userid, 
         m.name as mname, m.zip_num, m.address1, m.address2, m.phone,
         d.pseq, p.price2, d.quantity, d.result, p.name as pname
from orders o, order_detail d, members m, product p
where o.oseq=d.oseq and o.userid=m.userid and d.pseq=p.pseq;

select * from order_view;
