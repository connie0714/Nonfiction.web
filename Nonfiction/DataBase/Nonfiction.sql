
/* Drop Triggers */

DROP TRIGGER TRI_orders_oseq;
DROP TRIGGER TRI_product_pseq;



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



/* Drop Sequences */

DROP SEQUENCE SEQ_orders_oseq;
DROP SEQUENCE SEQ_product_pseq;


select*from members;

/* Create Sequences */

CREATE SEQUENCE SEQ_orders_oseq INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE SEQ_product_pseq INCREMENT BY 1 START WITH 1;



/* Create Tables */

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
	msg_card varchar2(30) NOT NULL,
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



/* Create Triggers */

CREATE OR REPLACE TRIGGER TRI_orders_oseq BEFORE INSERT ON orders
FOR EACH ROW
BEGIN
	SELECT SEQ_orders_oseq.nextval
	INTO :new.oseq
	FROM dual;
END;

/

CREATE OR REPLACE TRIGGER TRI_product_pseq BEFORE INSERT ON product
FOR EACH ROW
BEGIN
	SELECT SEQ_product_pseq.nextval
	INTO :new.pseq
	FROM dual;
END;

/




/* Comments */

COMMENT ON COLUMN product.price1 IS '원가';
COMMENT ON COLUMN product.price2 IS '판매가';
COMMENT ON COLUMN product.price3 IS '마진';


--회원

select*from members;

insert into members(userid, pwd, name, zip_num, address1, address2, phone, email) values
('hong', '1234', '홍승희', '133-110', '서울시 성동구 성수동1가' , '1번지21호', '017-777-7777','acc@abc.com');

