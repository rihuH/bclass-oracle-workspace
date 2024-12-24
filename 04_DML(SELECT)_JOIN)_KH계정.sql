-----> JOIN을 통해 연결고리에 해당하는 컬럼만 매칭시킨다면 마치 하나의 결과물처럼 조회

-- KH
-- 무슨 강의장에 어떤 강사가 존재하는가

CREATE TABLE CLASS_ROOM(
    CLASS_ID VARCHAR2(5),
    LECTURE_NAME VARCHAR2(20)
);

INSERT INTO CLASS_ROOM VALUES('a', '백동현');
INSERT INTO CLASS_ROOM VALUES('b', '이승철');
INSERT INTO CLASS_ROOM VALUES('c', '홍길동');
COMMIT;

SELECT
       CLASS_ID,
       LECTURE_NAME
  FROM
       CLASS_ROOM;
       
CREATE TABLE STUDENT(
    CLASS_ID VARCHAR2(5),
    STUDENT_NAME VARCHAR2(20)
);

INSERT INTO STUDENT VALUES('a', '고길동');
INSERT INTO STUDENT VALUES('b', '김길동');
INSERT INTO STUDENT VALUES('b', '장길동');
COMMIT;

SELECT
       CLASS_ID,
       STUDENT_NAME
  FROM
       STUDENT;
       

SELECT
       DISTINCT STUDENT_NAME,   -- DISTINCT를 뒤에 쓰면 이미 JOIN된 테이블이 되어버렸으므로 DISTINCT를 얘만 할 수가 없음.
        -- 근데 맨 윗줄에 쓰니까 된 것 같음. 그런데 선생님은 안 된다고 함..... 되는거같은데......
       CLASS_ROOM.CLASS_ID, -- 어떤 테이블 어떤 컬럼인지 정확하게. 안 그러면 AMBIGUOSLY 하다고 오류 나옴.
       STUDENT.CLASS_ID,
       LECTURE_NAME
  FROM
       CLASS_ROOM, STUDENT 
 WHERE
       CLASS_ROOM.CLASS_ID = STUDENT.CLASS_ID;
       -- 1 내가 조회하고 싶은 테이블 FROM에 모두 적기
    -- 그러면 양 테이블의 각 행을 모두 곱해서 붙인 총 9개 행이 나옴
       -- 원하는 값 얻기 위해 조건절 ( 조건을 만족하지 않는 값은 제외하고 조회하게 됨)
       
/*
< JOIN >
두 개 이상의 테이블에서 데이터를 함께 조회하고자 할 때 사용하는 구문
조회결과는 하나의 결과물(RESULT SET)로 나옴

관계형 데이터베이스에서는 최소한 데이터로 각각의 테이블에 데이터를 보관하고 있음(중복을 최소화 하기 위해서)
-> JOIN 구문을 사용해서 여러 개의 테이블 간 "관계"를 맺어서 같이 조회 해야함
-> 무작정 JOIN해서 조인하는 것이 아니고, 테이블 간 "연결고리"에 해당하는 컬럼을 매칭시켜서 조회해야 함.

JOIN은 크게 "오라클 전용구문"과 "ANSI(미국국립표준협회)구문"로 나뉜다.
오라클전용구문은 오라클에서만, ANSI는 다른 곳에서도 사용할 수 있다.

====================================================
   오라클 전용 구문 | ANSI(오라클 + 다른 DBMS) 구문
==================================================
등가조인            | 내부조인
(EQUAL JOIN)        | (INNER JOIN)
----------------------------------------------------
포괄조인            | 
(LEFT OUTER)        | 왼쪽 외부조인(LEFT OUTER JOIN)
(RIGHT OUTER)       | 오른쪽 외부조인(RIGHT OUTER JOIN)
                    | 전체 외부조인(FULL OUTER JOIN) => 얘는 오라클문법에서는 불가능. ANSI가 오라클보다 더 나중에 만들어져서 새로운게 추가됨.
------------------------------------------------------------------------------------------------------------------------------
카테시안 곱          | 교차조인
(CARTESIAN PRODUCT) | (CROSS JOIN)
-------------------------------------------------------
자체조인(SELF JOIN)
비등가조인(NON EQUAL JOIN)

=========================================================

*/
    


