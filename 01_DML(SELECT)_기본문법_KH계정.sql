/*

SQL문 공부

각 데이터를 관리하는 작업
JAVA에서 CRUD 작업 한 것을 DB에 저장하거나, 저장된 것을 불러오거나, 수정하거나 삭제하는 작업을 할 때 SQL을 사용하게 된다.
특히 READ기능을 사용할 때 가장 많이 쓰게 된다. 거의 80프로 이상의 비중을 가진다.

SQL은 TABLE(표) 형태로 데이터를 관리함.

*/

/*

    <SELECT>
    데이터를 조회하거나 검색할 때 사용하는 명령어
    
    [표현법]
    SELECT 조회하고싶은 컬럼, 컬럼, 컬럼...
        FROM 테이블명; (어떤 테이블에서 작성하는건지???)
        
-- ResultSet : 조회된 행들의 집합/ SELECT 구문을 통해 조회된 데이터의 결과물을 의미.
*** 매우 중요

*/
/*
SELECT 
        EMP_NAME, 
        EMAIL, 
        PHONE -- 적은 순서대로 조회가 된다.
  FROM  
        EMPLOYEE; -- 테이블명
    -- 그리고 조회는 항상 COLUMN 단위로 조회가 된다.
    -- 키워드는 왼쪽/ 식별자는 오른쪽
    -- 한 줄에 하나씩 작성(오타 났을 때 찾기 쉬우라고)
    -- 키워드의 끝 라인이 동일하도록 (한 글자가 스페이스 하나씩)
    -- 키워드랑 식별자는 한 칸 여백
    -- 취향에 따라 쉼표를 앞 줄에 쓸 수도 있음.
    
    -- EMPLOYEE 테이블에 존재하는 전체 사원들의 모든 컬럼들을 다 조회
SELECT * FROM EMPLOYEE; -- 보통 책에 나오는 것. *는 모든 
-- 하지만 이렇게 안 쓰는 것이 좋음. 감리 들어오면 바로 걸림. 성능에 영향을 미쳐서. 
-- SELECT문 쓸 때 * 는 최대한 자제해서 사용. 성능에 영향을 끼침.
    
-- 명령어, 키워드, 테이블명, 컬럼명 대/소문자를 가리지 않음
-- 소문자로 적어도 동작함. 대문자로 작성하는 습관을 들이는 것이 좋음.

-- 실습문제
-- 1. Job 테이블의 모든 컬럼을 조회하세요.
*/
SELECT 
       JOB_CODE, 
       JOB_NAME
  FROM 
       JOB;

-- 2. JOB테이블에서 직급명 컬럼만 조회.

SELECT 
       JOB_NAME
  FROM 
       JOB;
    
-- 3. DEPARTMENT테이블의 모든 컬럼을 조회하세요.

SELECT
       DEPT_ID,
       DEPT_TITLE,
       LOCATION_ID
  FROM 
       DEPARTMENT;
       
-- 4. EMPLOYEE 테이블에서 직원명, 이메일, 전화번호, 입사일 컬럼만 조회하세요.

SELECT
       EMP_NAME,
       EMAIL,
       PHONE,
       HIRE_DATE
  FROM 
       EMPLOYEE;

-- 5. EMPLOYEE테이블에서 입사일, 직원명, 급여 컬럼만 조회해주세요
SELECT
       HIRE_DATE,
       EMP_NAME,
       SALARY
  FROM 
       EMPLOYEE;
    
---------------------------------------------------------------

/*
<컬럼의 값을 통한 산술연산>
조회하고자 하는 컬럼들을 나열하는 SELECT절에 산술연산(+-* /)을 기술해서 결과를 조회할 수 있음
*/
-- EMPLOYEE 테이블로부터 직원명, 월급, 연봉( == 월급 * 12) 조회
-- FROM 절이 먼저 수행이 된다. 그 다음 SELECT문이 수행이 된다. FROM으로 먼저 테이블 접근하고,
-- 그 다음 SELECT 컬럼을 골라서 조회함.
SELECT
       EMP_NAME,
       SALARY,
       SALARY * 12
  FROM 
       EMPLOYEE;
  
