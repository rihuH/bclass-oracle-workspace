-- 실행이란?

-- 데이터 입력

-- 파일로 저장 : 데이터 출력

-- 요청 -> DB Server에 조회요청 (SELECT문으로 하는거)

-- 항상 무슨 데이터를 어떤 프로그램을 이용해서 어떤 서버랑 하는지 ??? 생각할 것


/*
 < SUB QUERY 서브쿼리 >
 
 하나의 주된 SQL(SELECT, INSERT, UPDATE, DELETE, CREATE, ...)안에 포함된 또 하나의 SELECT문
 MAIN SQL문의 보조역할을 하는 쿼리문

*/

-- 간단 서브쿼리 예시1
SELECT * FROM EMPLOYEE;
-- 강민돌 사원과 같은 부서인 사원들의 사원명 조회
-- 1) 먼저 강민돌 사원의 부서코드 조회
SELECT
       DEPT_CODE
  FROM
       EMPLOYEE
 WHERE
       '강민돌' = EMP_NAME;

-- 2) 부서코드가 D9인 사원들의 사원명 조회
SELECT
       EMP_NAME
  FROM
       EMPLOYEE
 WHERE  
       DEPT_CODE = 'D9';

-- 위의 두 단계를 하나의 쿼리문으로 합치기
SELECT
       EMP_NAME
  FROM
       EMPLOYEE
 WHERE
       DEPT_CODE = (SELECT
                           DEPT_CODE
                      FROM
                           EMPLOYEE
                     WHERE
                           '강민돌' = EMP_NAME);
--------------------------------------------------------------------------------
-- 간단 서브쿼리 예시 2
-- 전체 사원의 평균 급여보다 더 많은 급여를 받고 있는 사원들의 사번, 사원명, 직급코드 조회
-- 1) 전체 사원의 평균급여 구하기
SELECT
       AVG(SALARY)
  FROM
       EMPLOYEE; -- 대략 3295488원
       
--2) 급여가 3295488원 이상인 사원들의 사번, 사원명, 직급코드 조회
SELECT
       EMP_ID,
       EMP_NAME,
       JOB_CODE
  FROM
       EMPLOYEE
 WHERE
       SALARY >= 3295488;
       
-- 위의 두 단계를 하나의 쿼리로 합치기
SELECT
       EMP_ID,
       EMP_NAME,
       JOB_CODE
  FROM
       EMPLOYEE
 WHERE
       SALARY >= (SELECT
                         AVG(SALARY)
                    FROM
                         EMPLOYEE);
-- 서브쿼리문을 한 번에 만드려고 하지 말고 작은 쿼리문을 하나씩 작성해서 (결과가 잘 나오는지 확인하고 *** 중요)
-- 그 다음 하나로 합쳐준다.
--------------------------------------------------------------------------------

/*
    서브쿼리의 구분
    서브쿼리를 수행한 결과값이 몇 행 몇 열이냐에 따라 분류됨
    
    - 단일행 [단일열] 서브쿼리 : 서브쿼리를 수행한 결과값이 오로지 1개일 경우
    - 다중행 [단일열] 서브쿼리 : 서브쿼리 수행한 결과값이 여러행( + 단일열)일 때
    - [단일행] 다중열 서브쿼리 : 서브쿼리 수행한 결과값이 (단일행 + )여러열 일 때
    - 다중행 다중열 서브쿼리 : 서브쿼리 수행한 결과값이 여러행 여러열 일 때
    
    -> 서브쿼리를 수행한 결과가 몇 행 몇 열이냐에 따라서 사용가능한 연산자가 달라짐
*/

/*
    1. 단일행 서브쿼리(SINGLE ROW SUBQUERY)
    
    서브쿼리의 조회 결과값이 단 1개 일 때
    
    일반 연산자 사용가능(=, !=, <=, >, ...)
*/

-- 전 직원의 평균 급여보다 더 적게 받는 사원들의 사원명, 직급코드, 전화번호 조회
-- 1. 평균 급여 구하기
SELECT
       AVG(SALARY)
  FROM
       EMPLOYEE; 
       -- RESULT SET이 1행. 결과값이 1개의 값.
       
SELECT
       EMP_NAME,
       JOB_CODE,
       PHONE
  FROM
       EMPLOYEE
 WHERE  
       SALARY < (SELECT
                        AVG(SALARY)
                   FROM
                        EMPLOYEE);
               -- 서브쿼리문 결과값이 1개이기 때문에 SALARY와 대소비교 연산이 가능하다 (단일행 서브쿼리)
               
