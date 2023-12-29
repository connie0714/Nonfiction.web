CREATE OR REPLACE PROCEDURE GETBESTNEWLIST(
    p_cur1 OUT SYS_REFCURSOR, 
    p_cur2 OUT SYS_REFCURSOR, 
    p_cur3 OUT SYS_REFCURSOR, )
    )
IS
BEGIN
    -- 각 뷰를 조회해서 결과를 OUT 변수에 각각 담아주세요
    OPEN p_cur1 FOR SELECT * FROM new_pro_view;
    OPEN p_cur2 FOR SELECT * FROM best_pro_view;
    OPEN p_cur3 FOR SELECT * FROM banner WHERE order_seq<=5 ORDER BY order_seq;
END;


CREATE OR REPLACE PROCEDURE getMember(
    p_userid IN member.userid%TYPE,
    p_cur OUT SYS_REFCURSOR
)IS
BEGIN
    OPEN p_cur For SELECT * FROM member WHERE userid=p_userid;
END;




CREATE OR REPLACE PROCEDURE joinKakao(
    p_userid IN member.userid%TYPE,
    p_name IN member.name%TYPE,
    p_phone IN member.phone%TYPE,
    p_email IN member.email%TYPE,
    p_provider IN member.provider%TYPE
)
IS
BEGIN
    INSERT INTO member( userid, name, phone, email, provider, pwd)
    VALUES( p_userid , p_name , p_phone, p_email , p_provider, 'kakao' );
    COMMIT;
END;


CREATE OR REPLACE PROCEDURE insertMember(
    p_userid IN member.userid%TYPE,         p_pwd IN member.pwd%TYPE,
    p_name IN member.name%TYPE,             p_phone IN member.phone%TYPE,
    p_email IN member.email%TYPE,           p_zip_num IN member.zip_num%TYPE,
    p_address1 IN member.address1%TYPE,     p_address2 IN member.address2%TYPE,     
    p_address3 IN member.address3%TYPE,     p_provider IN member.provider%TYPE
)
IS
BEGIN
    INSERT INTO member( userid, pwd, name, phone, email, zip_num, address1, address2, address3, provider)
    VALUES( p_userid, p_pwd, p_name, p_phone, p_email, p_zip_num, p_address1, p_address2, p_address3, p_provider );
    COMMIT;
END;



CREATE OR REPLACE PROCEDURE updateMember(
    p_userid IN member.userid%TYPE,         p_pwd IN member.pwd%TYPE,
    p_name IN member.name%TYPE,             p_phone IN member.phone%TYPE,
    p_email IN member.email%TYPE,           p_zip_num IN member.zip_num%TYPE,
    p_address1 IN member.address1%TYPE,     p_address2 IN member.address2%TYPE,     
    p_address3 IN member.address3%TYPE,     p_provider IN member.provider%TYPE
)
IS
BEGIN
    UPDATE member SET pwd=p_pwd, name=p_name, phone=p_phone, email=p_email, zip_num=p_zip_num,
    address1=p_address1, address2=p_address2, address3=p_address3, provider=p_provider
    WHERE userid=p_userid;
    COMMIT;
END;



CREATE OR REPLACE PROCEDURE getKindList(
    p_kind IN product.kind%TYPE, 
    p_cur OUT SYS_REFCURSOR   )
IS
BEGIN
    OPEN p_cur FOR SELECT * FROM product where kind=p_kind;
END;






CREATE OR REPLACE PROCEDURE getProduct(
    p_pseq IN product.pseq%TYPE, 
    p_cur OUT SYS_REFCURSOR   )
IS
BEGIN
    OPEN p_cur FOR SELECT * FROM product where pseq=p_pseq;
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
    -- cart_cur 의 레코드에서 각 데이터를 분리 저장할 변수들
    v_cseq cart.cseq%TYPE;
    v_pseq cart.pseq%TYPE;
    v_quantity cart.quantity%TYPE;
