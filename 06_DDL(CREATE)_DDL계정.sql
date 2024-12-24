/*
    * DDL (DATA DEFINITION LANGUAGE) : 데이터 정의 언어
    
    구조 자체를 정의하는 언어로 주로 DB관리자, 설계자가 사용함.
    
    DDL : CREATE, ALTER, DROP 
    
    오라클에서 제공하는 객체(OBJECT)를 
    새롭게 만들고(CREATE), 구조를 변경하고(ALTER), 구조자체를 삭제하는(DROP)하는 명령문
    
    오라클에서의 객체(구조)들 : 사용자(USER), 테이블(TABLE), 뷰(VIEW), 시퀀스(SEQUENCE), ...
                        인덱스(INDEX), 패키지(PACKAGE), 트리거(TRIGGER), 
                        프로시저(PROCEDURE), 함수(FUNCTION), 동의어(SYNONYM),...
                        
    DML : SELECT(DML로 다뤘다가 DQL로 분리하는게 추세) / INSERT, UPDATE, DELETE
                        
*/

/*
    < CREATE TABLE >
    
    테이블이란? : 행(ROW), 열(COLUMN)로 구성되는 가장 기본적인 데이터베이스 객체
                모든 데이터를 테이블을 통해서 저장함(데이터를 보관하고자 한다면 반드시 테이블을 만들어야 함)
    VIEW-CONTROLLER-DAO-DB에 저장하는데 저장할 공간(구조)가 필요함.구조가 테이블
    
    테이블 만드는 법
    [표현법]
    CREATE TABLE TB_테이블명(TB는 TABLE이라는 의미의 접두어) (
        컬럼명 자료형, -- 여기서도 키워드 USER같은 거 사용하지 않는 것이 좋다
        컬럼명 자료형,
        컬럼명 자료형,
        ...
    
--    테이블 블럭
    )
    
    < 자료형 >
    - 문자(CHAR(크기지정) / VARCHAR2(크기지정)) : 크기 몇 BYTE? BYTE단위. 
                                            숫자, 영문자, 특수문자 => 1글자당 1BYTE
                                            한글, 일본어, 중국어 => 1글자당 3BYTE
    - CHAR(바이트수) : 최대 2000BYTE까지 지정가능
                    고정길이(아무리 작은 값이 들어와도 공백으로 채워서 처음 할당한 크기 유지)
                    주로 들어올 값의 글자수가 정해져 있을 경우 사용.
                    예) 남/여, M/F, 
    - VARCHAR2(크기): VAR는 '가변'을 의미, 2는 '2배'를 의미->CHAR형이 최대 2000BYTE니까 최대 4000BYTE
                    가변길이(적은 값이 들어오면 담긴값에 맞춰서 크기가 줄어듦) --> CLOB, BLOB
    - 숫자(NUMBER) : 정수/ 실수 상관 없이 NUMBER
    - 날짜(DATE) : 년월일.시분초

*/

--> 회원의 정보(아이디, 비밀번호, 이름, 회원가입일)를 담기위한 테이블 생성하기!
CREATE TABLE TB_USER(
    USER_ID     VARCHAR2(15), -- 한 줄에 1컬럼
    USER_PWD    VARCHAR2(20),
    USER_NAME   VARCHAR2(30),
    CREATE_DATE DATE
);

SELECT * FROM TB_USER;
DROP TABLE TB_USER;
/*
    컬럼에 주석달기 == 설명다는 방법
    
    COMMENT ON COLUMN 테이블명.컬럼명 IS '달고싶은설명'
    
    
*/
COMMENT ON COLUMN TB_USER.USER_ID IS '회원아이디';
COMMENT ON COLUMN TB_USER.USER_PWD IS '회원비밀번호';
COMMENT ON COLUMN TB_USER.USER_NAME IS '회원이름';
COMMENT ON COLUMN TB_USER.CREATE_DATE IS '회원가입일';

SELECT * FROM USER_TABLES; -- 만든 테이블들도 테이블로 저장
-- 현재 이 계정이 가지고 있는 테이블들의 전반적인 구조를 확인할 수 있는 데이터 딕셔너리

SELECT * FROM USER_TAB_COLUMNS; 
-- 현재 이 계정이 가지고 있는 테이블들의 모든 컬럼의 정보를 조회할 수 있는 데이터 딕셔너리

