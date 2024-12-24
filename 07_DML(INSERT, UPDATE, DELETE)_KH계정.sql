/*
    < DML : DATA MANIPULATION LANGUAGE >
            데이터 조작 언어
    INSERT / UPDATE / DELETE
    
    테이블에 새로운 데이터를 삽입(INSERT)하거나,
    테이블에 존재하는 데이터를 수정(UPDATE)하거나,
    테이블에 존재하는 데이터를 삭제(DELETE)하는 구문
*/
/*
    1. INSERT : 테이블에 새로운 행을 추가해주는 구문
    
    [ 표현법 ]
    1) INSERT INTO 테이블명 VALUES (값, 값, 값, 값,...);
    => 해당 테이블에 모든 컬럼에 추가하고자 하는 값을 직접 입력해서 한 행을 INSERT하고자 할 때 사용
    * 주의할점 : 값의 순서를 컬럼의 순서와 동일하게 작성해야 함 ***(테이블 만들 때 나열한 그 순서)
*/

SELECT * FROM EMPLOYEE;

INSERT
  INTO
       EMPLOYEE
VALUES
       (
       900,
       '신입사원',
       '990909-0909090',
       'newfourone@kh.or.kr',
       '01041414141',
       'D1',
       'J3',
       'S2',
       5000000,
       0.2,
       201,
       SYSDATE,
       NULL,
       DEFAULT
       ); -- 컬럼 개수만큼 안 넣어주면 not enough values라고 함 더 넣으면 too many values
       
SELECT
       *
  FROM
       EMPLOYEE;
       
/*
    2) INSERT INTO 테이블명(컬럼명, 컬럼명, 컬럼명...) VALUES( 값, 값, 값); 
    내가 INSERT하고 싶은 컬럼명들 제시.
    => 해당 테이블에 특정 컬럼만 선택해서 그 컬럼에 값을 추가할 때 사용
    INSERT는 무조건 한 행 단위로 추가가 되기 때문에 테이블 명 뒤에 작성하지 않은 컬럼은 기본적으로 NULL값이 들어감
    
    주의할 점 ) NOT NULL 제약조건이 달려있는 컬럼은 반드시 테이블명 뒤에 컬럼명을 적어서 값을 INSERT해주어야함.
    예외 사항 : NOT NULL 제약조건이 걸려있지만 DEFAULT(기본값)이 지정되어 있는 경우 따로 값을 넣지 않으면 DEFAULT값이 들어감.
*/

INSERT
  INTO
       EMPLOYEE
       (
       EMP_ID,
       EMP_NAME,
       EMP_NO,
       JOB_CODE,
       SAL_LEVEL
       )
VALUES
       (
       901,
       '새신입사원',
       '440404-0404044',
       'J5',
       'S1'
       );
       
SELECT * FROM EMPLOYEE;
--------------------------------------------------------------------------------
/*
    3. INSERT INTO 테이블명 (서브쿼리);
    => VALUES(값) 을 기입하는 것 대신에 서브쿼리로 조회한 결과값을 통째로 INSERT하는 구문
*/

-- 새로운 테이블 하나 만들기
CREATE TABLE EMP_01(
    EMP_NAME VARCHAR2(20), 
    DEPT_TITLE VARCHAR2(20)
);

SELECT * FROM EMP_01;

-- EMPLOYEE테이블에 존재하는 모든 사원의 사원명, 부서명을 INSERT
INSERT
  INTO
       EMP_01
       ( -- 서브쿼리 시작
       SELECT
              EMP_NAME,
              DEPT_TITLE
         FROM
              EMPLOYEE,
              DEPARTMENT
        WHERE
               DEPT_CODE = DEPT_ID(+)
        ); -- 25개 행 이(가) 삽입되었습니다. INSERT에 성공한 행의 개수
        
SELECT * FROM EMP_01;

--------------------------------------------------------------------------------
/*
    2. INSERT ALL
    하나의 테이블에 여러개의 행을 다중 INSERT하거나, ***
    두 개 이상의 테이블에 각각 INSERT를 수행해야 할 때 사용하는 구문
*/

-- 새로운 테이블 만들기
-- 첫 번째 테이블 : 급여가 400만원 이상인 사원들의 사원명, 직급명에 대해서 보관할 테이블
CREATE TABLE EMP_JOB(
    EMP_NAME VARCHAR2(30),
    JOB_NAME VARCHAR2(20)
);
-- 두 번째 테이블, 급여가 400만원 이상인 사원들의 사원명, 부서명에 대해서 보관할 테이블
CREATE TABLE EMP_DEPT(
    EMP_NAME VARCHAR(30),
    DEPT_TITLE VARCHAR2(20)
);

SELECT * FROM EMP_JOB;
SELECT * FROM EMP_DEPT;