/*

1. 등가조인(EQUAL JOIN) / 내부조인(INNER JOIN)

JOIN시 연결시키는 컬럼의 값이 일치하는 행들만 조인돼서 조회(== 일치하지 않는 값들을 조회에서 제외)

*/

--> 오라클 전용구문 등가조인
--> SELECT 절에는 조회하고 싶은 컬럼명을 각각 기술 (얜 변화 없음)
--> FROM - 조회하고자 하는 테이블들을 , 를 이용해서 전부 다 나열
--> WHERE 절에는 매칭을 시키고자 하는 컬럼명(연결고리)에 대한 조건을 제시함

-- 전체 사원들의 사원명, 부서코드, 부서명을 같이 조회

-- CASE 1 : 연결할 두 칼럼이 컬럼명이 다른 경우 (DEPT_CODE/ DEPT_ID)

SELECT
       DEPT_CODE,
       DEPT_ID,
       EMP_NAME,
       DEPT_TITLE
  FROM
       EMPLOYEE, 
       DEPARTMENT
 WHERE
       DEPT_CODE = DEPT_ID;
-- 일치하지 않는 값은 조회에서 제외된 것을 확인 가능
-- DEPT_CODE가 NULL인 사원 2명은 데이터가 조회되지 않는다. + DEPT_ID가 D3, D4, D7인 부서데이터가 조회되지 않음(EMPLOYEE 테이블에 사원 없어서 일치하는 사원이 없게 되어서)

-- 전체 사원들의 사원명, 직급코드, 직급명
-- EMPLOYEE -> EMP_NAME, JOB_CODE
-- JOB      -> JOB_NAME, JOB_CODE
SELECT
       JOB_CODE,
       JOB_NAME
  FROM
       JOB;
    
-- CASE 2 연결할 두 컬럼의 이름이 같을 경우(JOB_CODE)

SELECT
       EMP_NAME,
       JOB_CODE,
       JOB_NAME,
       JOB_CODE
  FROM
       EMPLOYEE, 
       JOB
 WHERE
       JOB_CODE = JOB_CODE;
-- 오류발생 : COLUMN AMBIGUOUSLY DEFINED => 확실하게 어떤 테이블의 컬럼인지 명시를 해줘야함
-- 어떤 JOB_CODE인지

-- 방법 1. 테이블명을 사용하는 방법
SELECT
       EMP_NAME,
       EMPLOYEE.JOB_CODE,
       JOB_NAME,
       JOB.JOB_CODE
  FROM
       EMPLOYEE,
       JOB
 WHERE
       EMPLOYEE.JOB_CODE = JOB.JOB_CODE;
       -- 테이블의 컬럼명이 다르면 그냥 써도 됨. 헷갈리지 않으니까. 그런데 똑같으면 테이블명으로 정확히 써줘야함.
-- 방법 2. 별칭 사용(각 테이블마다 별칭 부여 가능)
SELECT
       EMP_NAME,
       E.JOB_CODE,
       J.JOB_CODE,
       JOB_NAME
  FROM
       EMPLOYEE E,
       JOB J
 WHERE
       E.JOB_CODE = J.JOB_CODE;
       
--> ANSI구문
-- FROM절에 기준 테이블을 하나 기술한 뒤 
-- 그 뒤 JOIN절에 같이 조회하고자 하는 테이블을 기술(매칭시킬 컬럼에 대한 조건도 기술)
-- USING / ON 구문

-- EMP_NAME, DEPT_CODE, DEPT_TITLE
-- 사원명, 부서코드, 부서명
-- 연결할 두 컬럼명이 다른 경우(EMPLOYEE - DEPT_CODE / DEPARTMENT - DEPT_ID) => ON이라는 문법
-- 무조건 ON구문만 사용가능(USING구문은 사용 불가능!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!)
SELECT
       EMP_NAME,
       DEPT_CODE,
       DEPT_TITLE
  FROM
       EMPLOYEE -- 기준 테이블만 적는다
-- INNER -- 이 키워드를 안 쓰면 기본으로 INNER JOIN이라는 뜻. 그래서 다들 안 쓴다.
  JOIN
       DEPARTMENT ON (DEPT_CODE = DEPT_ID); -- 조인하고싶은 테이블명
       
       