-- 데이터 딕셔너리 : 객체들의 정보를 저장하고 있는 시스템 테이블

-- 데이터를 추가할 수 있는 구문 : INSERT --> 한 행 단위로 추가, 값의 순서가 중요. 값을 안 넣을 수 없다(NULL 값이라도 들어가야함)
-- INSERT INTO 테이블명 VALUES(첫 번째 컬럼에 넣을 값, 두 번째 컬럼에 넣을 값, 세 번째 컬럼에 넣을 값...)
INSERT INTO TB_USER VALUES('admin', '1234', '관리자', '2024-09-09'); -- 날짜는 대부분의 형식 다 잘 들어감.
INSERT INTO TB_USER VALUES('user01', 'pass01', '이승철', '2024/10/10');
INSERT INTO TB_USER VALUES('user02', 'pass02', '홍길동', SYSDATE);
--------------------------------------------------------------------------------

INSERT INTO TB_USER VALUES(NULL, NULL, NULL, SYSDATE); -- 아이디, 비밀번호 자리에 NULL값 있으면 안되는데 입력됨
INSERT INTO TB_USER VALUES('user02', 'pass03', '고길동', SYSDATE); -- 중복된 아이디도 들어갈 수 있음.

SELECT * FROM TB_USER;

-- NULL값이나 중복된 아이디값은 유효하지 않은 값들
-- 유효한 데이터값을 유지하기 위해서는 제약조건을 걸어줘야함

--------------------------------------------------------------------------------

/*
    < 제약조건 CONSTRAINT > 
    
    - 테이블에 원하는 데이터값만 유지하기 위해서(보관하기 위해서) 특정 컬럼마다 제약(데이터 무결성 보장을 목적으로)
    - 제약조건을 부여하면 컬럼에 데이터를 삽입 또는 수정할 때마다 제약조건에 위배되지 않는지 검사
    
    - 종류 : NOT NULL, UNIQUE, CHECK, PRIMARY KEY, FOREIGN KEY
    
    - 제약조건을 부여하는 방법 : 컬럼레벨 / 테이블레벨

*/

/*

    1. NOT NULL 제약조건
    해당 컬럼에 반드시 값이 존재해야 할 경우 사용(NULL값이 절대 들어와서는 안 되는 컬럼에 부여)
    INSERT / UPDATE 시 NULL값을 허용하지 않도록 제한
    
    NOT NULL제약조건은 컬럼레벨 방식으로만 부여할 수 있음
*/

-- 새로운 테이블을 생성하면서 NOT NULL제약조건 달기
-- 컬럼레벨방식 : 컬럼명 자료형 제약조건 => 제약조건을 부여하고자 하는 컬럼 뒤에 곧바로 기술
CREATE TABLE TB_USER_NOT_NULL (
    USER_NO NUMBER NOT NULL,
    USER_ID VARCHAR2(15) NOT NULL,
    USER_PWD VARCHAR2(20) NOT NULL,
    USER_NAME VARCHAR2(30),
    GENDER CHAR(3),
    PHONE VARCHAR2(13)
);
DROP TABLE TB_USER_NOT_NULL;
SELECT * FROM TB_USER_NOT_NULL;

INSERT INTO TB_USER_NOT_NULL VALUES(1, 'admin', '1234', '관리자', '남', '010-1234-5678');

INSERT INTO TB_USER_NOT_NULL VALUES(NULL, NULL, NULL, NULL, NULL, NULL); -- NOT NULL 제약조건에 위배

INSERT
  INTO
       TB_USER_NOT_NULL
VALUES
       (
       2, -- 위 열부터 제약조건 위배된 것 알려준다. (계정명, 테이블명, 안되는컬럼명)
       'user01',
       'pass01',
       NULL,
       NULL,
       NULL
       ); -- NOT NULL 제약조건이 부여되어 있는 컬럼에는 반드시 NULL이 아닌 값이 존재해야함!
       
SELECT * FROM TB_USER_NOT_NULL;

INSERT
  INTO
       TB_USER_NOT_NULL
VALUES
       (
       3,
       'user01', --중복
       '1234',
       NULL,
       NULL,
       NULL
       );
--------------------------------------------------------------------------------
/*
    2. UNIQUE 제약조건
    컬럼에 중복값을 제한하는 제약조건
    INSERT / UPDATE 시 기존에 해당 컬럼값 중 중복값이 있을 경우 추가 또는 수정을 할 수 없도록 제약
    
    컬럼레벨 / 테이블 레벨 방식 둘 다 가능 (NOT NULL은 컬럼에만 가능)
*/