-- EMPLOYEE 테이블로부터 직원명, 월급, 보너스, 보너스가 포함된 연봉
SELECT
       EMP_NAME,
       SALARY,
       BONUS,
       SALARY * (1 + BONUS) * 12
  FROM 
       EMPLOYEE;
--> 산술연산 과정에서 NULL 값이 존재할 경우 산술연산 결과도 NULL이 된다.

-- DATE -> 년, 월, 일, 시, 분, 초 모두 저장.
-- DATE 타입끼리도 연산가능
-- EMPLOYEE 테이블에서 직원명, 입사일, 근무일수(오늘날짜 - 입사일)
-- 오늘날짜 : SYSDATE (시스템 날짜 가져옴)
SELECT
       EMP_NAME,
       HIRE_DATE,
       SYSDATE - HIRE_DATE
  FROM
       EMPLOYEE;
-- 값이 지저분한 이유는 DATE 타입 안에 시/분/초가 포함되어있어서 연산을 수행하기 때문
-- 소수점을 기준으로 앞부분이 일 단위,/ 뒷부분은 시분초 연산.
-- 결과값은 일 수 단위로 출력

-------------------------------------------

/*
 < 컬럼명에 별칭 부여하기>
 [표현법] 
 컬럼명 AS 별칭 , 컬럼명 AS "별칭", 컬럼명 "별칭", 컬럼명 별칭
*/

SELECT
       EMP_NAME AS 이름,
       SALARY AS "급여(월)", -- 급여(월)이라고 특수문자 넣어서 하면 오류 발생. 그래서 "" 사용.
       BONUS 보너스,
       SALARY * (1 + BONUS) * 12 "총 소득" -- 공백문자도 특수문자랑 마찬가지로 "" 없이 넣으면 안 됨.
  FROM
       EMPLOYEE;
       
----------------------------------------------

/*
<리터럴>
임의로 지정한 문자열('')을 SELECT절에 기술하게 되면
ResultSet을 반환받을 때 데이터를 붙여서 조회할 수 있음.

오라클에서는 '' 여기 안에 문자열 작성
*/

SELECT
       EMP_NAME,
       SALARY,
       '원' 단위
  FROM 
       EMPLOYEE;
----------------------------------

/*
<DISTINCT>
중복제거
조회하고자 하는 컬럼 앞에 중복된 값을 딱 한 번씩만 조회하는 용도로 사용.

[표현법]
DISTINCT 컬럼명
(단, SELECT절에 DISTINCT구문은 한 개만 사용 가능)

*/

SELECT
       DISTINCT DEPT_CODE,
       EMP_NAME
  FROM
       EMPLOYEE;
------------------------------------------------------------

/*
SELECT문에서 조건을 부여하는 방법(자바보다 빠름)

<WHERE 절>
조회하고자 하는 테이블에 특정 조건을 제시해서
조건에 만족하는 데이터만을 조회하고자 할 때 기술하는 구문

[표현법]
SELECT 조회하고자 하는 컬럼명, 컬럼명, 컬럼명, ...
  FROM 테이블명
 WHERE 조건식;
 
 실행순서**** 중요
 FROM 먼저/ 조건식/ SELECT  ******중요
 
 - 조건식에는 다양한 연산자들을 사용할 수 있음
 
 <비교연산자>
 >, <, >=, <=, // 대소비교
 동등비교 자바 ==
 SQL에서는 =
 일치하지 않는건 !=, <>, ^=
 

*/
       
----- EMPLOYEE테이블로부터 사원들의 사원명, 급여 조회 --> 급여가 300만원 이상인 사원들만 조회

SELECT
       EMP_NAME,
       SALARY
  FROM 
       EMPLOYEE
 WHERE
       SALARY >= 3000000;
    