-- 최저급여를 받는 사원의 사번, 사원명, 직급코드, 급여, 입사일 조회
-- 1. 최저급여 구하기
SELECT
       MIN(SALARY)
  FROM
       EMPLOYEE;
       
SELECT
       EMP_ID,
       EMP_NAME,
       JOB_CODE,
       SALARY,
       HIRE_DATE
  FROM
       EMPLOYEE
 WHERE
       SALARY = (SELECT
                        MIN(SALARY)
                   FROM
                        EMPLOYEE);
                        
-- 리현빈 사원의 급여보다 더 많은 급여를 받는 사원들의 사원명, 부서명 조회
SELECT
       SALARY
  FROM
       EMPLOYEE
 WHERE
       '리현빈' = EMP_NAME;

SELECT
       EMP_NAME,
       DEPT_TITLE
  FROM
       EMPLOYEE
  LEFT
  JOIN
       DEPARTMENT ON (DEPT_CODE = DEPT_ID)
 WHERE
       SALARY > (SELECT
                        SALARY
                   FROM
                        EMPLOYEE
                  WHERE
                        '리현빈' = EMP_NAME);
-- JOIN도 가능

-- 나백송 사원과 같은 부서인 사원들의 사원명, 전화번호, 직급명 조회(단, 나백송 사원은 제외)
SELECT
       DEPT_CODE
  FROM
       EMPLOYEE
 WHERE
       EMP_NAME = '나백송';

SELECT
       EMP_NAME,
       PHONE,
       JOB_NAME
  FROM
       EMPLOYEE E,
       JOB J
 WHERE
       E.JOB_CODE = J.JOB_CODE
   AND
       DEPT_CODE = (SELECT
                           DEPT_CODE
                      FROM
                           EMPLOYEE
                     WHERE
                           EMP_NAME = '나백송');
   AND
       EMP_NAME != '나백송';
    
-- ANSI     
SELECT
       EMP_NAME,
       PHONE,
       JOB_NAME
  FROM
       EMPLOYEE
  LEFT
  JOIN
       JOB USING (JOB_CODE)
 WHERE
       DEPT_CODE = (SELECT
                           DEPT_CODE
                      FROM
                           EMPLOYEE
                     WHERE
                           EMP_NAME = '나백송')
   AND
       EMP_NAME != '나백송'
 ORDER
    BY
       EMP_NAME;
-- SQL (Structured Query Language)

-- 부서별로 급여 합계가// 가장 큰 부서의// 부서명, 부서코드, 급여합계
--1. 각 부서별 급여합계
SELECT
       SUM(SALARY)
  FROM
       EMPLOYEE
 GROUP
    BY
       DEPT_CODE;
--2. 부서별 급여합계 중 가장 큰 급여합
SELECT
       MAX(SUM(SALARY))
  FROM
       EMPLOYEE
 GROUP
    BY
       DEPT_CODE;
-- 3. 부서코드, 급여합계 먼저  부서명은 JOIN
SELECT
       SUM(SALARY),
       DEPT_CODE,
       DEPT_TITLE
  FROM
       EMPLOYEE
  JOIN
       DEPARTMENT ON (DEPT_CODE = DEPT_ID)
 GROUP
    BY
       DEPT_CODE,
       DEPT_TITLE; -- GROUP BY 절에서 그룹지은 것만 SELECT 절에 사용할 수 있고, 여러개를 GROUP BY 절에 쓸 수 있다. 그럼 DEPT_TITLE도 SELECT절에 쓸 수 있음.
       -- 대신 그룹별로 나뉘는게 똑같아야함
HAVING
       SUM(SALARY) = 1926000;
       
--4. 만들어진 쿼리를 하나로 합치기
SELECT
       SUM(SALARY),
       DEPT_CODE,
       DEPT_TITLE
  FROM
       EMPLOYEE
  JOIN
       DEPARTMENT ON (DEPT_CODE = DEPT_ID)
 GROUP
    BY
       DEPT_CODE,
       DEPT_TITLE
HAVING
       SUM(SALARY) = (SELECT
                             MAX(SUM(SALARY))
                        FROM
                             EMPLOYEE
                       GROUP
                          BY
                             DEPT_CODE);
--------------------------------------------------------------------------------

/*
    2. 다중 행 서브쿼리(MULTI ROW SUBQUERY)
    서브쿼리의 조회 결과값이 여러 행일 때 
    
    - IN (10, 20, 30, ..) : 여러 개의 결과값 중에서 한 개라도 일치하는 값이 있다면
    - NOT IN 하나라도 일치하는 값이 없으면
    
*/