--CREATE -- 구조를 생성
--INSERT -- 만들어진 구조에 데이터 추가

CREATE TABLE TB_USER_UNIQUE(
    USER_NO   NUMBER       NOT NULL,
    USER_ID   VARCHAR2(15) NOT NULL UNIQUE, -- 컬럼 선언 뒤에 제약조건 붙이는 것을 컬럼레벨방식이라고 함.
    USER_PWD  VARCHAR2(20) NOT NULL,
    USER_NAME VARCHAR2(30),
    GENDER    CHAR(3),
    PHONE     VARCHAR2(13)
);
DROP TABLE TB_USER_UNIQUE;
--> 테이블 지우는 법


CREATE TABLE TB_USER_UNIQUE(
    USER_NO   NUMBER       NOT NULL,
    USER_ID   VARCHAR2(20), 
    USER_PWD  VARCHAR2(20) NOT NULL,
    USER_NAME VARCHAR2(30),
    GENDER    CHAR(3),
    PHONE     VARCHAR2(13),
    UNIQUE(USER_ID) -- USER_ID 컬럼에 UNIQUE 제약조건
);

SELECT * FROM TB_USER_UNIQUE;

INSERT INTO TB_USER_UNIQUE VALUES(1, 'admin', '1234', NULL, NULL, NULL);
INSERT INTO TB_USER_UNIQUE VALUES(2, NULL, '3456', NULL, NULL, NULL);
-- UNIQUE 제약조건에 위배되었으므로 INSERT는 실패
-- 오류구문으로 유니크 제약조건이 위배되었다는 사실을 알려주기는 하지만 어떤 컬럼의 문제인지는 안 알려줌
-- 쉽게 파악하기 어렵다는 문제가 있음 --> 제약조건 부여시 시스템이 알아서 임의의 제약조건명을 부여 SYS_C~~ 접속-테이블-제약조건에서 확인할 수 있음
INSERT INTO TB_USER_UNIQUE VALUES(3, NULL, '3456', NULL, NULL, NULL);
/*
    * 제약조건 부여 시 제약조건명도 지정하는 방법
    > 컬럼레벨 방식
    CREATE TABLE 테이블명(
        컬럼명 자료형,
        컬럼명 자료형 CONSTRAINT 제약조건명 제약조건,
    );
    
    > 테이블레벨 방식
    CREATE TABLE 테이블명(
        컬럼명 자료형,
        컬럼명 자료형,
        CONSTRAINT 제약조건명 제약조건(컬럼명)
    );
*/

CREATE TABLE TB_USER_CONSTRAINT(
    USER_NUMBER NUMBER CONSTRAINT NUM_NOT_NULL NOT NULL,
    USER_ID     VARCHAR2(20) NOT NULL,
    USER_PWD    VARCHAR2(20) NOT NULL,
    USER_NAME   VARCHAR2(30),
    GENDER      CHAR(3),
    PHONE       CHAR(13),
    CONSTRAINT USER_ID_UNIQUE UNIQUE(USER_ID)
);
-- 그런데 어차피 NOT NULL은 어디 컬럼이 문제인지 자세히 알려줘서 CONSTRAINT 할 필요 없음
INSERT INTO TB_USER_CONSTRAINT VALUES(1, 'admin', '1234', NULL, NULL, NULL);
INSERT INTO TB_USER_CONSTRAINT VALUES(2, 'admin', '3456', NULL, NULL, NULL);
-- 제약조건명을 지정하면 오류 발생 시 문제가 생긴 컬럼을 조금 더 쉽게 유추할 수 있음

INSERT INTO TB_USER_CONSTRAINT VALUES(3, 'user01', 'pass01', NULL, '밥', NULL);
SELECT * FROM TB_USER_CONSTRAINT;
-- GENDER 컬럼에는 '남' 또는 '여'라는 값만 들어가게 하고 싶음
--------------------------------------------------------------------------------
/*
    3. CHECK 제약조건
    컬럼에 기록될 수 있는 값에 대한 조건을 설정할 수 있음!
    
    CHECK(조건식)
*/