--------------EMPLOYEE 테이블로부터 부서코드가 D9인 사원들의 사원명, 부서코드 조회

SELECT
       EMP_NAME,
       DEPT_CODE
  FROM
       EMPLOYEE
 WHERE 
       DEPT_CODE = 'D9';

----- EMPLOYEE 테이블로부터 부서코드가 D9가 아닌 사원들의 사원명, 전화번호 조회

SELECT
       EMP_NAME,
       PHONE
  FROM
       EMPLOYEE
 WHERE
       DEPT_CODE ^= 'D9'; -- 조건과 실제 사용하게 되는 컬럼명이 꼭 같지 않아도 된다.
       -- 예시로 써본 것이지 일반적으로 !=를 많이 쓰므로 굳이 다른 것을 쓸 필요 없다.

-------------------------------------------------

/*
<실습 문제>
*/

-- 1. EMPLOYEE테이블에서 급여가 250만원 이상인 사원들의 이름, 급여, 입사일 조회
SELECT
       EMP_NAME,
       SALARY,
       HIRE_DATE
  FROM 
       EMPLOYEE
 WHERE
       SALARY > 2500000;

-- 2. EMPLOYEE 테이블에서 직급코드가 J2인 사원들의 이름, 급여 보너스
SELECT
       EMP_NAME,
       SALARY,
       BONUS
  FROM
       EMPLOYEE
 WHERE 
       JOB_CODE = 'J2';
-- 3. EMPLOYEE 테이블에서 현재 재직중인 사원(N) 사번, 이름, 입사일
SELECT
       EMP_ID,
       EMP_NAME,
       HIRE_DATE
  FROM
       EMPLOYEE
 WHERE
       ENT_YN = 'N';
-- 4. EMPLOYEE 연봉이 5000만원 이상인 사원들의 이름, 급여, 연봉, 입사일 조회
SELECT
       EMP_NAME,
       SALARY,
       SALARY * 12 연봉, -- 별칭을 지었어도 조건문같은 곳에서 '연봉' 별칭을 쓰면 식별하지 못함. 왜냐하면 실행순서가 조건문이 SELECT절보다 빠르기 때문에
       HIRE_DATE
  FROM
       EMPLOYEE
 WHERE
       SALARY * 12 > 50000000;

-- 참고로 없는 걸 조회하면, 그 자료가 없어서 0행이더라도 조회는 된 것임. 조회실패한 것과 다름.
--> SELECT절에 부여한 별칭을 WHERE절에 사용할 수 없는 이유는 WHERE절의 실행순서가 더 빠르기 때문.

/*
<논리 연산자>
여러 개의 조건을 엮을 때 사용


*/

-- EMPLOYEE테이블로부터 부서코드가 'D9'이면서 급여가 500만원 이상인 사원들의 사원명, 부서코드, 급여 조회
-- 조회는 행단위로 됨
SELECT
       EMP_NAME,
       DEPT_CODE,
       SALARY
  FROM
       EMPLOYEE
 WHERE 
       DEPT_CODE = 'D9';

SELECT
       EMP_NAME,
       DEPT_CODE,
       SALARY
  FROM
       EMPLOYEE
 WHERE
       SALARY >= 5000000;

SELECT
       EMP_NAME,
       DEPT_CODE,
       SALARY
  FROM
       EMPLOYEE
 WHERE 
       DEPT_CODE = 'D9'
   AND -- AND연산자
       SALARY >= 5000000;
       
-- 부서코드가 'D6'이거나 급여가 300만원 이상인 사람들의 이름, 부서코드, 급여 조회
SELECT
       EMP_NAME,
       DEPT_CODE,
       SALARY
  FROM 
       EMPLOYEE
 WHERE 
       DEPT_CODE = 'D6'
    OR  -- OR 연산자
       SALARY > 3000000;
       
-- EMPLOYEE테이블로부터 급여 컬럼의 값이 350만원 이상이고, 500만원 이하인 사원들의 사번, 이름, 급여, 직급코드를 조회