-- 각 부서별 최고급여를 받는 사원의 이름, 직급코드, 급여 조회
-- 1) 각 부서별 최고 급여 조회
SELECT
       MAX(SALARY)
  FROM
       EMPLOYEE
 GROUP
    BY
       DEPT_CODE; -- 3320000, 3660000, 6000000, 4760000, 4900000, 2550000, 2550000

SELECT 
       EMP_NAME,
       JOB_CODE,
       SALARY
  FROM
       EMPLOYEE
 WHERE
       SALARY IN (SELECT
                         MAX(SALARY)
                    FROM
                         EMPLOYEE
                   GROUP
                      BY
                         DEPT_CODE);

-- 이승철 사원 또는 조동생 사원과 같은 부서인 사원들의 사원명, 핸드폰번호 조회
SELECT
       DEPT_CODE
  FROM
       EMPLOYEE
 WHERE
       EMP_NAME IN ('이승철', '조동생');
       
SELECT
       EMP_NAME,
       PHONE,
       DEPT_CODE
  FROM
       EMPLOYEE
 WHERE
       DEPT_CODE IN (SELECT
                            DEPT_CODE
                       FROM
                            EMPLOYEE
                      WHERE
                            EMP_NAME IN ('이승철', '조동생'));

-- 사원 < 대리 < 과장 < 차장 < 부장
-- 대리 직급인데 과장직급보다 급여를 많이 받는 직원들의 사원명, 직급명, 급여

-- 1) 과장 직급의 급여
SELECT 
       SALARY
  FROM
       JOB J,
       EMPLOYEE E
 WHERE
       J.JOB_CODE = E.JOB_CODE
   AND
       JOB_NAME = '과장'; -- 3200000, 2500000, 4760000
       
-- 2) 위의 급여보다 높은 급여를 받는 직원들의 사원명, 직급명, 급여
SELECT
       EMP_NAME,
       JOB_NAME,
       SALARY
  FROM
       EMPLOYEE E,
       JOB J
 WHERE
       E.JOB_CODE = J.JOB_CODE
   AND
       SALARY > ANY(3200000, 2500000, 4760000) 
   AND
       JOB_NAME = '대리';
/*
 X(컬럼) > ANY(값, 값, 값)
 X의 값이 ANY 괄호 안의 값 중에 하나라도 크면 참
 -- > ANY(10, 20, 30) : 여러 개의 결과값 중에서 "하나라도" 클 경우
                        참을 반환
                        --
                        여러 개의 결과값 중 ANY 괄호 안에 있는 값 중 가장 작은 값보다 클 경우)
                        
    < ANY(10, 20, 30) : 여러 개의 결과값 중에서도 "하나라도" 작을 경우
                        ==
                         여러 개의 결과값 중 (ANY괄호 안에 있는 값 중 가장 큰 값보다 작을 경우)
*/

-- 3) 위의 내용들을 하나의 쿼리문으로 합치기
SELECT
       EMP_NAME,
       JOB_NAME,
       SALARY
  FROM
       EMPLOYEE E,
       JOB J
 WHERE
       E.JOB_CODE = J.JOB_CODE
   AND
       SALARY > ANY(SELECT 
                           SALARY
                      FROM
                           JOB J,
                           EMPLOYEE E
                     WHERE
                           J.JOB_CODE = E.JOB_CODE
                       AND
                           JOB_NAME = '과장') 
   AND
       JOB_NAME = '대리';
       
-- 과장직급임에도 모든 차장 직급의 급여보다 더 많이 받는 직원
SELECT
       SALARY
  FROM
       EMPLOYEE
  JOIN
       JOB USING(JOB_CODE)
 WHERE
       JOB_NAME = '차장';
       
SELECT
       EMP_NAME
  FROM
       EMPLOYEE
  JOIN
       JOB USING(JOB_CODE)
 WHERE
       SALARY >= ALL(SELECT
                            SALARY
                       FROM
                            EMPLOYEE
                       JOIN
                            JOB USING(JOB_CODE)
                      WHERE
                            JOB_NAME = '차장')
   AND
       JOB_NAME = '과장';
--------------------------------------------------------------------------------

/*
    3. 다중열 서브쿼리
        조회 결과는 한 행이지만 나열된 컬럼의 수가 여러개일 때
        
*/
-- 서한술 사원과 같은 부서코드, 같은 직급코드에 해당하는 사원들의 사원명, 부서코드, 직급코드, 입사일 조회
SELECT 
       DEPT_CODE,
       JOB_CODE
  FROM
       EMPLOYEE
 WHERE
       EMP_NAME = '서한술'; -- D5/ J5
    