-- EMPLOYEE, JOB_CODE, JOB_NAME
-- 사원명, 직급코드, 직급명
-- 연결할 두 컬럼명이 같을 경우(JOB_CODE)
-- ON구문 이용 ) AMBIGUOUSLY가 발생할 수 있기 때문에 명확하게 어떤 테이블의 컬럼인지 작성해주어야 함.
--참고로 JOIN은 따로 보는 게 아니고 FROM 에 포함되어 있는 것. 실행순서가 FROM과 같다.
SELECT
       EMP_NAME,
       E.JOB_CODE,
       JOB_NAME
  FROM
       EMPLOYEE E
  JOIN
       JOB J ON (E.JOB_CODE = J.JOB_CODE);
       
-- USING 구문 이용 ) 연결고리 역할의 컬럼명이 동일할 경우 사용이 가능하며 비교연산이 아닌 USING구문과 컬럼명 만으로 알아서 매칭시켜줌
SELECT
       EMP_NAME,
       JOB_CODE,
       JOB_NAME
  FROM
       EMPLOYEE
  JOIN
       JOB USING (JOB_CODE); -- USING은 별칭을 안 적어도 된다. 연결고리 역할을 할 컬럼명이 똑같은 경우
       
-- [ 참고사항 ] 위의 USING구문의 예시는 NATURAL JOIN(자연조인)으로도 가능
 SELECT
        EMP_NAME,
        JOB_CODE,
        JOB_NAME
   FROM  
        EMPLOYEE
NATURAL
   JOIN
        JOB;
-- 그렇지만 실제로 쓰지 않음. 
-- 전제조건이 있음.
-- 두 개의 테이블을 조인하는데 운 좋게도 두 테이블에 일치하는 컬럼이 유일하게 딱 1개 존재할 때만 알아서 매칭해서 조회
-- 테이블은 자주 바뀌는 것인데 바뀌면 NATURAL JOIN도 영향을 크게 받음.

-- 사원명 직급명을 조회 직급이 대리인 사원들만 조회
--> ORACLE 문법

SELECT
       EMP_NAME,
       J.JOB_NAME
  FROM
       EMPLOYEE E,
       JOB J 
 WHERE
       E.JOB_CODE = J.JOB_CODE
   AND
       JOB_NAME = '대리';

--> ANSI 문법
SELECT
       EMP_NAME,
       JOB_NAME
  FROM
       EMPLOYEE
  JOIN
       JOB USING (JOB_CODE)
 WHERE
       JOB_NAME = '대리';
       
-- EQUAL JOIN / INNER JOIN : 일치하지 않는 행은 애초에 ResultSet에 포함되지 않음.
--------------------------------------------------------------------------------

/*
 2. 포괄조인 / 외부조인 (OUTER JOIN)
 
 테이블간의 JOIN시 일치하지 않는 행도 포함시켜서 조회 가능
 단, 반드시 LEFT/ RIGHT를 지정해야하고, 기준 테이블을 선택해야함!
*/

-- "전체" 사원들의 사원명, 부서명 조회
-- INNER JOIN
SELECT
       EMP_NAME,
       DEPT_TITLE
  FROM
       EMPLOYEE
  JOIN
       DEPARTMENT ON(DEPT_CODE = DEPT_ID);
-- EMPLOYEE테이블에서 DEPT_CODE 가 NULL인 두 명의 사원은 조회X
-- DEPARTMENT 테이블에서 부서에 배정된 사원이 없는 부서(D3, D4, D7)같은 경우 조회X

-- 1) LEFT [OUTER] JOIN : 두 테이블 중 왼편에 기술된 테이블을 기준으로 JOIN
--      조건과 상관없이 왼편에 기술된 테이블의 데이터는 무조건 조회(일치하는 값을 찾지 못하더라도 조회)
-- (OUTER JOIN) 기준으로 그 왼쪽(수직으로 늘이면 위쪽) 에 있는 테이블이 기준테이블
--> ANSI
SELECT
       EMP_NAME,
       DEPT_TITLE
  FROM
       EMPLOYEE
  LEFT
-- OUTER LEFT JOIN의 기본값은 OUTER
  JOIN
       DEPARTMENT ON (DEPT_CODE = DEPT_ID);


