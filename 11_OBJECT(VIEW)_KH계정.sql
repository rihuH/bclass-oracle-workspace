---------------------- 실습 시간 ----------------------------------

-- '한국'에서 근무하는 사원들의 사번, 이름, 부서명, 직급명, 근무국가명을 조회하세요!

SELECT
       EMP_ID,
       EMP_NAME,
       DEPT_TITLE,
       JOB_NAME,
       NATIONAL_NAME
  FROM
       EMPLOYEE
  JOIN
       DEPARTMENT ON (DEPT_CODE = DEPT_ID)
  JOIN
       JOB USING (JOB_CODE)
  JOIN
       LOCATION ON (LOCATION_ID = LOCAL_CODE)
  JOIN
       NATIONAL USING (NATIONAL_CODE)
 WHERE
       NATIONAL_NAME = '한국';
       
--------------------------------------------------------------------------------

/*
    < VIEW 뷰 >
    
    SELECT(쿼리문)을 저장해둘 수 있는 객체
    임시테이블같은 존재 (실제 데이터가 담겨있는 것은 아님!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!)
*/

/*
    1. VIEW 생성 방법
    
    [ 표현법 ] 
    CREATE VIEW 뷰명 
        AS 서브쿼리;
*/

CREATE OR REPLACE VIEW VW_EMPLOYEE -- VIEW라는 의미로 VW를 붙여줌
    AS SELECT
              EMP_ID,
              EMP_NAME,
              DEPT_TITLE,
              JOB_NAME,
              NATIONAL_NAME
         FROM
              EMPLOYEE
         JOIN
              DEPARTMENT ON (DEPT_CODE = DEPT_ID)
         JOIN
              JOB USING (JOB_CODE)
         JOIN
              LOCATION ON (LOCATION_ID = LOCAL_CODE)
         JOIN
              NATIONAL USING (NATIONAL_CODE);
-- 현재 KH 계정에 CREATE VIEW 권한이 없음
-- 관리자계정에서 권한 부여
GRANT CREATE VIEW TO KH;

-- 다시 KH
-- 위의 VIEW 생성을 할 수 있음. 만든 VIEW로 SELECT를 할 수 있다.
SELECT * FROM VW_EMPLOYEE;

-- 한국에서 근무하는 사원
SELECT
       *
  FROM
       VW_EMPLOYEE
 WHERE
       NATIONAL_NAME = '한국';
       
-- 일본에서 근무하는 사원
SELECT
       *
  FROM
       VW_EMPLOYEE
 WHERE
       NATIONAL_NAME = '일본';
       
-- 뷰의 장점 : 긴 쿼리문을 필요할때마다 그때그때 작성하면 힘듦.
--             자주 쓰는 쿼리문을 한 번 뷰로 만들어두면 그때부터 뷰를 이용해서 간단하게 조회할 수 있음 - 뷰 사용 목적.
-- 뷰는 계정 소유

-- 해당 계정이 가지고 있는 VIEW들에 대한 정보를 조회할 수 있는 데이터 딕셔너리
SELECT * FROM USER_VIEWS;
-- 뷰는 데이터를 저장하고 있는게 아니고, 결과를 얻어내기 위한 쿼리문을 텍스트 형태로 가지고 있는 것.
-- 그리고 그걸 실행한 결과를 반환해주는 것
-- 뷰는 논리적인 가상의 테이블 => 실질적으로 데이터를 저장하고 있지 않음(쿼리문을 TEXT형태로 저장해놓음)
--------------------------------------------------------------------------------
/*
    CREATE OR REPLACE VIEW 뷰명
        AS 서브쿼리;
        
    뷰 생성 시 기존에 중복된 이름의 뷰가 존재하지 않는다면 새로운 뷰를 생성해주고,
    기존에 동일한 이름의 뷰가 존재한다면 갱신(변경)하는 옵션

*/

/*
    * 뷰 생성 시 컬럼에 별칭 부여
    서브쿼리의 SELECT절에 함수 또는 산술연산식이 기술되어 있는 경우 반드시 별칭 지정
*/

-- 사원의 사원명, 연봉, 근무년수를 조회할 수 있는 SELECT문을 뷰로 정의

CREATE OR REPLACE VIEW VW_EMP(사원명, 연봉, 근무년수)
    AS
SELECT
       EMP_NAME,
       SALARY * 12 AS "연봉",
       EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM HIRE_DATE) AS "근무년수"
  FROM
       EMPLOYEE;
-- must name this expression with a column alias
-- 컬럼의 별칭을 지정하지 않아서 오류 발생
-- 별칭을 지어주면 생성가능

SELECT * FROM VW_EMP;

-- 별칭부여 방법 두 번째!!
CREATE OR REPLACE VIEW VW_EMP(사원명, 연봉, 근무년수) -- 단 모든 컬럼에 별칭을 붙여줘야함. 숫자가 부족하면 에러가 나옴.
    AS