-- 사원명, 부서코드, 직급코드, 입사일 조회 부서코드가 D5이면서 직급코드가 J5인 사원
SELECT
       EMP_NAME,
       DEPT_CODE,
       JOB_CODE,
       HIRE_DATE
  FROM
       EMPLOYEE
 WHERE 
       DEPT_CODE = 'D5'
   AND
       JOB_CODE = 'J5';
-- 위의 쿼리문을 하나의 쿼리문으로 합치기
SELECT
       EMP_NAME,
       DEPT_CODE,
       JOB_CODE,
       HIRE_DATE
  FROM
       EMPLOYEE
 WHERE 
       DEPT_CODE = (SELECT DEPT_CODE FROM EMPLOYEE WHERE EMP_NAME = '서한술')
   AND
       JOB_CODE = (SELECT JOB_CODE FROM EMPLOYEE WHERE EMP_NAME = '서한술');
-- 이건 단일행 사용
SELECT
       EMP_NAME,
       DEPT_CODE,
       JOB_CODE,
       HIRE_DATE
  FROM
       EMPLOYEE
 WHERE 
       (DEPT_CODE, JOB_CODE) = (SELECT 
                                       DEPT_CODE,
                                       JOB_CODE
                                  FROM
                                       EMPLOYEE
                                 WHERE
                                       EMP_NAME = '서한술');
-- 위에건 다중열 서브쿼리 사용
--------------------------------------------------------------------------------

/*
    4. 다중행 다중열 서브쿼리
    서브쿼리 수행 결과가 여러 행 여러 컬럼일 경우

*/

-- 각 직급별 최소 급여를 받는 사원들 조회(이름, 직급코드, 급여)
SELECT
       JOB_CODE,
       MIN(SALARY)
  FROM 
       EMPLOYEE
 GROUP
    BY
       JOB_CODE;
       
SELECT
       EMP_NAME,
       JOB_CODE,
       SALARY
  FROM
       EMPLOYEE
 WHERE
       (JOB_CODE, SALARY) IN (SELECT
                                     JOB_CODE,
                                     MIN(SALARY)
                                FROM 
                                     EMPLOYEE
                               GROUP
                                  BY
                                     JOB_CODE); -- IN 사용. IN은 각각이랑 동등비교
                            
--------------------------------------------------------------------------------

/*
    5. 인라인 뷰(INLINE-VIEW) ************ 중요
    
    FROM 절에 서브쿼리를 작성하는 것 (FROM절에 서브쿼리를 사용한 것을 인라인뷰라고 한다)
    
    SELECT문의 수행결과 (RESULT SET)을 테이블 대신 사용
*/

-- 간단한 인라인 뷰 예시
-- 사원들의 이름, 보너스포함 연봉
-- 보너스 포함 연봉이 4000만원 이상인 사원만 조회
SELECT
       EMP_NAME,
       SALARY * (1 + NVL(BONUS,0)) * 12 AS "보너스 포함 연봉"
  FROM
       EMPLOYEE
 WHERE
       "보너스 포함 연봉" > 40000000;
       -- 실행순서때문에 WHERE절에 별칭을 사용할 수 없음
--> 인라인 뷰를 사용해봅시다.

SELECT
       "사원명"
       "보너스 포함 연봉"
  FROM 
       (SELECT
               EMP_NAME,
               SALARY * (1 + NVL(BONUS,0)) * 12 AS "보너스 포함 연봉"
          FROM
               EMPLOYEE)
 WHERE
       "보너스 포함 연봉" > 40000000;
       
--> 인라인 뷰를 주로 사용하는 예
--> TOP-N 분석 : 데이터베이스 상 있는 값들 중 최상위 N개의 자료를 보기 위해서 사용!

-- 전 직원 중 급여가 가장 높은 상위 5명

-- * ROWNUM : 오라클에서 제공해주는 컬럼, 조회된 순서대로 1번부터 순번을 붙여줌.
SELECT
       EMP_NAME,
       SALARY,
       ROWNUM
  FROM
       EMPLOYEE;

SELECT
       ROWNUM,
       EMP_NAME,
       SALARY
  FROM
       EMPLOYEE
 WHERE
       ROWNUM <= 5
 ORDER
    BY
       SALARY DESC; -- 실행순서때문에 ORDER BY 보다 먼저 ROWNUM으로 자르게 됨
       
-- ORDER BY절을 이용해서 먼저 정렬을 끝낸 뒤 ROWNUM을 이용해서 다섯개만 조회하기