SELECT
       EMP_ID,
       EMP_NAME,
       SALARY,
       JOB_CODE
  FROM
       EMPLOYEE
 WHERE
       SALARY >= 3500000 
   AND
       SALARY <= 5000000;
       
--------------------------------------------------------------------------------

/*
<BETWEEN AND>
몇 이상 몇 이하인 범위에 대한 조건을 제시할 때 사용

[표현법]
비교대상컬럼명 BETWEEN 하한값 AND 상한값

*/

-- EMPLOYEE테이블로부터 급여가 350이상 500이하인 사원들의 사번 이름 급여 직급코드 조회
SELECT
       EMP_ID,
       EMP_NAME,
       SALARY,
       JOB_CODE
  FROM
       EMPLOYEE
 WHERE 
       SALARY BETWEEN 3500000 AND 5000000;
       
-- EMPLOYEE테이블로부터 급여가 350만 미만이거나 500만 초과하는 사원들의 사번, 이름, 급여, 직급코드
SELECT
       EMP_ID,
       EMP_NAME,
       SALARY,
       JOB_CODE
  FROM
       EMPLOYEE
 WHERE 
       NOT SALARY BETWEEN 3500000 AND 50000000;
--> 오라클에서의 NOT은 자바의 !와 동일한 의미. NOT의 위치는 큰 영향을 주지 않음. SALARY앞에 두어도 문제 없음.
-- BETWEEN 앞에 붙이는 게 의미적으로 명확하니까

-- BETWEEN AND 연산자는 DATE형식에도 사용 가능
-- 입사일이 '90/01/01' ~ '03/01/01' 인 사원들의 이름과 입사일 조회

SELECT
       EMP_NAME,
       HIRE_DATE
  FROM 
       EMPLOYEE
 WHERE 
       HIRE_DATE BETWEEN '90/01/01' AND '03/01/01';
       
--------------------------------------------------------------------------------

/*
< LIKE '특정패턴' >
비교하려는 컬럼의 값이 내가 지정한 특정 패턴에 만족할 경우 조회

[ 표현법 ]
비교대상컬럼명 LIKE '특정패턴'

- 특정패턴 --> 와일드 카드
 '%', '_'    => 두 가지를 가지고 패턴을 만들어낼 수 있음.

'%' : 0글자 이상을 의미
    비교대상컬럼명 LIKE 'A%' -> 비교대상컬럼값 중 A로 시작하는 것만 조회 --> APPLE, A, ADD, 
    비교대상컬럼명 LIKE '%A' -> 컬럼값 중 A로 끝나는 것만 조회. --> BANANA, A, (참고, 대소문자 다 구분함.)
    비교대상컬럼명 LIKE '%A%' -> 컬럼값 중 A가 포함되는 것 모두 조회
'_' : 1글자 의미
    비교대상컬럼명 LIKE '_A' -> 해당 컬럼값 중에 'A'앞에 무조건 1글자 있는 것만 조회.
    비교대상컬럼명 LIKT '__A' -> 해당 컬럼값 중에 'A'앞에 무조건 2글자 있는것만 조회

*/

--EMPLOYEE테이블로부터 모든 사원의 이름, 부서코드 조회

SELECT
       EMP_NAME,
       DEPT_CODE
  FROM
       EMPLOYEE;
-- EMPLOYEE테이블로부터 성이 '강'씨인 사원들의 사원명, 부서코드
SELECT
       EMP_NAME,
       DEPT_CODE
  FROM
       EMPLOYEE
 WHERE 
       EMP_NAME LIKE '강%';
       
-- EMPLOYEE테이블로부터 이름에 '민'이라는 글자가 포함된 사원들의 사원명, 부서코드

SELECT
       EMP_NAME,
       DEPT_CODE
  FROM
       EMPLOYEE
 WHERE 
       EMP_NAME LIKE '%민%';
       
-- 이름의 가운데 글자가 '길'인 사원들의 사원명, 부서코드
SELECT
       EMP_NAME,
       DEPT_CODE
  FROM
       EMPLOYEE
 WHERE
       EMP_NAME LIKE '_길_';

