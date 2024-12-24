
CREATE TABLE TEST(
    TEST_ID NUMBER
);
-- 3_1. SAMPLE계정에 테이블을 생성할 수 있는 권한이 없기 때문에 오류 발생
-- insufficient privileges

-- CREATE TABLE 권한 부여받음!!
CREATE TABLE TEST(
    TEST_ID NUMBER
);
-- tablespace를 할당 받지 못해서 오류 발생
-- no privileges on tablespace

-- TABLESPACE를 할당받은 후
CREATE TABLE TEST(
    TEST_ID NUMBER
);
-- 테이블 생성 완료!

-- 테이블 생성권한을 부여받게 되면 계정이 소유하고 있는 테이블을 조작할 수 있음 ( 조작권한이 같이 옴)

SELECT * FROM TEST;
INSERT INTO TEST VALUES(1);

-- 뷰 만들어보기
CREATE VIEW V_TEST
    AS SELECT * FROM TEST;
-- 4. 뷰 객체를 생성할 수 있는 CREATE VIEW 권한이 없기 때문에 오류 발생
-- insufficient privileges

-- CREATE VIEW 권한 부여 받은 후 
CREATE VIEW V_TEST
    AS SELECT * FROM TEST;
-- 뷰 생성 완료
--------------------------------------------------------------------------------

-- SAMPLE계정에서 KH계정이 가지고 있는 테이블에 접근해서 조회해보기
SELECT * FROM KH.EMPLOYEE;
-- 5. KH계정에 접근해서 조회할 수 있는 권한이 없기 때문에 오류 발생

-- SELECT ON 권한 부여 후
SELECT *
  FROM KH.EMPLOYEE;
  
SELECT * FROM KH.DEPARTMENT;
-- SAMPLE 계정이 받은 권한은 KH.EMPLOYEE뿐이기 때문에 조회 불가.

-- SAMPLE 계정에서 KH계정의 DEPARTMENT테이블에 접근해서 INSERT 해보기
INSERT INTO KH.DEPARTMENT VALUES('DO', '회계부', 'L1');
-- 6. SAMPLE계정은 KH계정의 DEPARTMENT테이블에 접근할 수 있는 권한이 없기 때문에 INSERT를 수행할 수 없음


-- INSERT TO 권한 부여 후
INSERT INTO KH.DEPARTMENT VALUES('D0', '회계부', 'L1');
-- INSERT 성공!

SELECT * FROM KH.DEPARTMENT; -- SELECT는 안 받아서 할 수 없음
ROLLBACK; -- 롤백은 할 수 있음
--------------------------------------------------------------------------------

CREATE TABLE ABC(
    ABC NUMBER
);
-- 7. SAMPLE 계정에서 테이블을 생성할 수 있는 권한을 회수했기 때문에 오류 발생



