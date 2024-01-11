-- 승희 member

CREATE OR REPLACE PROCEDURE getMember(
    p_userid IN members.userid%TYPE,
    p_cur OUT SYS_REFCURSOR
)IS
BEGIN
    OPEN p_cur For SELECT * FROM members WHERE userid=p_userid;
END;





CREATE OR REPLACE PROCEDURE insertMember(
    p_userid IN members.userid%TYPE,         p_pwd IN members.pwd%TYPE,
    p_name IN members.name%TYPE,             p_phone IN members.phone%TYPE,
    p_email IN members.email%TYPE,           p_zip_num IN members.zip_num%TYPE,
    p_address1 IN members.address1%TYPE,     p_address2 IN members.address2%TYPE,     
    p_address3 IN members.address3%TYPE
)
IS
BEGIN
    INSERT INTO members( userid, pwd, name, phone, email, zip_num, address1, address2, address3)
    VALUES( p_userid, p_pwd, p_name, p_phone, p_email, p_zip_num, p_address1, p_address2, p_address3);
    COMMIT;
END;



CREATE OR REPLACE PROCEDURE updateMember(
    p_userid IN members.userid%TYPE,         p_pwd IN members.pwd%TYPE,
    p_name IN members.name%TYPE,             p_phone IN members.phone%TYPE,
    p_email IN members.email%TYPE,           p_zip_num IN members.zip_num%TYPE,
    p_address1 IN members.address1%TYPE,     p_address2 IN members.address2%TYPE,     
    p_address3 IN members.address3%TYPE
)
IS
BEGIN
    UPDATE members SET pwd=p_pwd, name=p_name, phone=p_phone, email=p_email, zip_num=p_zip_num,
    address1=p_address1, address2=p_address2, address3=p_address3
    WHERE userid=p_userid;
    COMMIT;
END;



CREATE OR REPLACE PROCEDURE deleteMember(
    p_userid  IN members.userid%TYPE   )
IS
BEGIN
    UPDATE members SET useyn='N' WHERE userid=p_userid;
    COMMIT;    
END;



CREATE OR REPLACE PROCEDURE joinKakao(
    p_userid IN members.userid%TYPE,
    p_name IN members.name%TYPE,
    p_phone IN members.phone%TYPE,
    p_email IN members.email%TYPE,
    p_pwd IN members.pwd%TYPE
)
IS
BEGIN
    INSERT INTO members( userid, name, phone, email, pwd)
    VALUES( p_userid , p_name , p_phone, p_email, p_pwd);
    COMMIT;
END;

-- 승희 qna

CREATE OR REPLACE PROCEDURE insertQna(
    p_userid IN qna.userid%TYPE,
    p_secret IN qna.secret%TYPE,
    p_pass IN qna.pass%TYPE,
    p_subject  IN qna.subject%TYPE,
    p_content  IN qna.content%TYPE )
IS
BEGIN
    insert into qna(qseq, userid, secret, pass, subject, content) 
    values( qna_seq.nextVal, p_userid, p_secret, p_pass, p_subject, p_content );
    commit;    
END;

CREATE OR REPLACE PROCEDURE listQna (
    p_rc   OUT     SYS_REFCURSOR )
IS
BEGIN
    OPEN p_rc FOR
        SELECT * FROM QNA ORDER BY qseq desc;
END;


CREATE OR REPLACE PROCEDURE getQna (
    p_qseq IN   Qna.qseq%TYPE,
    p_rc   OUT     SYS_REFCURSOR )
IS
BEGIN
    OPEN p_rc FOR
        SELECT * FROM qna WHERE qseq=p_qseq;
END;



CREATE OR REPLACE PROCEDURE getQnaList(
    p_startNum IN NUMBER,
    p_endNum IN NUMBER,
    p_key IN members.name%TYPE,
    p_rc  OUT   SYS_REFCURSOR
)
IS
BEGIN
    OPEN p_rc FOR
        SELECT * FROM (
            SELECT * FROM (
                SELECT rownum as rn, p.* FROM
                (( SELECT * FROM qna WHERE subject LIKE '%'||p_key||'%'  OR content LIKE '%'||p_key||'%' ORDER BY qseq DESC) p)
            ) WHERE rn>=p_startNum 
        ) WHERE rn<=p_endNum;
