/*
    < DDL : DATA DEFINITION LANGUQGE >
    
    객체들을 새롭게 생성(CREATE)하고 수정(ALTER)하고 삭제(DROP)하는 구문
    
    DQL : SELECT                 => 질의
    DML : INSERT/ UPDATE/ DELETE => 데이터 조작
    DDL : CREATE/ ALTER/ DROP    => 구조 정의
    
    1. ALTER
    객체 구조를 수정하는 구문
    
    < 테이블 수정 >
    ALTER TABLE 테이블명 수정할내용;
    - 수정할 내용
    1) 컬럼 추가 / 컬럼 수정 / 컬럼 삭제
    2) 제약조건 추가 / 삭제 => 수정은XXX(삭제 후 다시 추가하는 방법으로 수정해야함)
    3) 테이블명 / 컬럼명/ 제약조건명
*/

-- 1) 컬럼 추가 / 수정 / 삭제
SELECT * FROM DEPT_COPY;

-- 1_1) 컬럼추가 (ADD) : ADD 추가할컬럼명 자료형 DEFAULT 기본값(DEFAULT는 생략 가능)

--- BOSS 컬럼 추가
ALTER TABLE DEPT_COPY ADD BOSS VARCHAR2(20);
-- 새로운 컬럼 추가 시 기본적으로 NULL값이 채워짐

-- LOCATION_NAME 컬럼 추가 DEFAULT 값 지정해서
ALTER TABLE DEPT_COPY ADD LOCATION_NAME VARCHAR2(20) DEFAULT '한국';
-- NULL값이 아닌 DEFAULT값으로 채워짐

-- 1_2) 컬럼수정 (MODIFY)
-- 데이터 타입 수정 : ALTER TABLE 테이블명 MODIFY 수정할컬럼명 바꾸고자하는데이터타입;
-- DEFAULT 값 수정 : ALTER TABLE 테이블명 MODIFY 수정할컬럼명 DEFAULT 바꾸고자하는기본값;

SELECT * FROM DEPT_COPY;

-- DEPT_ID 컬럼 데이터타입을 CHAR(3)로 변경
ALTER TABLE DEPT_COPY MODIFY DEPT_ID CHAR(3);
ALTER TABLE DEPT_COPY MODIFY DEPT_ID CHAR(1); -- cannot decrease column length because some value is too big
ALTER TABLE DEPT_COPY MODIFY DEPT_ID NUMBER; -- column to be modified must be empty to change datatype/ 값이 이미 있는데 순수 숫자가 아님. 값을 비우고 바꾸던가 하라는 것
ALTER TABLE DEPT_COPY MODIFY DEPT_TITLE VARCHAR2(10); -- cannot decrease column length because some value is too big
-- 현재 변경하고자 하는 컬럼에 이미 담겨있는 값과 완전히 다른 타입 / 또는 작은 크기로는 변경이 불가능하다.
-- 예로 문자->숫자 X / 사이즈 축소X/ 크기 확대는 O // 다들 데이터가 비어있으면 상관 없는데.

-- DEPT_TITLE 컬럼 데이터타입을 VARCHAR2(40)
-- LOCATION_ID 컬럼 데이터타입을 VARCHAR2(3)
-- LOCATION_NAME 컬럼 기본값을 '미국'

ALTER TABLE DEPT_COPY
MODIFY DEPT_TITLE VARCHAR2(40)
MODIFY LOCATION_ID VARCHAR2(3)
MODIFY LOCATION_NAME DEFAULT '미국'; -- MODIFY를 한 번에 사용할 수 있다.

CREATE TABLE DEPT_COPY2 AS
SELECT * FROM DEPT_COPY;

-- 1_3) 컬럼삭제 (DROP COLUMN) : DROP COLUMN 삭제하고픈 컬럼명
SELECT * FROM DEPT_COPY2;