CREATE TABLE TB_USER_CHECK(
    USER_NUMBER NUMBER NOT NULL,
    USER_ID VARCHAR2(20) NOT NULL UNIQUE,
    USER_PWD VARCHAR2(20) NOT NULL,
    USER_NAME VARCHAR2(20),
    GENDER CHAR(3) CHECK(GENDER IN ('남', '여')), -- 조건식의 결과에 부합해야만 컬럼의 값에 INSERT할 수 있음.
    PHONE VARCHAR2(13), 
    ENROLL_DATE DATE
);
SELECT * FROM TB_USER_CHECK;

INSERT INTO TB_USER_CHECK VALUES(1, 'admin', '1234', NULL, '여', NULL, SYSDATE);
INSERT INTO TB_USER_CHECK VALUES(2, 'user01', '2345', NULL, '밥', NULL, SYSDATE);

INSERT INTO TB_USER_CHECK VALUES(3, 'user02', 'pass02', NULL, NULL, NULL, SYSDATE);
-- CHECK 제약조건을 부여했어도 NULL값을 INSERT할 수 있다 -> NULL값이 들어오는 것을 막고 싶다면 NOT NULL 제약조건을 같이 부여해야한다.

-- 회원가입일을 항상 SYSDATE값으로 받고 싶은 경우 테이블에서 지정 가능!
--------------------------------------------------------------------------------
/*
    * 특정 컬럼에 들어올 값에 대해 기본값을 설정하는 방법 => 제약조건은 아님. (뒤에 PK 기본키랑 다른말, 기본값 설정)
    
    -- 테이블 만들기 실습--
    테이블 명 : TB_USER_DEFAULT
    컬럼 : 
        1. 회원 번호를 저장할 컬럼 : NULL값 금지
        2. 회원 아이디를 저장할 컬럼 : NULL값 금지, 중복값 금지
        3. 회원 비밀번호를 저장할 컬럼 : NULL값 금지,
        4. 회원 이름을 저장할 컬럼
        5. 회원 닉네임을 저장할 컬럼 : 중복값 금지
        6. 회원 성별을 저장할 컬럼 : '남' 또는 '여'만 INSERT할 수 있음
        7. 전화번호 저장
        8. 이메일 저장
        9/ 주소 저장
        10. 가입일 저장 :  NULL값 금지
*/

CREATE TABLE TB_USER_DEFAULT(
    USER_NUMBER NUMBER NOT NULL,
    USER_ID VARCHAR2(20),
    USER_PWD VARCHAR2(20) NOT NULL,
    USER_NAME VARCHAR2(30),
    USER_NICKNAME VARCHAR2(20) CONSTRAINT USER_NICKNAME_UNIQUE UNIQUE,
    GENDER CHAR(3) CONSTRAINT GENDER_CHECK CHECK(GENDER IN ('남', '여')),
    PHONE CHAR(13),
    USER_EMAIL VARCHAR2(30),
    USER_ADDRESS VARCHAR2(150),
    ENROLL_DATE DATE DEFAULT SYSDATE NOT NULL,
    UNIQUE (USER_ID, USER_NUMBER) -- 여러개 하고싶으면 여러개***
);

DROP TABLE TB_USER_DEFAULT;
-- INSERT INTO TB_USER_DEFAULT VALUES(1, 'admin', 'pass01', NULL, NULL, '여', NULL, NULL, NULL, NULL);
-- DEFAULT 해서 NULL 값도 안 들어감

/*
    INSERT INTO 테이블명(컬럼명1, 컬럼명2, 컬럼명3, ...) 
    VALUES (값1, 값2, 값3, ...)
*/
INSERT
  INTO
       TB_USER_DEFAULT
       (
       USER_NUMBER,
       USER_ID,
       USER_PWD
       )
VALUES
       (
       1,
       'admin',
       'pass01'
       );
       
SELECT * FROM TB_USER_DEFAULT;
-- 지정 안 된 컬럼은 기본적으로 NULL값이 들어가있음
-- 만일 DEFAULT값이 부여되어 있다면 NULL값 대신 DEFAULT로 지정해놓은 값이 INSERT됨!
--------------------------------------------------------------------------------
/*
    4.  PRIMARY KEY(기본키) 제약조건 *****중요****
    
    핸드폰 번호 , 비밀번호, 닉네임..
    A
    010-1234-5678 aaaa 나는A야
    
    B
    010-1234-5678 BBBB 나는B야
    -- 핸드폰번호로 A, B를 식별할 수 없음
    
***** 테이블에서 각 행들의 정보를 유일하게 식별할 용도의 컬럼에 부여하는 제약조건
    -> 각 행들을 구분할 수 있는 식별자의 역할
        예) 회원번호, 게시글번호, 학번, 사번, 예약번호, 주문번호...
    -> 중복이 발생해선 안되고, 값이 존재해야만 하는 컬럼에 PRIMARY KEY 부여
    
    한 테이블 당 한 번만 사용 가능
*/