END;





-- 종범 product

CREATE OR REPLACE PROCEDURE getShopList(
    p_shop IN product.shop%TYPE,
    p_cur OUT SYS_REFCURSOR )
IS
BEGIN
    OPEN p_cur FOR SELECT * FROM product WHERE shop=p_shop;
END;



CREATE OR REPLACE PROCEDURE getBestList(
    p_bestyn IN product.bestyn%TYPE,
    p_cur OUT SYS_REFCURSOR )
IS
BEGIN
    OPEN p_cur FOR SELECT * FROM product WHERE bestyn=p_bestyn;
END;




CREATE OR REPLACE PROCEDURE getProduct(
    p_pseq IN product.pseq%TYPE,
    p_cur OUT SYS_REFCURSOR )
IS
BEGIN
    OPEN p_cur FOR SELECT * FROM product WHERE pseq=p_pseq;
END;

CREATE OR REPLACE PROCEDURE insertCart(
    p_userid IN cart.userid%TYPE,
    p_pseq  IN cart.pseq%TYPE,
    p_quantity  IN cart.quantity%TYPE )
IS
BEGIN
    INSERT INTO cart( cseq, userid, pseq, quantity ) 
    VALUES( cart_seq.nextVal, p_userid, p_pseq, p_quantity );
    COMMIT;    
END;




CREATE OR REPLACE PROCEDURE deleteCart(
    p_cseq  IN cart.cseq%TYPE   )
IS
BEGIN
    delete from cart where cseq = p_cseq;
    commit;    
END;








CREATE OR REPLACE PROCEDURE listCart(
    p_userid IN cart.userid%TYPE, 
    p_cur OUT SYS_REFCURSOR   ) 
IS
BEGIN
    OPEN p_cur FOR SELECT * FROM cart_view where userid=p_userid;
END;



CREATE OR REPLACE PROCEDURE insertOrder(
    p_userid IN orders.userid%TYPE,
    p_oseq OUT orders.oseq%TYPE
)
IS
    v_oseq orders.oseq%TYPE;
    cart_cur SYS_REFCURSOR;
    v_cseq cart.cseq%TYPE;
    v_pseq cart.pseq%TYPE;
    v_quantity cart.quantity%TYPE;
BEGIN
    INSERT INTO orders(oseq, userid) VALUES( orders_seq.nextVal, p_userid );
    
    SELECT MAX(oseq) INTO v_oseq FROM orders;
    
    OPEN cart_cur FOR SELECT cseq, pseq, quantity FROM cart WHERE userid=p_userid;
    LOOP 
        FETCH cart_cur INTO v_cseq, v_pseq, v_quantity; 
        EXIT WHEN cart_cur%NOTFOUND; 
        INSERT INTO order_detail(odseq, oseq, pseq, quantity)
        VALUES( order_detail_seq.nextVal, v_oseq, v_pseq, v_quantity);
        DELETE FROM cart WHERE cseq=v_cseq;
    END LOOP;
    COMMIT;
    p_oseq := v_oseq;
    
EXCEPTION WHEN OTHERS THEN
    ROLLBACK;
END;



CREATE OR REPLACE PROCEDURE listOrderByOseq(
    p_oseq IN orders.oseq%TYPE, 
    p_cur OUT SYS_REFCURSOR   )
IS
BEGIN
    OPEN p_cur FOR SELECT * FROM order_view where oseq=p_oseq ORDER BY RESULT;
END;


CREATE OR REPLACE PROCEDURE insertOrderOne(
    p_userid IN orders.userid%TYPE,
    p_pseq IN order_detail.pseq%TYPE,
    p_quantity IN order_detail.quantity%TYPE,
    p_oseq OUT orders.oseq%TYPE
)
IS
    v_oseq orders.oseq%TYPE;
