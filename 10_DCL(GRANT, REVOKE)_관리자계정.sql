/*
    < DCL  : DATA CONTROL LANGUAGE >
            데이터 제어 언어
            
    계정에게 시스템권한 또는 객체 접근 권한을 부여(GRANT)하거나 회수(REVOKE)하는 언어
    
    * 권한 부여(GRANT)
    - 시스템 권한 : 특정 DB에 접근하는 권한, 객체들을 생성할 수 있는 권한
    - 객체 (접근) 권한 : 특정 객체들에 접근해서 조작할 수 있는 권한
    
    * 시스템 권한의 종류
    - CREATE SESSION : 계정이 접속할 수 있는 권한
    - CREATE TABLE : 테이블을 생성할 수 있는 권한
    - CREATE VIEW : 뷰를 생성할 수 있는 권한
    - CREATE SEQUENCE : 시퀀스를 생성할 수 있는 권한
    ...
    
    [ 표현법 ]
    GRANT 권한1, 권한2, ... TO 계정명;

*/
-- 1. SAMPLE 계정 생성
CREATE USER SAMPLE IDENTIFIED BY SAMPLE; -- 계정명은 대소문자로 입력해도 항상 대문자/ 비밀번호는 대소문자를 구분하므로 주의할 필요가 있다.

--2. SAMPLE계정에 접속할 수 있도록 CREATE SESSION 권한 부여
GRANT CREATE SESSION TO SAMPLE; -- CREATE SESSION 권한을 SAMPLE계정에 부여

-- 3_1_2. SAMPLE계정에서 테이블을 생성할 수 있도록 CREATE TABLE 권한 부여
GRANT CREATE TABLE TO SAMPLE;

-- 3_2. SAMPLE계정이 테이블을 생성할 수 있도록 TABLE SPACE를 할당해주기. (SYSTEM 계정)
ALTER USER SAMPLE QUOTA 2M ON SYSTEM; -- 2MB 정도의 공간을 할당해줌

-- 4_2. SAMPLE계정이 뷰를 생성할 수 있도록 CREATE VIEW권한 부여
GRANT CREATE VIEW TO SAMPLE;
--------------------------------------------------------------------------------
/*
    * 객체 권한 
    
    특정 객체들을 조작(SELECT, INSERT, UPDATE, DELETE)할 수 있는 권한
    
    [ 표현법 ]
    GRANT 권한종류 ON 특정객체 TO 계정명; 
*/

-- 5. SAMPLE 계정에 KH계정 소유의 EMPLOYEE테이블을 조회할 수 있는 권한 부여
GRANT SELECT ON KH.EMPLOYEE TO SAMPLE;

-- 6_2. SAMPLE계정이 KH.DEPARTMENT 테이블에 데이터를 추가할 수 있는 권한 부여
GRANT INSERT ON KH.DEPARTMENT TO SAMPLE;
--------------------------------------------------------------------------------
-- GRANT로 권한 부여
-- GRANT CONNECT, RESOURCE TO 계정명; -- role이라고 부르는 애들

SELECT *
  FROM ROLE_SYS_PRIVS
 WHERE
       ROLE IN ('CONNECT', 'RESOURCE');
       
/*
    < 롤 ROLE >
    특정 권한들을 하나의 집합으로 모아놓은 것
    
    CONNECT : CREATE SESSION(DB에 접속할 수 있는 권한)
    RESOURCE : CREATE TABLE, CREATE SEQUENCE ... (특정 객체들을 생성 및 관리할 수 있는 권한)
*/
--------------------------------------------------------------------------------

/*
    * 권한 회수(REVOKE)
    
    [ 표현법 ]
    REVOKE 권한1, 권한2... FROM 사용자이름;
*/

-- 7. SAMPLE계정이 부여받은 테이블 생성 권한 회수
REVOKE CREATE TABLE FROM SAMPLE;
















