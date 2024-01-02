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