--> ORACLE
SELECT
       EMP_NAME,
       DEPT_TITLE
  FROM
       EMPLOYEE,
       DEPARTMENT
 WHERE
       DEPT_CODE = DEPT_ID(+); -- 기준으로 삼을 테이블(EMPLOYEE)의 컬럼(DEPT_CODE) 말고 그 반대쪽 컬럼에 (+)를 붙이면 포괄조인
-- 내가 기준으로 삼을 테이블의 컬럼명이 아닌 반대 테이블 컬럼에 (+)를 붙여줌!


-- 2) RIGHT [OUTER] JOIN : 두 테이블 중 오른편에 기술된 테이블을 기준으로 JOIN
--      일치하는 컬럼값이 존재하지 않더라도 오른편에 기술된 테이블의 데이터는 무조건 조회

--> ANSI
SELECT
       EMP_NAME,
       DEPT_TITLE
  FROM
       EMPLOYEE
 RIGHT
  JOIN
       DEPARTMENT ON (DEPT_CODE = DEPT_ID); -- 이제 오른편인 DEPARTMENT가 기준. 아무도 들어오지 않은 부서도 출력됨.
       
--> ORACLE
SELECT
       EMP_NAME,
       DEPT_TITLE
  FROM
       EMPLOYEE,
       DEPARTMENT
 WHERE  
       DEPT_CODE(+) = DEPT_ID;

-- 3) FULL [OUTER] JOIN : 두 테이블이 가진 모든 행을 조회할 수 있도록 조인
SELECT
       EMP_NAME,
       DEPT_TITLE
  FROM
       EMPLOYEE
  FULL
 OUTER
  JOIN
       DEPARTMENT ON (DEPT_CODE = DEPT_ID); -- 양쪽 일치하지 않는 데이터도 다 조회.
-- ORACLE은 안 됨. 양 쪽에 (+) (+) 이렇게 붙여도 안됨. (ONLY ONE OUTER-JOINED TABLE)

--------------------------------------------------------------------------------

--3. 카테시안 곱(CARTESIAN PRODUCT) / 교차조인(CROSS JOIN)
-- 모든 테이블의 각 행들이 서로서로 매핑된 데이터가 조회됨(곱집합)
-- 두 테이블의 행들이 곱해진 조항 출력 => 데이터가 많을 수록 방대한 데이터 출력 => 과부화의 위험 => 사용 하면 안됨 => 쓰면 안됨***


-- 사원명 부서명
--> ORACLE
SELECT
       EMP_NAME,
       DEPT_TITLE
  FROM
       EMPLOYEE,
       DEPARTMENT; -- WHERE 안 하고 그냥 23 * 9 207행 나오는 게 카테시안 곱
       
--> ANSI
SELECT
       EMP_NAME,
       DEPT_TITLE
  FROM
       EMPLOYEE
 CROSS
  JOIN
       DEPARTMENT; --크로스조인.
 
--------------------------------------------------------------------------------

/*
4. 비등가 조인(NON EQUAL JOIN) -- 비등가의 뜻 그냥 =를 사용하지 않는다는뜻. 데이터가 다른 것을 조회한다는 의미가 아님.

컬럼값을 비교하는 경우가 아니라 "범위"에 포함되는 경우 매칭

EX) Side Effect -- 부작용.  '부'가 아닐부가 아니고 보조적이다 할 때의 '부'. '정/ 부'
함수에서는 원래 그 함수가 해야 할 기능 말고 하고 있는 부수적인 작업들. 예를 들어서 Setter에서 this.num = num; 말고 num++를 해준다거나 하면 이게 부작용이 됨.
메소드는 그 기능만 해야하므로 부작용은 최대한 없애야 함.

*/

-- EMPLOYEE테이블로부터 사원명, 급여 

SELECT
       EMP_NAME,
       SALARY
  FROM
       EMPLOYEE;

SELECT *
  FROM
       SAL_GRADE;
       
-- EMPLOYEE --> 사원명(EMP_NAME), 급여(SALARY)
-- SAL_GRADE --> 급여등급(SAL_LEVER)

--> ORACLE
SELECT
       EMP_NAME,
       SALARY,
       SAL_GRADE.SAL_LEVEL
  FROM
       EMPLOYEE,
       SAL_GRADE
 WHERE
       SALARY BETWEEN MIN_SAL AND MAX_SAL;
       