ALTER TABLE DEPT_COPY2 DROP COLUMN DEPT_TITLE; -- 마지막 컬럼은 삭제할 수 없다.
-- 삭제할 때도 그렇고, 생성할 때도 최소 1개의 컬럼은 있어야 한다.

/*
CREATE TABLE ABC(

);
*/
--------------------------------------------------------------------------------
-- 2) 제약조건 추가/ 삭제 (수정은 불가)
/*
    2_1) 제약조건 추가
    
    나만의 제약조건명을 만들어서 ADD [CONSTRAINT 제약조건명] 제약조건
    주의 사항 : 제약조건은 TABLE에 붙는 것이 아니라 계정에 붙는 것이다. 그래서 그 계정이 가지고 있는 제약조건명과 충돌하는 제약조건은 만들 수 없다.
    현재 계정이 가지고 있는 기존의 제약조건명과 충돌하면 안됨!
*/

ALTER TABLE DEPT_COPY
--  ADD CONSTRAINT DCOPY_UQ UNIQUE(DEPT_TITLE)
MODIFY LOCATION_NAME CONSTRAINT DCOPY_NN NOT NULL; -- NOT NULL은 컬럼에 붙는 거라서 MODIFY

/*
    2_2) 제약조건 삭제
    PRIMARY KEY, FOREIGN KEY, UNIQUE, CHECK : DROP CONSTRAINT 제약조건명
    NOT NULL : MODIFY 컬럼명 NULL
*/

ALTER TABLE DEPT_COPY DROP CONSTRAINT DCOPY_UQ; -- 컬럼지우는게 아니고 제약조건 지우는거니까 제약조건명으로 DROP해야한다.
--------------------------------------------------------------------------------
-- 3) 컬럼명 / 제약조건명 / 테이블명 변경(RENAME)

-- 3_1) 컬럼명 변경 : ALTER TABLE 테이블명 RENAME COLUMN 기존컬럼명 TO 바꿀컬럼명;
ALTER TABLE DEPT_COPY RENAME COLUMN LOCATION_NAME TO LNAME;

-- 3_2) 제약조건명 변경 : ALTER TABLE 테이블명 RENAME CONSTRAINT 기존제약조건명 TO 바꿀제약조건명;
ALTER TABLE DEPT_COPY RENAME CONSTRAINT DCOPY_NN TO DCOPY_NOT_NULL;

-- 3_3) 테이블명 변경 : ALTER TABLE 테이블명 RENAME 기존테이블명 TO 바꿀테이블명;
ALTER TABLE DEPT_COPY RENAME TO DEPT_TEST; -- ALTER TABLE 테이블명 하면서 기존테이블명을 적으므로, 뒤에 생략하고 기재해도 됨. 일반적으로 이렇게 적음.
SELECT * FROM DEPT_TEST;

ALTER TABLE DEPT_TEST ADD PRIMARY KEY(DEPT_ID);

CREATE TABLE DEPT_CHILD(
    DEPT_ID CHAR(3) REFERENCES DEPT_TEST(DEPT_ID)
);

INSERT INTO DEPT_CHILD VALUES('D1');
COMMIT;
--------------------------------------------------------------------------------

/*
    2. DROP
    객체를 삭제하는 구문
*/
SELECT * FROM DEPT_TEST; -- 부모테이블
SELECT * FROM DEPT_CHILD; -- 자식테이블

DROP TABLE DEPT_TEST;
-- 데이터가 자식테이블에서 참조되고 있음!! DROP할 수 없음
-- 1. 자식테이블을 먼저 삭제한 뒤 부모테이블을 삭제

DROP TABLE 부모테이블 CASCADE CONSTRAINTS; -- CASCADE를 붙이면 자식에서 참조해도 무시하고 부모를 지울 수 있다. CONSTAINTS는 제약조건까지

-- DROP USER 유저명 -- 접속한 계정은 삭제 안 된다/  삭제도 관리자계정에서 해야한다/