-- 이름의 두 번째 글자가 '길'이 아닌 사원들의 사원명, 부서코드
SELECT
       EMP_NAME,
       DEPT_CODE
  FROM
       EMPLOYEE
 WHERE 
       EMP_NAME NOT LIKE '_길_';
       
--------------------------------------------------------------------------------

/*
<실습문제> 
*/

-- 1. EMPLOYEE 테이블로부터 전화번호4번째 자리가 9로 시작하는 사원들의 사원명, 전화번호 조회
SELECT
       EMP_NAME,
       PHONE
  FROM 
       EMPLOYEE
 WHERE
       PHONE LIKE '___9%';

-- 2. EMPLOYEE테이블로부터 이름이 '동'으로 끝나는 사원들의 이름, 입사일 조회
SELECT
       EMP_NAME
       HIRE_DATE
  FROM 
       EMPLOYEE
 WHERE
       EMP_NAME LIKE '%동';
       
--3. EMPLOYEE테이블로부터 전화번호 처음 3글자가 010이 아닌 사원들의 이름, 전화번호 조회
SELECT
       EMP_NAME,
       PHONE
  FROM
       EMPLOYEE
 WHERE 
       PHONE NOT LIKE '010%';

-- 4. DEPARTMENT테이블로부터 해외영업과 관련된 부서들의 부서명 조회
SELECT
       DEPT_TITLE
  FROM
       DEPARTMENT
 WHERE
       DEPT_TITLE LIKE '%해외%';
  
  
--------------------------------------------------------------------------------

/*
 < IS NULL >
[표현법]
비교대상컬럼 IS NULL : 컬럼값이 NULL일 경우
비교대상컬럼 IS NOT NULL : 컬럼값이 NULL이 아닐 경우
 
*/

SELECT
       EMP_NAME,
       BONUS
  FROM
       EMPLOYEE;
       
-- EMPLOYEE테이블로부터 보너스를 받지 않은 사원들의 사원명, 보너스 조회
SELECT
       EMP_NAME,
       BONUS
  FROM
       EMPLOYEE
 WHERE 
       BONUS IS NULL;
       
-- EMPLOYEE 테이블로부터 보너스를 받는 사원들의 사원명, 보너스 조회
SELECT
       EMP_NAME,
       BONUS
  FROM
       EMPLOYEE
 WHERE
       BONUS IS NOT NULL;
       
-- EMPLOYEE테이블로부터 부서코드가 D6이거나 D8이거나 D5인 사원들의 사원명, 부서코드 조회

SELECT
       EMP_NAME,
       DEPT_CODE
  FROM
       EMPLOYEE
 WHERE
       DEPT_CODE = 'D6'
    OR
       DEPT_CODE = 'D8'
    OR 
       DEPT_CODE = 'D5';
  
 /*
  < IN >
  비교대상 컬럼 값에 내가 제시한 목록 중에서 일치하는 값이 있는지
  
  [표현법]
  비교대상컬럼 IN (값, 값, 값, ... )
 */
  
SELECT
       EMP_NAME,
       DEPT_CODE
  FROM
       EMPLOYEE
 WHERE
       DEPT_CODE IN ('D6', 'D8', 'D5');
  
  
--------------

SELECT
       EMP_NAME,
       DEPT_CODE
  FROM
       EMPLOYEE
 WHERE
       DEPT_CODE = 'D6'
    OR
       DEPT_CODE = 'D8'
    AND 
       DEPT_CODE = 'D5';
-- > 결과가 D6만 나옴.  연산자 우선순위 때문
/*
<연산자 우선순위>
0. ()
1. 산술연산자
2. 연결연산자
3. 비교연산자
4. IS NULL, LIKE, IN(이 셋은 똑같음 앞부터 차례로 수행됨)
5. BTWEEN AND
6. NOT
7. AND
8. OR
-- AND가 OR보다 우선순위가 높음.

*/
--------------------------------------------------------------------------------