--> ANSI
SELECT
       EMP_NAME,
       SALARY,
       SAL_GRADE.SAL_LEVEL
  FROM
       EMPLOYEE
  JOIN
       SAL_GRADE ON (SALARY BETWEEN MIN_SAL AND MAX_SAL);       
       
--------------------------------------------------------------------------------

/*
5. 자체조인(SELF JOIN)
같은 테이블을 다시 한 번 조인하는 경우
즉, 자기자신의 테이블과 조인을 맺는 경우
*/

SELECT
       EMP_ID AS "사원 번호",
       EMP_NAME AS "사원 이름",
       PHONE AS "전화번호",
       MANAGER_ID AS "사수 사번"
       -- 사수 전화번호 필요한데?? -- 이것도 내 테이블에 있어서 조인해야할 경우
  FROM
       EMPLOYEE;

--> ORACLE
-- 사원사번, 사원명, 사원핸드폰번호, 사수번호
-- 사수사번, 사수명, 사수핸드폰번호
SELECT
       E.EMP_ID, E.EMP_NAME, E.PHONE, E.MANAGER_ID, -- 여기선 별칭을 지을 수밖에 없다. EMPLOYEE가 똑같으므로 테이블명을 그대로 적는 것으로는 판별할 수가 없기 때문이다.
       M.EMP_ID, M.EMP_NAME, M.PHONE
  FROM
       EMPLOYEE E,
       EMPLOYEE M
 WHERE
       E.MANAGER_ID = M.EMP_ID(+);
       
--> ANSI
SELECT
       E.EMP_ID, E.EMP_NAME, E.PHONE, E.MANAGER_ID,
       M.EMP_ID, M.EMP_NAME, M.PHONE
  FROM
       EMPLOYEE E
  LEFT
  JOIN
       EMPLOYEE M ON(E.MANAGER_ID = M.EMP_ID);
       
--------------------------------------------------------------------------------

/*
<다중 JOIN>


*/
-- 사원명 + 부서명 + 직급명 + 지역명(LOCAL_NAME)
--> ANSI
SELECT
       EMP_NAME,
       DEPT_TITLE,
       JOB_NAME,
       LOCAL_NAME
  FROM
       EMPLOYEE
  LEFT
  JOIN
       DEPARTMENT ON (DEPT_CODE = DEPT_ID)
  JOIN
       JOB USING(JOB_CODE)
  LEFT -- 문제가 되는 그 NULL값이 담긴 테이블과 연관된 JOIN에 모두 붙여줘야 한다. 하나라도 붙이지 않으면 없어져서 나온다.
  JOIN
       LOCATION ON (LOCATION_ID = LOCAL_CODE);
    -- 조인 순서를 조심해야 함.
    -- FROM JOIN JOIN 하면 차례로 테이블 만들고 그거랑 다음거 조인하고 그거랑 다음거 조인함. 그래서 LEFT를 하나라도 안 붙이면 다음에 사라지는 것.
    -- 순서잘 못하면 조인이 안 되어서 조인되지 않음.
    
--> ORACLE 구문
SELECT
       EMP_NAME,
       DEPT_TITLE,
       JOB_NAME,
       LOCAL_NAME
  FROM
       EMPLOYEE E,
       DEPARTMENT,
       JOB J,
       LOCATION
 WHERE
       DEPT_CODE = DEPT_ID(+)
   AND
       LOCATION_ID = LOCAL_CODE(+)
   AND
       E.JOB_CODE = J.JOB_CODE; -- 여기도, DEPT_ 값이 NULL 인 것 때문에 EMPLOYEE가 안 나오는 것이니까, DEPT와 문제된 것에만 +를 붙여준 것이다.

--------------------------------------------------------------------------------

/*
<집합 연산자 SET OPERATOR>
여러 개의 쿼리문을 가지고 하나의 쿼리문으로 만드는 연산자

- UNION ; 합집합(두 쿼리문의 수행 결과값을 더한 후 중복되는 부분을 제거한 것) OR
- INTERSECT : 교집합(두 쿼리문의 수행 결과값 중 중복된 결과부분) AND
- MINUS : 차집합 (선행쿼리문 결과값 빼기 후행쿼리문 결과값의 결과) AND NOT

- UNION ALL : 합집합의 결과에 교집합을 더한 개념
(두 쿼리문을 수행한 결과값을 무조건 더함. DB는 중복값을 없애는 데 최적화되어 있는데 중복을 없애지 않거나, 만들어내는 것
합집합에서 중복제거를 하지 않는 것
=> 중복된 행이 여러 번 조회될 수 있음)
*/