-- EMP_JOB테이블에는 EMPLOYEE테이블에서 급여가 400만원 이상인 사원들의 사원명, 직급명 INSERT
-- EMP_DEPT테이블에는 EMPLOYEE테이블에서 급여가 400만원 이상인 사원들의 사원명, 부서명 INSERT

/*
    2_1) INSERT ALL
            INTO 테이블명1 VALUES(컬럼명, 컬럼명,..)
            INTO 테이블명2 VALUES(컬럼명, 컬럼명,..)
            서브쿼리;
*/

INSERT ALL
  INTO EMP_JOB VALUES(EMP_NAME, JOB_NAME)
  INTO EMP_DEPT VALUES(EMP_NAME, DEPT_TITLE)
SELECT 
       EMP_NAME,
       JOB_NAME,
       DEPT_TITLE
  FROM
       EMPLOYEE
  JOIN
       JOB USING (JOB_CODE)
  JOIN
       DEPARTMENT ON (DEPT_CODE = DEPT_ID)
 WHERE
       SALARY >= 4000000; -- 10개 행 이(가) 삽입되었습니다.
       
SELECT * FROM EMP_JOB; -- 5개 행
SELECT * FROM EMP_DEPT; -- 5개 행

-- 사원명, 입사일 => 2010년도 이전에 입사한 사원
CREATE TABLE EMP_OLD
    AS SELECT EMP_NAME, HIRE_DATE
         FROM EMPLOYEE
        WHERE 0 = 1;

-- 사원명, 입사일 => 2010년도 이후에 입사한 사원
CREATE TABLE EMP_NEW
    AS SELECT EMP_NAME, HIRE_DATE
         FROM EMPLOYEE
        WHERE 0 = 1;
        
SELECT EMP_NAME, HIRE_DATE
  FROM EMPLOYEE 
 WHERE --HIRE_DATE < '2010/01/01'; -- 2010년 이전 입사자 9명
       HIRE_DATE >= '2010/01/01'; -- 2010년 이후 입사자 15명
       
/*
    2_1_2) INSERT ALL
           WHEN 조건1 THEN
           INTO 테이블명1 VALUES(컬럼명, 컬럼명)
           WHEN 조건2 THEN
           INTO 테이블명2 VALUES(컬럼명, 컬럼명)
           서브쿼리
*/

INSERT ALL
  WHEN HIRE_DATE < '2010/01/01' THEN
  INTO EMP_OLD VALUES(EMP_NAME, HIRE_DATE)
  WHEN HIRE_DATE >= '2010/01/01' THEN
  INTO EMP_NEW VALUES(EMP_NAME, HIRE_DATE)
SELECT
       EMP_NAME, HIRE_DATE
  FROM
       EMPLOYEE;

SELECT * FROM EMP_OLD;
SELECT * FROM EMP_NEW;
/*
    2_2) **
        INSERT ALL
          INTO 테이블명 VALUES (값, 값, 값..)
          INTO 테이블명 VALUES (값, 값, 값,,)
          ...
        SELECT *
          FROM DUAL;
*/

INSERT
   ALL
  INTO EMP_OLD VALUES('하하', SYSDATE)
  INTO EMP_OLD VALUES('호호', SYSDATE)
  INTO EMP_OLD VALUES('히히', SYSDATE)
SELECT
       *
  FROM
       DUAL;
--------------------------------------------------------------------------------
/*
    3. UPDATE
    테이블에 기록된 기존의 데이터를 수정하는 구문
    
    [ 표현법 ]
    UPDATE 
           테이블명
       SET
           컬럼명 = 바꿀값,
           컬럼명 = 바꿀값,
           ...      => 여러 개의 컬럼 값을 동시에 바꿀 수 있음. ','로 나열해야 함!!! AND 아님!!!! AND 아님 !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
     WHERE
           조건식; => WHERE은 생략가능
           
*/

-- 테이블 하나 복사
CREATE TABLE DEPT_COPY
    AS SELECT * FROM DEPARTMENT;
    
SELECT * FROM DEPT_COPY;

-- DEPT_COPY 테이블에서 해외영업3부 부서명을 미래사업부로 변경
UPDATE
       DEPT_COPY
   SET
       DEPT_TITLE = '미래사업부'; -- 여기까지만 하고 하면 9개 행 이(가) 업데이트되었습니다.
-- 전체 행의 모든 DEPT_TITLE컬럼의 값이 전부 미래사업부 UPDATE

ROLLBACK;

UPDATE
       DEPT_COPY
   SET
       DEPT_TITLE = '미래사업부'
 WHERE
       DEPT_TITLE = '해외영업3부'; -- 1 행 이(가) 업데이트되었습니다.
    
SELECT * FROM DEPT_COPY;