BEGIN
    -- orders 테이블에 레코드를 추가합니다.
    INSERT INTO orders(oseq, userid) VALUES( orders_seq.nextVal, p_userid );
    
    -- orders 테이블에 방금 추가된 레코드의  oseq 를 조회해서 변수에 담습니다.
    SELECT MAX(oseq) INTO v_oseq FROM orders;
    
    -- Cart에서 userid로  상품을 조회합니다
    -- 조회한 상품을 order_detail 에 추가
    -- 카트에서 상품을 지웁니다
    OPEN cart_cur FOR SELECT cseq, pseq, quantity FROM cart WHERE userid=p_userid; -- 카트 조회 및 저장
    LOOP 
        FETCH cart_cur INTO v_cseq, v_pseq, v_quantity;  -- 조회&저장된 카트의 레코드 하나를 필드로 분리
        EXIT WHEN cart_cur%NOTFOUND;  -- 조회&저장된 카트의 내용이 모두 사용(FETCH)되어 더이상 없을때
        INSERT INTO order_detail(odseq, oseq, pseq, quantity)
        VALUES( order_detail_seq.nextVal, v_oseq, v_pseq, v_quantity); -- order_detail 레코드 추가
        DELETE FROM cart WHERE cseq=v_cseq;   -- cart 레코드 삭제
    END LOOP;
    COMMIT;
    -- oseq 를 OUT변수에 저장합니다
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
    INSERT INTO ORDERS(oseq, userid) VALUES( orders_seq.nextVal, p_userid); --orders테이블에 레코드 추가
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


CREATE OR REPLACE PROCEDURE deleteMember(
    p_userid  IN member.userid%TYPE   )
IS
BEGIN
    UPDATE member SET useyn='N' WHERE userid=p_userid;
    COMMIT;    
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





CREATE OR REPLACE PROCEDURE getAdmin(
    p_adminid IN   admins.adminid%TYPE,
    p_rc   OUT     SYS_REFCURSOR )
IS
BEGIN
    OPEN p_rc FOR
        select * from admins where adminid=p_adminid;
END;


CREATE OR REPLACE PROCEDURE adminGetAllCount(
    p_tableName IN VARCHAR2,
    p_key IN VARCHAR2,
    p_cnt  OUT  NUMBER 
)
IS
BEGIN
-- 전달된 KEY 값으로 검색한 결과의 레코드갯수를 조회
IF p_tableName='product' THEN
    SELECT COUNT(*) INTO p_cnt FROM product WHERE name LIKE '%'||p_key||'%';
ELSIF p_tableName='order_view' THEN
    SELECT COUNT(*) INTO p_cnt FROM order_view WHERE pname LIKE '%'||p_key||'%';
ELSIF p_tableName='member' THEN
    SELECT COUNT(*) INTO p_cnt FROM member WHERE name LIKE '%'||p_key||'%';
ELSIF p_tableName='qna' THEN
    SELECT COUNT(*) INTO p_cnt FROM qna 
    WHERE subject LIKE '%'||p_key||'%' OR  content LIKE '%'||p_key||'%';
END IF;
END;



CREATE OR REPLACE PROCEDURE getProductList(
    p_startNum IN NUMBER,
    p_endNum IN NUMBER,
    p_key IN product.name%TYPE,
    p_rc  OUT   SYS_REFCURSOR
)
IS
BEGIN
    OPEN p_rc FOR
        SELECT * FROM (
            SELECT * FROM (
                SELECT rownum as rn, p.* FROM
                (( SELECT * FROM product WHERE name LIKE '%'||p_key||'%'  ORDER BY pseq DESC ) p)
            ) WHERE rn>=p_startNum 
        ) WHERE rn<=p_endNum;
END;







CREATE OR REPLACE PROCEDURE insertProduct(
    p_name IN product.name%TYPE,
    p_kind IN product.kind%TYPE, 
    p_price1 IN product.price1%TYPE,
    p_price2 IN product.price2%TYPE, 
    p_price3 IN product.price3%TYPE, 
    p_content IN product.content%TYPE, 
    p_image IN product.image%TYPE  )
IS
BEGIN
    INSERT INTO product( pseq, name, kind, price1, price2, price3, content, image) 
    VALUES( product_seq.nextVal, p_name, p_kind, p_price1, p_price2, p_price3, p_content, p_image );
    COMMIT;