SELECT
       EMP_NAME,
       SALARY
  FROM(SELECT -- 정렬이 끝난 RESULT SET을 FROM절의 테이블로 씀.
              EMP_NAME,
              SALARY
         FROM
              EMPLOYEE
        ORDER
           BY
              SALARY DESC)
 WHERE  
       ROWNUM <= 5;
--------------------------------------------------------------------------------
SELECT
       EMP_NAME,
       SALARY,
      -- PHONE, -- 이렇게 쓰면 조회할 수 없음. 지금 사용하는 것은 새로 정렬한 RESULT SET의 결과를 가지고 조회하는 거라 EMP_NAME, SALARY만 조회할 수 있음.
       A.* -- FROM절의 인라인뷰에 별칭을 붙인 뒤 별칭.*를 작성하면 해당 인라인뷰의 모든 컬럼을 조회할 수 있음.
  FROM(SELECT 
              EMP_NAME,
              SALARY
         FROM
              EMPLOYEE
        ORDER
           BY
              SALARY DESC)A -- 여기도 별칭을 붙일 수 있다.
 WHERE  
       ROWNUM <= 5;
       
-- 가장 최근에 입사한 사원 5명의 사원명과 입사일 조회
SELECT
       EMP_NAME,
       HIRE_DATE
  FROM
       (SELECT
               EMP_NAME,
               HIRE_DATE
          FROM
               EMPLOYEE
         ORDER
            BY
               HIRE_DATE DESC) -- 최근순 정렬
 WHERE
       ROWNUM < 6;

-- 각 부서별 평균 급여가 높은 3개 부서의 부서코드, 평균급여(정수처리)를 조회하세요.
SELECT
       DEPT_CODE,
       "평균급여" -- FROM 안에 RESULT SET에는 컬럼을 새로 연산해서 만든 컬럼이 있어서 기존 연산식을 적으면 안되고 별칭으로 불러줘야 한다.
  FROM
       (SELECT
              DEPT_CODE,
              ROUND(AVG(SALARY)) "평균급여"
         FROM
              EMPLOYEE
        GROUP
           BY
              DEPT_CODE
        ORDER
           BY
              ROUND(AVG(SALARY)) DESC)
 WHERE
       ROWNUM < 4;

-----샘 거

SELECT
       DEPT_CODE,
       "AVG(SALARY)" -- 아니면 제목형태로 불러줘야 한다. 아무튼 컬럼명을 불러줘야 한다 연산식 말고
  FROM
       (SELECT
               DEPT_CODE,
               AVG(SALARY)
          FROM
               EMPLOYEE
         GROUP
            BY
               DEPT_CODE
         ORDER
            BY
               AVG(SALARY) DESC)
 WHERE
       ROWNUM < 4;
       
--------------------------------------------------------------------------------

/*
    6. 순위 매기는 함수
    RANK() OVER(정렬기준)
    DENSE_RANK() OVER(정렬기준)
    
    ** 오로지 SELECT절에서만 작성 가능
    
*/
-- 사원들의 급여가 높은 순서대로 순위를 매겨서 사원명, 급여, 순위 조회
SELECT
       EMP_NAME,
       SALARY,
       RANK() OVER(ORDER BY SALARY DESC) "순위" -- SELECT문 안에서 정렬하고 싶은 기준을 작성한다.
  FROM
       EMPLOYEE;
-- RANK() OVER 하면 공동 7위 2명이면 그 다음은 --> 9위/

SELECT
       EMP_NAME,
       SALARY,
       DENSE_RANK() OVER(ORDER BY SALARY DESC) "순위"
  FROM
       EMPLOYEE;
-- DENSE_RANK() OVER 하면 공동 7위 2명 --> 그 다음 8위

SELECT
       EMP_NAME,
       SALARY,
       DENSE_RANK() OVER(ORDER BY SALARY DESC) "순위"
  FROM
       EMPLOYEE
 WHERE
       DENSE_RANK() OVER(ORDER BY SALARY DESC) <= 5; -- WHERE절에서 WINDOW 함수 사용이 불가능. 조회불가
       -- 이런 상황에서 방법이 인라인뷰

SELECT *
  FROM (SELECT
               EMP_NAME,
               SALARY,
               DENSE_RANK() OVER(ORDER BY SALARY DESC) "순위"
          FROM
               EMPLOYEE)
 WHERE 순위 <= 5;

SELECT
       (SELECT MAX(SALARY) FROM EMPLOYEE), -- SELECT절에 기술하는 서브쿼리를 스칼라 서브쿼리라고 한다. - 특징, 반드시 단일컬럼만을 반환해야함.
       EMP_NAME