--------------------------------------------------------------------------------
-- 테이블 복사
CREATE TABLE EMP_SALARY
    AS SELECT EMP_NAME, SALARY, BONUS
         FROM EMPLOYEE;
         
-- EMP_SALARY 테이블에서 신입사원사원의 급여를 400만원으로 변경
UPDATE
       EMP_SALARY
   SET
       SALARY = 4000000
 WHERE
       EMP_NAME = '신입사원';
       
SELECT * FROM EMP_SALARY;

-- 전체 사원의 급여를 기존 급여에서 10%인상하도록 갱신
UPDATE
       EMP_SALARY
   SET
       SALARY = SALARY * 1.1; -- 25개 행 이(가) 업데이트되었습니다. -- 이 알림은 누가 ??
       
-- 개발자 - > 컴퓨터 다루는 사람 / 컴퓨터 -> 연산장치 + 저장장치 / Java, SQL -> 개발자가 컴퓨터를 다루기 위해 쓰는 도구
-- 내가 작업하는 컴퓨터 -> H/W에 연산장치(CPU), 저장장치(RAM(휘발성 메모리, Java작업시 RAM메모리에 데이터 올려놓고 사용하는 것,), SSD/HDD)
-- DBMS를 설치한 컴퓨터 = DB Server. 
-- Oracle 서버가 켜져서 구동되고 있음. 프로세스 상태로
-- 오라클 DBMS를 사용하니까 오라클사에서 만든 오라클 developer로 작업
-- 내 피시를 DBserver로 만들고, 클라이언트프로그램에 해당하는 SQLDeveloper를 이용해서 내 컴퓨터에 돌고있는 프로세스에 요청을 보내는 것. DBserver가 요청 처리해주고 나서 결과를 반환해주고 있음.
-- SQL은 SSD/ HDD에 데이터를 올려놓고 처리해주고 있음

--------------------------------------------------------------------------------

/*
    * UPDATE 사용시 서브쿼리를 사용
    
    UPDATE
           테이블명
       SET
           컬럼명 = (서브쿼리)
     WHERE
           조건; => 생략가능
*/
       
SELECT * FROM EMP_SALARY;

-- 새신입사원의 급여를 신입사원의 급여만큼 보너스를 김인턴사원의 보너스만큼으로 갱신

UPDATE 
       EMP_SALARY
   SET
       SALARY = (SELECT
                        SALARY
                   FROM 
                        EMP_SALARY
                  WHERE
                        EMP_NAME = '신입사원'), -- 컬럼끼리 구분 ,로 하는 것 주의
       BONUS =  (SELECT
                         BONUS
                    FROM
                         EMP_SALARY
                   WHERE
                         EMP_NAME = '김인턴')
 WHERE
       EMP_NAME = '새신입사원';
--------------------------------------------------------------------------------
-- UPDATE시에도 바꾸고 싶은 값이 해당 컬럼에 제약조건에 위배되면 안됨!!
-- 리현빈 사원의 사번을 200번으로 변경
UPDATE
       EMPLOYEE
   SET
       EMP_ID = 200
 WHERE
       EMP_NAME = '리현빈'; -- unique constraint// PRIMARY KEY 제약조건 위배

UPDATE
       EMPLOYEE
   SET
       EMP_ID = NULL
 WHERE
       EMP_ID = 200; -- PRIMARY KEY 제약조건 위배
       
COMMIT; -- 모든 변경사항들을 확정짓는 명령어
--------------------------------------------------------------------------------

/*
    4. DELETE
    테이블에 기록된 **행**을 삭제하는 구문
    
    [표현법]
    DELETE
      FROM
           테이블명
     WHERE
           조건; =>생략가능
*/

DELETE FROM EMPLOYEE; -- 25개 행 이(가) 삭제되었습니다.
SELECT * FROM EMPLOYEE; -- 모든 행 삭제됨
ROLLBACK; -- 롤백 시 마지막 커밋시점으로 돌아감.

DELETE
  FROM
       EMPLOYEE
 WHERE
       --EMP_NAME = '신입사원' OR EMP_NAME = '새신입사원'
       --EMP_NAME IN ('신입사원', '새신입사원')
       EMP_NAME LIKE '%사원';
       
COMMIT; -- 이거 하고 ROLLBACK 하면 여기로 옴. 줄의 순서가 중요한게 아니고 실행했던 순서가 중요.

--------------------------------------------------------------------------------

/*
    * TRUNCATE : 테이블의 전체 행을 삭제할 때 사용하는 구문(절삭)
                (이론적으로는) DELETE보다 수행속도가 빠름
                별도의 조건부여 불가. ROLLBACK도 불가!!!
                
*/

SELECT * FROM EMP_SALARY;
DELETE FROM EMP_SALARY; -- 0.034
ROLLBACK;
TRUNCATE TABLE EMP_SALARY; -- 0.044 롤백으로도 돌아오지 않음