CREATE TABLE TB_USER_PK(
    USER_NO   NUMBER CONSTRAINT PK_USER PRIMARY KEY, -- 컬럼 레벨 방식
    USER_ID   VARCHAR2(15) NOT NULL UNIQUE,
    USER_PWD  VARCHAR2(20) NOT NULL,
    USER_NAME VARCHAR2(30),
    GENDER    CHAR(3) CHECK(GENDER IN ('남','여')),
    PHONE     VARCHAR2(13)
    -- PRIMARY KEY(USER_NO) 테이블레벨 방식
);
DROP TABLE TB_USER_PK;
INSERT INTO TB_USER_PK
VALUES (1, 'admin', '1234', NULL, NULL, NULL);

INSERT INTO TB_USER_PK
VALUES (1, 'user01', '3456', NULL, NULL, NULL);
-- UNIQUE 제약조건 위배 == 기본키 컬럼에는 중복값을 INSERT할 수 없음

INSERT INTO TB_USER_PK
VALUES (NULL, 'user02', '4567', NULL, NULL, NULL);
-- NOT NULL 제약조건 위배 == 기본키 컬럼에는 NULL값을 INSERT할 수 없음

CREATE TABLE TB_PRIMARYKEY(
    USER_NO NUMBER PRIMARY KEY,
    USER_ID VARCHAR2(15) PRIMARY KEY,
    USER_PWD VARCHAR2(20)
);
-- table can have only one primary key
-- 두 개의 컬럼에 각각 PRIMARY KEY 제약조건을 부여할 수 없음
-- 두 개의 컬럼을 묶어서 하나의 PRIMARY KEY로 만들 수 있음
--->> 예시. 찜 목록
DROP TABLE PRODUCT;
CREATE TABLE PRODUCT(
    NAME VARCHAR2(15),
    PRODUCT VARCHAR2(50),
    PRIMARY KEY(NAME, PRODUCT) -- 컬럼을 묶어서 PRIMARY KEY 하나로 설정 == 복합키, 복합기본키
);
INSERT INTO PRODUCT VALUES('이승철', '민트치약');
INSERT INTO PRODUCT VALUES('이승철', '민트치약');
INSERT INTO PRODUCT VALUES('이승철', '딸기치약');
INSERT INTO PRODUCT VALUES('홍길동', '민트치약');
SELECT
       *
  FROM
       PRODUCT
 WHERE
       NAME = '이승철';
SELECT * FROM PRODUCT;
-- 행들의 정보를 식별
-- 무결성
-- 테이블간 관계
-- ORACLE은 RDBMS에 포함됨. R은 RELATIONSHIP 

--------------------------------------------------------------------------------
-- 회원 등급에 대한 데이터(등급 코드, 등급명) 보관하는 테이블
CREATE TABLE USER_GRADE( -- 참조 당하는 테이블 '부모테이블'
    GRADE_CODE CHAR(2) PRIMARY KEY,
    GRADE_NAME VARCHAR(20) NOT NULL
);

INSERT INTO USER_GRADE VALUES('G1', '일반회원');
INSERT INTO USER_GRADE VALUES('G2', '우수회원');
INSERT INTO USER_GRADE VALUES('G3', '최우수회원');

SELECT  
       GRADE_CODE,
       GRADE_NAME
  FROM
       USER_GRADE;

