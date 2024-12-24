-- EMPLOYEE 테이블에 존재하는 전체 사원의 총 급여의 합 조회

SELECT
       SUM(SALARY)
  FROM 
       EMPLOYEE; --> EMPLOYEE테이블에 존재하는 전체 사원들을 하나의 그룹으로 묶어서 총 합계를 구한 결과
       
    

/*
 <GROUP BY 절>
 그룹을 묶어줄 기준을 제시할 수 있는 구문
 여러 개의 값들을 하나의 그룹으로 묶어서 처리할 목적으로 사용

*/

-- 부서별 총 급여 합
SELECT
       SUM(SALARY),
       DEPT_CODE
  FROM
       EMPLOYEE
 GROUP
    BY
       DEPT_CODE; -- 부서코드가 같은 애들끼리 묶을 것이다
       
-- 전체 사원수
SELECT
       COUNT(*)
  FROM
       EMPLOYEE;
       
-- 부서별 사원수
SELECT
       DEPT_CODE,
       COUNT(*)
  FROM
       EMPLOYEE
 GROUP
    BY
       DEPT_CODE;
       
-- 각 부서별 급여합계를 오름차순(부서코드) 정렬해서 조회
SELECT
       DEPT_CODE,
       SUM(SALARY) --> 실행3
  FROM
       EMPLOYEE --> 실행1
 GROUP
    BY
       DEPT_CODE -->실행2
 ORDER
    BY
       DEPT_CODE ASC; --> 실행4
       
-- 같은 성씨 카운트

SELECT
       COUNT(*),
       SUBSTR(EMP_NAME, 1, 1)
  FROM
       EMPLOYEE
 GROUP
    BY
       SUBSTR(EMP_NAME, 1, 1);
       
       
-- EMPLOYEE 각 직급별로 직급코드, 총 급여의 합, 사원수, 보너스를 받는 사원수, 평균급여, 최고급여, 최소급여를 조회해주세요
       
SELECT
       JOB_CODE AS "직급코드",
       SUM(SALARY) AS "총 급여의 합",
       COUNT(*) AS "사원수",
       COUNT(BONUS) AS "보너스를 받는 사원수",
       ROUND(AVG(SALARY)) AS "평균급여",
       MAX(SALARY) AS "최고급여",
       MIN(SALARY) AS "최소급여"
  FROM
       EMPLOYEE
 GROUP
    BY
       JOB_CODE
 ORDER
    BY
       JOB_CODE;

------------------------------

-- GROUP BY 사용시 주의할 점
-- : GROUP BY절 사용시 GROUP으로 나누지 않은 컬럼은 SELECT절에서 사용할 수 없음.
/*
SELECT
       EMP_NAME -- 그룹 지어둔 상태로 개별 이름을 조회할 수 없다.
  FROM
       EMPLOYEE
 GROUP
    BY
       JOB_CODE; -- 그룹을 지어둔 상태
 */      
       
-- 부서코드, 각 부서별 평균 급여
-- 평균 급여가 300만원 이상인 급여
/*
SELECT
       DEPT_CODE,
       AVG(SALARY)
  FROM
       EMPLOYEE
 WHERE
       AVG(SALARY) >= 3000000 -- 이렇게 하면 오류 발생. 실행순서때문
       -- 일반적으로 하면 FROM 다음 WHERE가 2등. 그럼 EMPLOYEE전체의 평균을 구하게 됨 이미 하나로 묶은 것을 다시 GROUP BY 할 수 없다.
 GROUP
    BY
       DEPT_CODE; 
*/       

/*
 < HAVING 절 >
 그룹에 대한 조건을 제시할 때 사용하는 구문.
 (그룹함수를 가지고 조건을 제시)

*/

SELECT
       DEPT_CODE,
       AVG(SALARY)
  FROM
       EMPLOYEE
 GROUP
    BY
       DEPT_CODE
HAVING
       AVG(SALARY) >= 3000000;
       
/*
SELECT 6총사
<실행순서 *** 중요>
5 : SELECT 조회하고자 하는 컬럼명 / 함수식/ 산술연산식 / * / 별칭..
1 : FROM 조회하고자 하는 테이블명
2 : WHERE 조건식
3 : GROUP BY 그룹 기준에 해당하는 컬럼명 / 함수식
4 : HAVING 그룹함수식에 해당하는 조건식
6 : ORDER BY 정렬기준에 해당하는 컬럼명 / 함수식 / 별칭 / 컬럼순번 --- ASC / DESC --- NULLS FIRST / NULLS LAST

*/


-- EMPLOYEE 테이블로부터 각 직급별 총 급여합이 1000만원 이상인 직급코드 , 급여합 조회// 단, 직급코드가 J6인 그룹은 제외

SELECT
       SUM(SALARY),
       JOB_CODE
  FROM
       EMPLOYEE
 WHERE
       JOB_CODE != 'J6'
 GROUP
    BY
       JOB_CODE
HAVING
       SUM(SALARY) >= 10000000
 ORDER
    BY
       SUM(SALARY);
       
-- 보너스를 받는 사원이 없는 부서코드만 조회
       
-- 답       
SELECT
       DEPT_CODE
  FROM
       EMPLOYEE
 GROUP
    BY
       DEPT_CODE
HAVING
       COUNT(BONUS) = 0;
 -- COUNT는 NULL 아닌 것만 셈.
-----------------------------