SELECT
       EMP_NAME,
       SALARY * 12,
       EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM HIRE_DATE) 
  FROM
       EMPLOYEE;
       
-- 뷰를 삭제하고 싶다면
DROP VIEW 뷰이름;

--------------------------------------------------------------------------------
/*
    * 생성된 뷰를 이용해서 DML(INSERT, UPDATE, DELETE)를 수행가능
    뷰를 통해 DML을 수행해도 실제 데이터가 담겨있는 테이블(베이스테이블)에 적용
*/

CREATE OR REPLACE VIEW VW_JOB
    AS SELECT * FROM JOB;

-- INSERT
INSERT
  INTO
       VW_JOB
VALUES
       (
       'J8',
       '인턴'
       );
       
SELECT * FROM JOB;

UPDATE VW_JOB
   SET JOB_NAME = '신입사원'
 WHERE JOB_NAME = '인턴';
 
SELECT * FROM JOB;

DELETE FROM VW_JOB WHERE JOB_CODE = 'J8';
-- VIEW를 가지고 DML을 수행할 수 있음. 그렇지만 성능적으로 손해(서브쿼리를 계속 실행하는거니까)
-- 그리고 유지보수에 문제. 테이블이 어떻게 되어있는지 따로 확인해야하니까??
--------------------------------------------------------------------------------
-- 그리고 VIEW를 가지고 DML이 불가능한 경우가 많음
/*
    뷰를 가지고 DML이 불가능한 경우
    1) 뷰에 정의되어있지 않은 컬럼을 조작하는 경우
    2) 뷰에 정의되어 있는 컬럼중에 베이스테이블 상 NOT NULL 제약조건이 지정된 경우
    3) 산술연산식 또는 함수를 통해서 정의된 경우
    4) DISTINCT 구분이 포함된 경우 
    5) JOIN을 이용해서 여러 테이블을 매칭시켜놓은 경우
*/ 
-- 그래서 뷰로 테이블을 조작하는 것은 권장되지 않는다.
--------------------------------------------------------------------------------
/*
        * VIEW 생성 시 옵션
        [상세표현법]
        CREATE OR REPLACE FORCE/NOFORCE VIEW 뷰명
            AS 서브쿼리
          WITH CHECK OPTION
          WITH READ ONLY;
          
          1) OR REPLACE : 해당 뷰가 존재하지 않을 경우 뷰를 새로 생성 / 해당 뷰가 이미 존재한다면 갱신시켜주는 옵션
          2) FORCE / NOFORCE
            - FORCE : 서브쿼리에 기술된 테이블이 존재하지 않아도 강제로 뷰를 생성
            - NOFORCE(생략 시 기본값) : 서브쿼리에 기술된 테이블이 반드시 존재해야만 뷰를 생성
          3) WITH CHECK OPTION : 서브쿼리에 조건절에 기술된 내용에 만족하는 값으로만 DML을 수행
                                조건에 부합하지 않는 값으로 INSERT/UPDATE하는 경우 오류 발생
          4) WITH READ ONLY : 뷰에 대해서 조회만 가능(DML을 아예 수행불가)
*/

-- 2) FORCE / NOFORCE
CREATE OR REPLACE /*NO FORCE*/ VIEW VW_TEST
    AS SELECT TCODE
         FROM TT;
         
CREATE OR REPLACE FORCE VIEW VW_TEST
    AS SELECT TCODE
         FROM TT;
-- 경고: 컴파일 오류와 함께 뷰가 생성되었습니다.

SELECT * FROM VW_TEST; -- 경고로 만들어진 뷰로는 아무것도 못함. 

CREATE TABLE TT(
    TCODE NUMBER
);

SELECT * FROM VW_TEST; -- 위에서 실제 테이블을 만들어진 후에는 그 뷰를 사용할 수 있다.

--------------------------------------------------------------------------------

-- 3) WITH CHECK OPTION
CREATE OR REPLACE VIEW VW_EMP_SALARY
    AS SELECT *
         FROM EMPLOYEE
        WHERE SALARY >= 4000000
  WITH CHECK OPTION;
  
SELECT * FROM VW_EMP_SALARY;

UPDATE VW_EMP_SALARY
   SET SALARY = 1000000
 WHERE EMP_ID = 201;
-- 서브쿼리 WHERE절에 기술한 조건과 부합하지 않기 때문에 DML이 수행 불가능

UPDATE VW_EMP_SALARY
   SET SALARY = 10000000
 WHERE EMP_ID = 201;
 
 SELECT * FROM VW_EMP_SALARY;
 ROLLBACK;
--------------------------------------------------------------------------------
 -- 4) WITH READ ONLY
 -- RO : 이렇게 적혀있으면 READ ONLY
 
CREATE OR REPLACE VIEW VW_JOB_RO
   AS SELECT * FROM JOB
  WITH READ ONLY;
  
SELECT * FROM VW_JOB_RO; -- 읽는 것은 문제없이 수행

DELETE FROM VW_JOB_RO;
-- DML자체가 수행 불가. 읽기만 가능함.