/*
    5. FOREIGN KEY(외래키) 제약조건
    
    다른 테이블에 존재하는 값만 컬럼에 INSERT 하고 싶을 때 부여하는 제약조건
    => 다른 테이블(부모테이블)을 참조한다고 표현
    참조하고 있는 테이블에 존재하는 값만 INSERT할 수 있음
    => FOREIGN KEY 제약조건을 이용해서 다른 테이블간의 관계를 형성할 수 있음
    
    [ 표현법 ]
    - 컬럼 레벨 방식
    컬럼명 자료형 REFERENCES 참조할테이블명(참조할컬럼명)
    - 테이블 레벨 방식
    FOREIGN KEY(컬럼명) REFERENCES 참조할테이블명(참조할컬럼명)
    
    두 가지 방식 모두 참조할 컬럼명은 생략 가능.
    생략할 경우 자동으로 참조할 테이블의 PRIMARY KEY컬럼이 참조할 컬럼명으로 설정됨.
    PK없으면??
*/

CREATE TABLE TB_USER_CHILD( -- 참조 '하는' 테이블을 자식테이블
    USER_NO NUMBER PRIMARY KEY, -- 제약조건 여러개면 PK 제일 앞에 쓴다.
    USER_ID VARCHAR2(15) NOT NULL UNIQUE,
    USER_PWD VARCHAR2(20) NOT NULL,
    GRADE_ID CHAR(2) REFERENCES USER_GRADE -- 컬럼레벨방식
--    FOREIGN KEY(GRADE_ID) REFERENCES USER_GRADE 테이블레벨방식
);
DROP TABLE TB_USER_CHILD;
INSERT INTO TB_USER_CHILD
VALUES (1, 'admin', '1234', 'G1');

INSERT INTO TB_USER_CHILD
VALUES (2, 'user01', '3456', 'G2');

INSERT INTO TB_USER_CHILD
VALUES (3, 'user02', '4444', 'G2');

INSERT INTO TB_USER_CHILD
VALUES (4, 'user03', '3333', NULL); -- 마찬가지로 FK 제약조건에도 NULL 들어감. 

SELECT * FROM TB_USER_CHILD;

INSERT
  INTO
       TB_USER_CHILD
VALUES
       (
       5,
       'user04',
       '1111',
       'g4'
       );
-- integrity constraint : 데이터 무결성 제약조건. / parent key not found

-- 회원번호, 회원아이디, 등급명을 조회해주세요~
SELECT
       USER_NO,
       USER_ID,
       GRADE_NAME
  FROM
       USER_GRADE
 RIGHT
  JOIN
       TB_USER_CHILD ON (GRADE_CODE = GRADE_ID);

-- 부모테이블(USER_GRADE)에서 데이터를 삭제
-- 구조삭제는 DROP ; DROP TABLE -- / DROP USER -- 

-- 데이터를 지우고 싶을 때는 DELETE
-- USER_GRADE 테이블에서 GRADE_CODE가 G1인 행을 삭제
DELETE 
  FROM
       USER_GRADE -- 여기까지만 적으면 테이블에 있는 것 전부 삭제. 지금 자식이 있어서 지울수 없다고 나옴
 WHERE
       GRADE_CODE = 'G1'; -- 여기도 무결성오류. CHILD 있어서
       -- 데이터베이스 보안 삼총사 CIA - Confidentiality(기밀성) Integrity(무결성) Availavility(가용성)
-- child record found
-- 자식테이블에서 데이터를 사용하고 있는 컬럼이 존재하기 때문에 삭제할 수 없음.

-- 자식테이블에서 부모테이블에 존재하는 값을 사용하고 있을 경우 삭제가 불가능한 '삭제제한옵션'이 걸려있음.
-- 테이블 생성 시 삭제 제한 옵션을 변경할 수 있음

DELETE
  FROM
       USER_GRADE
 WHERE
       GRADE_CODE = 'G3';
-- 자식테이블에서 사용하고 있지 않은 데이터는 삭제 잘 됨

SELECT * FROM USER_GRADE;

ROLLBACK;
--------------------------------------------------------------------------------

/*
    * 자식테이블 생성 시 외래키 제약조건을 부여할 경우
    부모테이블의 데이터가 삭제되었을 때 자식테이블에서는 어떻게 처리할 것인지 옵션을 지정할 수 있음
    
    삭제옵션을 따로 지정하지 않는다면 기본설정은 ON DELETE RESTRICTIED(삭제 제한)이 설정됨.
*/

-- 1) ON DELETE SET NULL --  부모 데이터 삭제시 해당 데이터를 사용하고 있는 자식 레코드를 NULL값으로 변경시키는 옵션
CREATE TABLE TB_USER_ODSN(
    USER_NO NUMBER PRIMARY KEY,
    GRADE_ID CHAR(2),
    FOREIGN KEY(GRADE_ID) REFERENCES USER_GRADE ON DELETE SET NULL
);
INSERT INTO TB_USER_ODSN VALUES(1, 'G1');
INSERT INTO TB_USER_ODSN VALUES(2, 'G2');
INSERT INTO TB_USER_ODSN VALUES(3, 'G1');