/*
< 연결연산자 || >
여러개의 컬럼값들을 마치 하나의 컬럼인 것처럼 연결시켜주는 연산자
컬럼값 또는 리터럴(임의의문자열)을 전부 다 연결
*/

SELECT
       EMP_ID ||
       EMP_NAME
  FROM
       EMPLOYEE;
-- || 사용하면 컬럼이 하나로 합쳐져서 나온다. EMP_IDEMP_NAME 이렇게 붙어서 나옴.

SELECT
       EMP_ID ||
       '번 사원 ' ||
       EMP_NAME ||
       '님의 핸드폰 번호는' ||
       PHONE ||
       '입니다.' AS 사원정보
  FROM EMPLOYEE;;

--------------------------------------------------------------------------------

/*
조회할 행이 2개 이상일 경우 무조건 사용/ 단일행일 땐 사용하지 않음
조회된 resultSet을 정렬하는 용도
< ????? ORDER BY 절 ????? >
정렬용도로 사용하는 구문
SELECT문 가장 마지막에 기입하는 문법 + 실행 순서 또한 항상 가장 마지막
사용하지 않는 경우 ResultSet은 정렬하지 않은 상태이기 때문에 정렬하고 싶다면 반드시 작성해야함. *** 중요

[표현법] 
SELECT
       조회할컬럼명,
       조회할컬럼명,
       ...
  FROM 
       조회할테이블명
 WHERE
       조건식
 ORDER
    BY
       [정렬기준으로잡고싶은컬럼명/ 별칭/ 컬럼순번..] [ASC/ DESC] [NULLS FIRST/ NULLS LAST] -- ASC는 오름차순
- ASC : 오름차순 정렬(생략 시 기본값)
- DESC : 내림차순 정렬
- NULLS FIRST : 정렬하고자 하는 컬럼값에 NULL값이 존재할 경우 해당 NULL값들을 조회 결과의 위쪽으로 배치. NULL 뒤에 S주의(내림차순일 경우 기본값)
- NULLS LAST : 정렬하고자 하는 컬럼값에 NULL값이 존재할 경우 해당 NULL값들을 조회 결과의 하단으로 배치(오름차순일 경우 기본값)

*/

SELECT
       EMP_ID,
       EMP_NAME,
       BONUS
  FROM
       EMPLOYEE
 ORDER
    BY
-- BONUS; ACS/DESC 생략시 기본값은 ASC(오름차순)
-- BONUS DESC; 내림차순 정렬 시 기본적으로 NULLS FIRST
--       BONUS DESC NULLS LAST;
       BONUS, EMP_ID ASC; 
-- 첫 번째로 제시한 정렬기준의 컬럼값이 동일할 경우 두 번째 정렬 기준을 가지고 또 정렬을 할 수 있음(첫번째 정렬기준값이 똑같은 것들 끼리는 정렬되지 않은 상태이므로)

SELECT
       EMP_NAME,
       SALARY * 12 연봉
  FROM
       EMPLOYEE
 ORDER
    BY
       연봉;
-- 별칭 사용가능 SELECT보다 ORDER BY절의 실행순서가 더 뒤이기 때문.
-- 그리고 컬럼의 순번을 가지고도 정렬가능.
SELECT
       EMP_NAME,
       SALARY * 12 연봉
  FROM
       EMPLOYEE
 ORDER
    BY
       2 DESC; -- 2번째 컬럼인 연봉을 기준으로 내림차순으로 하게 되는데
       -- 권장되지 않는 방법이다. 어떤 조건으로 정렬했는지 보기 힘들기 때문
       

---------
/*
1. 행단위 조회
2. ResultSet
3. 실행순서
4. 조회결과가 없다고 조회하지 않은 것은 아니다.
5. 정렬 반드시 ORDER BY. ORDER BY절을 작성하지 않은 SET은 정렬되지 않은 것이다.
*/


       
       
       
       
       