-- 1. UNION (합집합)
-- 부서코드가 D5 또는 급여가 300만원 초과인 사원들 조회(사원명, 부서코드, 급여)

SELECT
       EMP_NAME,
       DEPT_CODE,
       SALARY
  FROM
       EMPLOYEE
 WHERE
       DEPT_CODE = 'D5';
       
SELECT
       EMP_NAME,
       DEPT_CODE,
       SALARY
  FROM
       EMPLOYEE
 WHERE
       SALARY > 3000000;
       
-- UNION 사용!
SELECT -- 조건1 조회한거
       EMP_NAME,
       DEPT_CODE,
       SALARY
  FROM
       EMPLOYEE
 WHERE
       DEPT_CODE = 'D5'
 UNION
SELECT -- 조건2 조회한거
       EMP_NAME,
       DEPT_CODE,
       SALARY
  FROM
       EMPLOYEE
 WHERE
       SALARY > 3000000; 
-- 주의사항 -- UNION 사용시 SELECT절이 같아야 함.
-- 위와 같은 경우 조건식을 WHERE DEPT_CODE = 'D5' OR SALARY > 3000000로 하면 되는데
-- UNION 왜 쓰지?

-- 부서코드가 D1, D2, D3인 부서의 급여합계
SELECT SUM(SALARY)
  FROM EMPLOYEE
 WHERE DEPT_CODE = 'D1'
 UNION
SELECT SUM(SALARY)
  FROM EMPLOYEE
 WHERE DEPT_CODE = 'D2'
 UNION
SELECT SUM(SALARY)
  FROM EMPLOYEE
 WHERE DEPT_CODE = 'D3'
-- 
SELECT SUM(SALARY)
  FROM EMPLOYEE
 WHERE DEPT_CODE IN ('D1', 'D2', 'D5')
 GROUP
    BY DEPT_CODE;
-- 하면 되는데 UNION 왜 ?
-- 예전에는 많이 썼는데 요즘에는 잘 안 씀. OR로 거의 다 대체할 수 있어서.

--------------------------------------------------------------------------------
-- 2. UNION ALL
-- 대체할 기능이 아직 없는 함수
SELECT -- 조건1 조회한거
       EMP_NAME,
       DEPT_CODE,
       SALARY
  FROM
       EMPLOYEE
 WHERE
       DEPT_CODE = 'D5'
 UNION
   ALL
SELECT -- 조건2 조회한거
       EMP_NAME,
       DEPT_CODE,
       SALARY
  FROM
       EMPLOYEE
 WHERE
       SALARY > 3000000; 
-- 중복제거를 안 하고 모두 출력해줌, UNION은 중복 빼고 나오는데, 얘는 모두 출력해줌. 그래서 조건에 2개 다 만족하는 이름은 2번 출력됨.
 -------------------------------------------------------------------------------      
 -- 3. INTERSECT (교집합 - 여러 쿼리 결과의 중복된 결과만을 조회)
    SELECT -- 조건1 조회한거
          EMP_NAME,
          DEPT_CODE,
          SALARY
     FROM
          EMPLOYEE
    WHERE
          DEPT_CODE = 'D5'
INTERSECT
   SELECT -- 조건2 조회한거
          EMP_NAME,
          DEPT_CODE,
          SALARY
     FROM
          EMPLOYEE
    WHERE
          SALARY > 3000000; 
-- WHERE DEPT_CODE > 'D5' AND SALARY > 3000000로 대체할 수 있음.
--------------------------------------------------------------------------------

--4. MINUS(차집합  : 선행쿼리결과에서 후행쿼리결과를 뺀 나머지)
SELECT -- 조건1 조회한거
       EMP_NAME,
       DEPT_CODE,
       SALARY
  FROM
       EMPLOYEE
 WHERE
       DEPT_CODE = 'D5'
 MINUS
SELECT -- 조건2 조회한거
       EMP_NAME,
       DEPT_CODE,
       SALARY
  FROM
       EMPLOYEE
 WHERE
       SALARY > 3000000; 
-- WHERE AND NOT 이나 조건을 반대로 바꿔서 대신 사용할 수 있다.