SELECT * FROM TB_USER_ODSN;
-- 부모테이블 (USER_GRADE)의 GRADE_CODE가 G1인 행을 삭제
DELETE
  FROM
       USER_GRADE
 WHERE
       GRADE_CODE = 'G1';
-- 자식테이블(TB_USER_ODSN)의 GRADE_ID컬럼의 값이 G1이던 친구들이 모두 NULL로 바뀜

ROLLBACK;

-- 2) ON DELETE CASCADE : 부모데이터 삭제 시 해당 데이터를 사용하고 있는 자식데이터도 같이 삭제
CREATE TABLE TB_USER_ODC(
    USER_NO NUMBER PRIMARY KEY,
    GRADE_ID CHAR(2),
    FOREIGN KEY(GRADE_ID) REFERENCES USER_GRADE ON DELETE CASCADE
);

INSERT INTO TB_USER_ODC VALUES(1, 'G1');
INSERT INTO TB_USER_ODC VALUES(2, 'G2');
INSERT INTO TB_USER_ODC VALUES(3, 'G3');
INSERT INTO TB_USER_ODC VALUES(4, NULL);

SELECT * FROM TB_USER_ODC;

DELETE FROM USER_GRADE WHERE GRADE_CODE = 'G1';
-- 삭제 성공
-- 자식테이블(TB_USER_ODC)의 GRADE_ID컬럼의 값이 G1인 행들이 모두 삭제!
/*
    꼭 외래키 제약조건이 걸려있어야만 JOIN을 할 수 있는 것은 아님
*/
--------------------------------------------------------------------------------
/*
    -- 여기서부터는 쿼리문 수행을 KH 계정으로 -- 
    * SUBQUERY를 이용한 테이블 생성(복사 개념)
    
    [표현법]
    CREATE TABLE 테이블명
        AS 서브쿼리;
        
    서브쿼리를 수행한 결과로 새롭게 테이블을 생성해줌
*/

SELECT * FROM EMPLOYEE;
CREATE TABLE EMPLOYEE_COPY 
    AS SELECT * FROM EMPLOYEE;

SELECT * FROM EMPLOYEE_COPY;
-- 컬럼들, 조회결과의 데이터값들, 단 제약조건은 NOT NULL만 복사됨.

SELECT * FROM EMPLOYEE WHERE 0 = 1;

CREATE TABLE EMPLOYEE_COPY2 AS
SELECT
       *
  FROM
       EMPLOYEE
 WHERE
       0 = 1;

SELECT * FROM EMPLOYEE_COPY2;

CREATE TABLE EMPLOYEE_COPY3 
    AS
SELECT 
       EMP_ID,
       EMP_NAME,
       SALARY * 12 AS "연봉"
  FROM
       EMPLOYEE;

SELECT * FROM EMPLOYEE_COPY3;
--------------------------------------------------------------------------------
/*
    * 테이블이 생성된 후 제약조건을 추가 -> 구조변경 ->  (ALTER TABLE 테이블명 XXXX)
    - XXXX부분에 아래 추가
    - PRIMARY KEY : ADD PRIMARY KEY(컬럼명);
    - FOREIGN KEY : ADD FOREIGN KEY(컬럼명) REFERENCES 테이블명;
    - UNIQUE : ADD UNIQUE(컬럼명);
    - CHECK : ADD CHECK(컬럼명);
    - NOT NULL : MODIFY 컬럼명 NOT NULL;
*/

-- EMPLOYEE_COPY 테이블에 존재하지 않은 PRIMARY KEY 제약조건 추가 -> EMP_ID 컬럼에
ALTER TABLE EMPLOYEE_COPY ADD PRIMARY KEY(EMP_ID);

-- EMPLOYEE_COPY 테이블에 DEPT_CODE컬럼에 외래키 제약조건 추가(DEPARTMENT 테이블의 DEPT_ID 참조하도록)
ALTER TABLE EMPLOYEE_COPY ADD FOREIGN KEY(DEPT_CODE) REFERENCES DEPARTMENT(DEPT_ID);





