END;




CREATE OR REPLACE PROCEDURE updateProduct(
    p_name IN product.name%TYPE,        p_kind IN product.kind%TYPE, 
    p_price1 IN product.price1%TYPE,    p_price2 IN product.price2%TYPE, 
    p_price3 IN product.price3%TYPE,    p_content IN product.content%TYPE, 
    p_image IN product.image%TYPE,      p_useyn IN product.useyn%TYPE,
    p_bestyn IN product.bestyn%TYPE,    p_pseq IN product.pseq%TYPE )
IS
BEGIN
    UPDATE  product SET name=p_name, kind=p_kind, price1=p_price1, price2=p_price2, 
    price3=p_price3, content=p_content, image=p_image, useyn=p_useyn, bestyn=p_bestyn
    WHERE pseq=p_pseq;
    COMMIT;
END;



CREATE OR REPLACE PROCEDURE getOrderList(
    p_startNum IN NUMBER,
    p_endNum IN NUMBER,
    p_key IN member.name%TYPE,
    p_rc  OUT   SYS_REFCURSOR
)
IS
BEGIN
    OPEN p_rc FOR
        SELECT * FROM (
            SELECT * FROM (
                SELECT rownum as rn, p.* FROM
                (( SELECT * FROM order_view WHERE pname LIKE '%'||p_key||'%'  ORDER BY result ASC,indate DESC) p)
            ) WHERE rn>=p_startNum 
        ) WHERE rn<=p_endNum;
END;



CREATE OR REPLACE PROCEDURE updateResult(
    p_odseq IN order_detail.odseq%type
)
IS

BEGIN   
    UPDATE order_detail set result=result+1 where odseq=p_odseq;
    commit;

END;


CREATE OR REPLACE PROCEDURE orderEnd(
    p_odseq IN order_detail.odseq%type
)
IS

BEGIN
    UPDATE order_detail SET result='4' WHERE odseq=p_odseq;
    commit;
END;




CREATE OR REPLACE PROCEDURE getMemberList(
    p_startNum IN NUMBER,
    p_endNum IN NUMBER,
    p_key IN member.name%TYPE,
    p_rc  OUT   SYS_REFCURSOR
)
IS
BEGIN
    OPEN p_rc FOR
        SELECT * FROM (
            SELECT * FROM (
                SELECT rownum as rn, p.* FROM
                (( SELECT * FROM member WHERE name LIKE '%'||p_key||'%'  ORDER BY indate DESC) p)
            ) WHERE rn>=p_startNum 
        ) WHERE rn<=p_endNum;
END;




CREATE OR REPLACE PROCEDURE memberReinsert(
    p_userid IN member.userid%type,
    p_useyn IN member.useyn%type
)
IS

BEGIN
    UPDATE member SET useyn=p_useyn WHERE userid=p_userid;
    COMMIT;
END;






CREATE OR REPLACE PROCEDURE getQnaList(
    p_startNum IN NUMBER,
    p_endNum IN NUMBER,
    p_key IN member.name%TYPE,
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




CREATE OR REPLACE PROCEDURE updateQna(
    p_qseq IN qna.qseq%TYPE,         p_reply IN qna.reply%TYPE
   
)
IS
BEGIN
    UPDATE qna SET  reply=p_reply WHERE qseq=p_qseq;
    COMMIT;
END;



CREATE OR REPLACE PROCEDURE getBannerList(
    p_rc OUT SYS_REFCURSOR
)
IS

BEGIN
    OPEN p_rc FOR SELECT*FROM banner ORDER BY order_seq;

END;




CREATE OR REPLACE PROCEDURE insertBanner(
    p_subject IN banner.subject%type,
    p_order_seq IN banner.order_seq%type,
    p_useyn IN banner.useyn%type,
    p_image IN banner.image%type
)
IS
BEGIN
    INSERT INTO banner( bseq,subject, order_seq,useyn, image) 
    VALUES( banner_seq.nextVal, p_subject, p_order_seq, p_useyn, p_image);
    COMMIT;
END;