BEGIN
    INSERT INTO ORDERS(oseq, userid) VALUES( orders_seq.nextVal, p_userid); 
    SELECT MAX(oseq) INTO v_oseq FROM orders;
    INSERT INTO order_detail( odseq, oseq, pseq, quantity)
    VALUES( order_detail_seq.nextVal, v_oseq, p_pseq, p_quantity);
    p_oseq := v_oseq;
    COMMIT;
EXCEPTION WHEN OTHERS THEN
    ROLLBACK;
END;





CREATE OR REPLACE PROCEDURE listOrderByIng(
    p_userid IN orders.userid%TYPE,
    p_rc OUT SYS_REFCURSOR
)
IS
BEGIN
    OPEN p_rc FOR
    SELECT DISTINCT oseq FROM order_view 
    WHERE userid=p_userid AND (result='1' OR result='2' OR result='3') ORDER BY OSEQ DESC;
END;




CREATE OR REPLACE PROCEDURE listOrderAll(
    p_userid IN orders.userid%TYPE,
    p_rc OUT SYS_REFCURSOR
)
IS
BEGIN
    OPEN p_rc FOR
    SELECT DISTINCT oseq FROM ORDER_VIEW WHERE userid=p_userid ORDER BY OSEQ DESC;
END;

update order_detail set result='4' where oseq=22;
commit

-- 종범 모달 1:1

CREATE OR REPLACE PROCEDURE getAnswer(
    p_kind IN answer.kind%TYPE,
    p_cur OUT SYS_REFCURSOR
)
IS
BEGIN
     OPEN p_cur FOR SELECT * FROM answer WHERE kind=p_kind;
END;




-- 의훈

CREATE OR REPLACE PROCEDURE getAdmin(
    p_adminid IN   admins.adminid%TYPE,
    p_rc   OUT     SYS_REFCURSOR )
IS
BEGIN
    OPEN p_rc FOR
        select * from admins where adminid=p_adminid;
END;


-- admin product
CREATE OR REPLACE PROCEDURE getProductList(
    p_startNum IN NUMBER,
    p_endNum IN NUMBER,
    p_key IN product.name%TYPE,
    p_rc OUT SYS_REFCURSOR
)
IS
BEGIN
    OPEN p_rc FOR
        SELECT * FROM (
            SELECT * FROM (
                SELECT rownum as rn, p.* FROM
                ( (SELECT * FROM product WHERE name LIKE '%'||p_key||'%' ORDER BY PSEQ DESC) p)
            ) WHERE rn>=p_startNum
        ) WHERE rn<=P_endNum;
END;




-- table들 검색창용
CREATE OR REPLACE PROCEDURE adminGetAllCount(
    p_tableName IN VARCHAR2,
    p_key IN VARCHAR2,
    p_cnt  OUT  NUMBER 
)
IS
BEGIN
-- 전달된 KEY 값으로 검색한 결과의 레코드갯수를 조회
	IF p_tableName='product' THEN
    SELECT COUNT(*) INTO p_cnt FROM product WHERE name LIKE '%'||p_key||'%'
    OR  content LIKE '%'||p_key||'%';
    
    ELSIF p_tableName='qna' THEN
    SELECT COUNT(*) INTO p_cnt FROM qna WHERE subject LIKE '%'||p_key||'%' OR  content LIKE '%'||p_key||'%';
END IF;
END;



-- 종범 member 아이디 찾기 비밀번호 찾기

CREATE OR REPLACE PROCEDURE getEmail(
    p_email IN members.email%TYPE,
    p_cur OUT SYS_REFCURSOR)
IS
BEGIN
       OPEN p_cur FOR
        select * from members where email=p_email;
END;


CREATE OR REPLACE PROCEDURE getPwd(
    p_email IN members.email%TYPE,
    p_userid IN members.userid%TYPE,
    p_cur OUT SYS_REFCURSOR)
IS
BEGIN
       OPEN p_cur FOR
        select * from members where email=p_email and userid=p_userid;
END;







