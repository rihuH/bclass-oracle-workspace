/*

함수 < FUNCTION >
자바로 따지면 메소드
전달된 값들을 가지고 계산된 결과를 반환


- 단일행함수 : N개의 값을 읽어서 N개의 값을 리턴(매 행마다 함수를 실행한 후 결과 반환)
- 그룹함수 : N개의 값을 읽어서 1개로 결과를 리턴(하나의 그룹별로 함수 실행 후 결과를 반환) 
-- 그래서 단일행함수와 그룹함수는 결과로 돌아오는 행 개수가 다르므로 같이 쓸 수 없다.

*/
---------------------<단일행 함수>--------------------------
/*
    ** 자바 String 특징 불변객체(Immutalble) 먼저 말하고 다음 특징 말하기. 가장 중요한 특징 먼저
    
    오라클의 함수는 PURE하다. 자바와 다르게 정말 함수처럼 정직한 결과값을 내보냄.
    < 문자열과 관련된 함수 > 
    LENGTH / LENGTHB
    
    STR : '문자열' / 문자열이 들어있는 컬럼
    
    - LENGTH(STR) : 전달된 문자열의 글자 수 반환
    - LENGTHB(STR) : 전달된 문자열의 바이트 수 반환
    
    결과는 NUMBER 타입으로 반환.(숫자타입을 오라클에서 이렇게 표현)
    
    한글 : 'ㄱ', 'ㅏ', '강', => 한 글자당 3Byte 취급. ㄱ 도 강 도 3바이트
    숫자, 영어, 특수문자 => 한 글자당 1Byte 취급
        
*/

SELECT
       LENGTH('오라클!'),
       LENGTHB('오라클!')
  FROM
       DUAL; -- 가상테이블(DUMMY TABLE)
       

SELECT
       EMAIL,
       LENGTH(EMAIL)
  FROM
       EMPLOYEE;

--------------------------------------------------------------------------------

/*
INSTR
- INSTR(STR) : 문자열로부터 특정 문자의 위치값 반환

INSTR(STR, '특정 문자', 찾을위치의시작값, 순번)

결과값은 NUMBER타입으로 반환
찾을 위치의 시작값과 순번은 생략 가능

찾을 위치의 시작값
1. : 앞에서부터 찾겠다. (안 적으면 기본값)
-1 : 뒤에서부터 찾겠다.

*/

SELECT INSTR('AABAACAABBAA', 'B') -- 앞에서부터 3번째니까 3 나옴.
  FROM DUAL; -- 찾을 위치, 순번 생략시 기본적으로 앞에서부터 첫 번째 글자의 위치 검색.
  
SELECT INSTR('AABAACAABBAA', 'B', -1)
  FROM DUAL; -- 뒤에서부터 검색해서 10번째인 맨 마지막 B 나옴
-- 해당 문자열의 뒤에서부터 첫번째 'B'가 앞에서부터 몇 번째에 존재하는지 반환.

SELECT INSTR('AABAACAABBAA', 'B', 1, 3)
  FROM DUAL;
  -- 3번째 B의 위치가 나옴
  -- 없는 4번째 B찾으라고 하면 0 나옴
-- 해당 문자열의 앞에서부터 세번째 'B'가 앞에서부터 몇 번째에 존재하는지 반환

--- EMPLOYEE테이블로부터 EMAIL컬럼의 값들 중 @ 위치 찾기!
SELECT
       INSTR(EMAIL, '@') "@의 위치"
  FROM
       EMPLOYEE;
--------------------------------------------------------------------------------

/*
 SUBSTR
 
 - SUBSTR(STR, POSITION, LENGTH) : 문자열부터 특정 문자열을 추출해서 반환
 STR : '문자열' 또는 문자타입 컬럼값
 POSITION : 문자열 추출 시작위치값(음수도 제시가능) -> POSITION번째 문자부터 추출
 LENGTH : 추출할 문자 개수(생략시 끝까지라는 의미)
 
*/

SELECT
       SUBSTR('KH정보교육원', 3) -- 3번째 글자부터 끝까지 추출
  FROM
       DUAL;
----------
SELECT
       SUBSTR('KH정보교육원', 3, 2) -- 3번째부터 2개 '정보' 추출
  FROM
       DUAL;
       
----------

SELECT
       SUBSTR('KH정보교육원', -3, 2) --가장 마지막 글자를 -1, 그 앞을 -2 라고 쳐서 뒤에서부터 3번째부터 시작해서 뒤로 2개.
  FROM
       DUAL;
-- 시작 위치가 음수일 경우 뒤에서부터 N번째 위치로부터 문자를 추출하겠다 라는 의미

--EMPLOYEE테이블로부터 사원명과 이메일 컬럼과 EMAIL컬럼의 아이디 값만 조회
SELECT
       EMP_NAME,
       EMAIL,
       SUBSTR(EMAIL, 1, INSTR(EMAIL, '@') - 1) 아이디
  FROM
       EMPLOYEE;
-- INSTR 반환값이 정수이므로 정수처럼 사용.

------

여성사원들만 조회
SELECT
       EMP_NAME
  FROM 
       EMPLOYEE
 WHERE
       SUBSTR(EMP_NO, 8, 1) IN ('2', '4');
       
--------------------------------------------------------------------------------

/*
LPAD / RPAD

- LPAD / RPAD (STR, 최종적으로 반환할 문자의 길이(바이트), 패딩할 문자)
 : 제시한 문자열에 임의의 문자를 왼쪽 또는 오른쪽에 덧붙여서 최종 N길이만큼의 문자열을 반환
 
 결과값은 CHARACTER타입으로 반환
 덧붙이고자 하는 문자는 생략 가능

-- 패딩 할 때 패드의 줄임말
*/

SELECT
       LPAD(EMAIL, 25)
  FROM
       EMPLOYEE; -- 덧붙이고자 하는 문자 생략시 기본적으로 공백
       
-------------

SELECT
       RPAD(EMAIL, 25, '#')
  FROM
       EMPLOYEE;

--------------

SELECT
       EMP_NAME,
       EMP_NO
  FROM
       EMPLOYEE;
       
-- ----
SELECT RPAD('770101 - 1', 14, '*')
  FROM DUAL;
  -- 마스킹 작업이라 한다.
  
-- EMPLOYEE테이블에서 모든 직원의 사원명과 주민등록번호 뒤 6자리를 마스킹처리해서 조회하기.
SELECT
       EMP_NAME,
       RPAD(SUBSTR(EMP_NO, 1, 8), 14, '*') "주민번호"
  FROM 
       EMPLOYEE;

--------------------------------------------------------------------------------

/*
 LTRIM / RTRIM
 
 - LTRIM / RTRIM (STR, 제거하고자하는문자)
 : 문자열의 왼쪽 또는 오른쪽에서 제거하고자 하는 문자들을 찾아서 제거한 나머지 문자열을 반환
 
 결과값은 CHARACTER 타입으로 반환
 제거하고자하는 두번째 인자값은 생략 가능
 
*/

SELECT
       LTRIM('      K   H')
  FROM 
       DUAL;
       -- LTRIM은 왼쪽에 있는 공백문자
       
SELECT
       LTRIM('123123KH123', '123')
  FROM
       DUAL; -- KH123/ 123이 전부 사라짐
       
--------------------------------------------------------------------------------
/*

TRIM
- TRIM(BOTH / LEADING / TRAILING '제거시키고자하는문자' FROM STR)
 : 문자열의 앞 / 뒤 / 양쪽에 있는 특정 문자를 제거한 나머지 문자열을 반환
 
 결과값은 CHARACTER타입으로 반환
 BOTH / LEADING / TRAILING 생략시 기본값은 BOTH

*/

-- 기본적으로 양쪽에 있는 문자 제거
SELECT
       TRIM('     K  H     ')
  FROM
       DUAL;
-------- LEADING은 LTRIM의 역할
SELECT
       TRIM(LEADING 'Z' FROM 'ZZZKHZZZ')
  FROM
       DUAL; -- LEADING : 앞쪽
-------- TRAILING RTRIM의 역할
SELECT
       TRIM(TRAILING 'Z' FROM 'ZZZKHZZZ')
  FROM
       DUAL; -- TRAILING : 뒤쪽
       
SELECT
       TRIM('Z' FROM 'ZZZKHZZZ')
  FROM 
       DUAL;
--------------------------------------------------------------------------------

/*
LOWER / UPPER / INITCAP

- LOWER(STR)
 : 다 소문자로 변경
 
- UPPER(STR)
 : 다 대문자로 변경
 
- INICAP(STR)
 : 각 단어마다 앞글자만 대문자로 변경
 
 결과값은 모두 CHARACTER타입으로 반환
 
*/

SELECT
       LOWER('HELLO WORLD')
  FROM
       DUAL;
       
SELECT
       UPPER('hello world')
  FROM
       DUAL;
       
SELECT
       INITCAP('HELLO WORLD')
  FROM
       DUAL;
       
--------------------------------------------------------------------------------

/*
CONCAT

- CONCAT (STR1, STR2)
 : 전달된 두 개의 인자를 하나로 합친 결과를 반환
 
 결과값은 CHARACTER 타입으로 반환
*/

SELECT CONCAT('경실련하이텔', '정보교육원')
  FROM DUAL;
  
--------------------------------------------------------------------------------

/*
 REPLACE
 
 - REPLACE(STR, 찾을문자, 바꿀문자)
  : STR로부터 찾을 문자를 찾아서 바꿀문자로 바꾼 문자열을 반환
  
  결과값은 CHARACTER타입으로 반환
*/

SELECT
       REPLACE('서울시 중구 남대문로 120 대일빌딩', '대일빌딩', '그레이츠 청계')
  FROM 
       DUAL;
       
SELECT
       EMP_NAME,
       EMAIL,
       REPLACE(EMAIL, 'kh.or.kr', 'iei.or.kr')
  FROM
       EMPLOYEE;
       
--------------------------------------------------------------------------------

/*

<숫자와 관련된 함수>
- ABS(NUMBER) : 절대값을 구해주는 함수

*/

SELECT
       ABS(-10)
  FROM
       DUAL;
       
--------------------------------------------------------------------------------

/*
MOD
 - MOD(NUMBER1, NUMBER2) : 두 수를 나눈 나머지값을 반환
 
 -- NUMBER타입은 숫자기만 하면 정수, 실수 구분 없다.
*/

SELECT
       MOD(10,3)
  FROM
       DUAL;
       
SELECT
       MOD(-10, 3)
  FROM
       DUAL;
       
SELECT
       MOD(10.8, 3)
  FROM
       DUAL;
       
SELECT
       10/3
  FROM DUAL; -- 오라클은 실수 연산도 잘 된다.버림도 안하고 실수로 나옴.
  
--------------------------------------------------------------------------------

/*
ROUND
 - ROUND(NUMBER, 몇번째자리반올림?) : 반올림 처리해주는 함수
 위치 : 소수점 아래 N번째 위치를 지정할 수 있음.
 생략시 기본값은 0
*/

SELECT
       ROUND(123.456)
  FROM
       DUAL;
       
SELECT
       ROUND(123.456, 1)
  FROM
       DUAL;
       
SELECT
       ROUND(123.456, 2)
  FROM 
       DUAL;
       
SELECT
       ROUND(123.456, -1)
  FROM
       DUAL; -- -1값을 넘겨주면 소수점 앞이라는 의미
       
--------------------------------------------------------------------------------

/*
CEIL
 - CEIL(NUMBER)
: 소수점 아래의 수를 무조건 올림 처리해주는 함수
*/

SELECT
       CEIL(123.456)
  FROM 
       DUAL;
       
/*
FLOOR
- FLOOR(NUMBER) 
: 소수점 아래의 수를 무조건 버림처리해주는 함수.
*/

SELECT
       FLOOR(123.456)
  FROM
       DUAL;
       
-- 각 직원별로 고용일부터 오늘까지의 근무 일수 조회 + 사원명
SELECT
       EMP_NAME,
       CONCAT(FLOOR(SYSDATE - HIRE_DATE), '일') AS "근무일자" -- 소수점아래는 시분초이므로 버림해서 나타낼 수 있다(앞에는 일)
  FROM 
       EMPLOYEE
 WHERE
       FLOOR(SYSDATE - HIRE_DATE) > 365 * 10;
       
-------------------------------

/*
TRUNC
-TRUNC(NUMBER, 위치) : 위치 지정가능한 절삭 처리 함수
위치에 2 적으면 소수점 아래 2까지 남기고 자른다는 소리
*/

SELECT
       TRUNC(123.456, -3)
  FROM
       DUAL;
       
--------------------------------------------------------------------------------

/*
< 날짜 관련 함수 > 
DATE 타입 : 년, 월, 일, 시, 분, 초를 모두 포함한 자료형
*/

-- SYSDATE : 현재 시스템 날짜 반환
SELECT
       SYSDATE
  FROM
       DUAL;

--- MONTHS__BETWEEN(DATE1, DATE2) : 두 날짜사이의 개월수 반환(NUMBER타입으로 반환, DATE2가 더 미래일 경우 음수가 나올 수 있음)

-- EMPLOYEE 테이블로부터 각 사원의 사원명, 고용일로부터 근무일수와 근무개월수 조회
SELECT
       EMP_NAME,
       TRUNC(SYSDATE - HIRE_DATE),
       FLOOR(MONTHS_BETWEEN(SYSDATE, HIRE_DATE)) || '개월' AS "개월수"
  FROM
       EMPLOYEE;
       
--ADD_MONTHS(DATE, NUMBER) : 특정 날짜에 해당 숫자만큼의 개월 수를 더한 날짜를 반환(DATE타입으로 반환)
-- 오늘날짜로부터 5개월 후
SELECT
       ADD_MONTHS(SYSDATE, 5)
  FROM
       DUAL;
       
-- 직원명, 입사일, 입사일로부터 3개월이 흘렀을 때 날짜 조회
SELECT
       EMP_NAME,
       HIRE_DATE,
       ADD_MONTHS(HIRE_DATE, 3)
  FROM
       EMPLOYEE;

-- NEXT_DAY(DATE, 요일) : 특정 날짜에서 가장 가까운 요일을 찾아 그 날짜를 반환
SELECT
       NEXT_DAY(SYSDATE, '금요일')
  FROM
       DUAL;
       
SELECT
       NEXT_DAY(SYSDATE, '금')
  FROM
       DUAL;

SELECT
       NEXT_DAY(SYSDATE, 6) -- 일요일부터 1  시작해서 6이라고 하면 금요일
  FROM
       DUAL;
       
SELECT
       NEXT_DAY(SYSDATE, 'FRIDAY') -- FRIDAY는 안됨. 처음 설치할 때 운영체제 언어를 따라가기 때문에 우리 운영체제가 한국어라서 지금 한국어로 설정이 된 것.
  FROM
       DUAL;
-- 언어변경을 할 필요가 있을 때가 있음
-- 언어변경
ALTER SESSION SET NLS_LANGUAGE = AMERICAN;

SELECT
       NEXT_DAY(SYSDATE, 'FRIDAY') -- 언어설정 바꾸면 FRI도 되고 FRIDAY 도 됨.
  FROM
       DUAL;

ALTER SESSION SET NLS_LANGUAGE = KOREAN;

-- LAST_DAY(DATE) : 날짜를 전달받아서 해당 날짜가 있는 달의 마지막 날짜를 구해서 반환(DATE타입)
SELECT
       LAST_DAY(SYSDATE)
  FROM
       DUAL;
       
--------------------------------------------------------------------------------

/*
EXTRACT : 년도 또는 월 또는 일 정보를 추출해서 반환(NUMBER타입)

- EXTRACT(YEAR FROM DATE) : 특정 날짜로부터 년도만 추출
- EXTRACT(MONTH FROM DATE) : 특정 날짜로부터 월만 추출
- EXTRACT(DAY FROM DATE) : 특정 날짜로부터 일만 추출
*/

-- EMPLOYEE테이블로부터 사원명, 입사년도, 입사월, 입사일 조회

SELECT
       EMP_NAME,
       EXTRACT(YEAR FROM HIRE_DATE) || '년' AS "입사년도",
       EXTRACT(MONTH FROM HIRE_DATE) || '월' AS "입사월",
       EXTRACT(DAY FROM HIRE_DATE) || '일' AS "입사일"
  FROM
       EMPLOYEE;

--------------------------------------------------------------------------------

/*
< 형변환 함수 >

NUMBER / DATE => CHARACTER

- TO_CHAR(NUMBER/ DATE, 포맷) : 숫자형 또는 날짜형 데이터를 문자형 데이터타입으로 반환

*/

SELECT
       TO_CHAR(1234)
  FROM
       DUAL; --> 1234나오는데 숫자가 아니고 문자타입인 것
       
       
SELECT
       TO_CHAR(1234, '000000')
  FROM 
       DUAL; --> 001234, LPAD이랑 비슷
-- : 자리수보다 큰 공간을 0으로 채움

SELECT
       TO_CHAR(1234,'999999')
  FROM
       DUAL; -->  999.. 하면 빈 자리수는 공백문자로 채워줌
       -->'  1234' 자리수보다 큰 공간을 공백문자로 채움

SELECT
       TO_CHAR(1234, 'L00000')
  FROM
       DUAL; -- ￦1234로 나옴. 현재 설정된 나라(LOCAL)의 화폐단위. 내 컴퓨터 운영체제가 한국어이므로 미국에 컴퓨터 가져가서 확인해도 원화로 나온다.
       
SELECT
       TO_CHAR(123124124, 'L999,999,999,999')
  FROM
       DUAL;
       
SELECT
       EMP_NAME,
       TO_CHAR(SALARY, '999,999,999') || '원'
  FROM
       EMPLOYEE;
       
--------------------------------------------------------------------------------

-- DATE(년월일시분초) => CHARACTER
SELECT
       TO_CHAR(SYSDATE)
  FROM
       DUAL; -- 그냥 날짜출력과 동일해보이지만 문자데이터(CHARACTER)타입이 된 것.
       
    
SELECT
       TO_CHAR(SYSDATE, 'YYYY-MM-DD')
  FROM
       DUAL; -- 2024-10-15
       
       
SELECT
        TO_CHAR(SYSDATE, 'PM HH:MI:SS') -- MONTH는 MM MINUTE는 MI
  FROM
       DUAL; -- PM은 오전/ 오후를 출력, 오전이면 오전, 오후면 오후로 나옴.
       
SELECT
       TO_CHAR(SYSDATE, 'HH24:MI:SS')
  FROM
       DUAL; -- 16:28:01 : HH24는 24시간형식
       
       
SELECT
       TO_CHAR(SYSDATE, 'MON DY, YYYY')
  FROM
       DUAL; -- 10월 화, 2024 : MON -월, DY 는 요일, 
       
--------------------------------------------------------------------------------

-- 연도로 쓸 수 있는 포맷
SELECT
       TO_CHAR(SYSDATE, 'YYYY'),
       TO_CHAR(SYSDATE, 'RRRR'), -- 둘 다 연도를 나타낸다 RR은 RR'은 *** 검색할것, 50 미만이면 2000년대 YY는 2000 후를 의미함. 요즘은 그냥 다 YYYY쓰면 됨.
       TO_CHAR(SYSDATE, 'YY'),
       TO_CHAR(SYSDATE, 'RR'),
       TO_CHAR(SYSDATE, 'YEAR') -- TWENTY TWENTY-FOUR
  FROM
       DUAL;

-- 월로 사용할 수 있는 포맷
SELECT
       TO_CHAR(SYSDATE, 'MM'), 
       TO_CHAR(SYSDATE, 'MON'), -- 뒤에 '월'도 같이 나옴
       TO_CHAR(SYSDATE, 'MONTH'), -- 얘도 뒤에 월 같이 나옴
       TO_CHAR(SYSDATE, 'RM') -- 로마숫자로 표현 X 나옴
  FROM
       DUAL;
       
-- 일로 사용할 수 있는 포맷
SELECT
       TO_CHAR(SYSDATE, 'DD'), -- 한달기준으로 1일부터 15일째
       TO_CHAR(SYSDATE, 'D') -- 3이라고 나옴 일주일기준으로 일요일부터 화요일이라 일월화 해서 3번째라는 뜻.
       TO_CHAR(SYSDATE, 'DDD'); -- 289, 1년 기준으로 1월1일부터 며칠째인지
  FROM
       DUAL;
       
-- 요일에 사용할 수 있는 포맷
SELECT
       TO_CHAR(SYSDATE, 'DAY'), -- 화요일
       TO_CHAR(SYSDATE, 'DY') -- 화 / A가 요일을 의미함
  FROM
       DUAL;
       
-- EMPLOYEE테이블에서 사원명, 입사일
SELECT
       EMP_NAME,
       TO_CHAR(HIRE_DATE, 'YYYY"년"-MM"월"-DD"일" (DY)') -- 한글을 사이에 넣고 싶으면 ""을 같이 넣어줘야한다.
  FROM
       EMPLOYEE;
    --> 한글 데이터의 경우 쌍따옴표로 묶어주어야만 사용 가능
    
--------------------------------------------------------------------------------
/*

NUMBER / CHARACTER => DATE
 - TO_DATE(NUMBER / CHARACTER, 포맷) : 숫자형 또는 문자형 데이터를 전달하면 날짜형으로 변환(DATE타입 반환)
*/

SELECT
       TO_DATE(20241015)
  FROM
       DUAL; -- 기본포맷인 YY/MM/DD 형태로 변환된다. 24/10/15
       
SELECT
       TO_DATE('20241015')
  FROM 
       DUAL;     -- 기본포맷인 YY/MM/DD로 변환이 된다
       
SELECT
       TO_DATE(000112)
  FROM
       DUAL; -- 2000년으로 바뀌지 않고 오류가 남. NUMBER TYPE이기 때문. 000이 앞에 있으므로 112라고 인식해서 오류가 남.
       
SELECT
       TO_DATE('000112')
  FROM
       DUAL;  -- ''를 붙여서 작은 따옴표로 묶어주어야만 오류가 나지 않음
       
SELECT
       TO_DATE('240607')
  FROM
       DUAL;
       
SELECT
       TO_DATE('980607', 'RRMMDD') -- RR을 사용하면 2098이 아니라 1998이라고 인식
  FROM
       DUAL;
    --> 두 자리 년도에 대해서 RR포맷을 적용할 경우 => 50 이상이면 이전 세기, 50미만이면 현재 세기를 의미한다.

--------------------------------------------------------------------------------

/*
CHARACTER => NUMBER
 - TO_NUMBER(CHARACTER, 포맷) : 문자형 데이터를 숫자형으로 변환(NUMBER타입으로 반환)
*/

SELECT
       TO_NUMBER('01234')
  FROM
       DUAL;
       
SELECT
       '123' + '234'
  FROM
       DUAL; -- 문자로 했는데 숫자로 계산해줌.
       --> 자동으로 NUMBER타입으로 변환해서 산술연산까지 진행
       
SELECT
       '44,000' + '52,000'
  FROM
       DUAL; -- 실행 안됨. 문자(,)가 포함되어 있기 때문에 자동형변환이 불가능
       
SELECT
       TO_NUMBER('44,000', '99,999') + TO_NUMBER('52,000', '99,999')
  FROM
       DUAL;
       
--------------------------------------------------------------------------------

/*

< NULL 처리 함수 >
NVL(컬럼명, 해당 컬럼값이 NULL일 경우 반환할 결과값)
NVL : NULL VALUE라는 뜻
--> 해당 컬럼에 값이 존재할 경우 컬럼값 그대로 반환, 해당 컬럼의 값이 NULL일 경우 두 번째 인자로 전달한 값이 결과값으로 반환됨

*/
       
-- EMPLOYEE테이블로부터 사원명, 보너스
SELECT
       EMP_NAME,
       BONUS,
       NVL(BONUS, 0) -- BONUS컬럼 값이 NULL이면 0을 반환
  FROM
       EMPLOYEE;

-- 보너스 포함 연봉 조회
SELECT
       EMP_NAME,
       SALARY * (1 + NVL(BONUS, 0)) * 12 AS 연봉 
  FROM
       EMPLOYEE;
       
-- EMPLOYEE테이블로부터 사원명, 부서코드 조회
SELECT
       EMP_NAME,
       NVL(DEPT_CODE, '부서 없음')
  FROM  
       EMPLOYEE;

-- NVL2(컬럼명, 결과값1, 결과값2)
-- 해당 컬럼에 값이 존재할 경우 결과값1을 반환
-- 해당 컬럼의 값이 NULL일 경우 결과값2를 반환

-- 사원명, 부서코드, 부서코드가존재하는 경우 '부서배치완료', NULL일 경우 '부서없음'으로 조회
SELECT
       EMP_NAME,
       DEPT_CODE,
       NVL2(DEPT_CODE, '부서배치완료', '부서없음')
  FROM
       EMPLOYEE;

-- NULLIF(비교대상1, 비교대상2)
-- 두 개의 값이 동일할 경우 NULL 반환
-- 두 개의 값이 동일하지 않을 경우 비교대상1을 반환

SELECT
       NULLIF('1', '1')
  FROM
       DUAL; -- 같으면 NULL
       
SELECT
       NULLIF('1', '2')
  FROM  
       DUAL; -- 안 같으면 1

--------------------------------------------------------------------------------

/*

 < 선택함수 >
 
 DECODE(비교대상(컬럼명/ 산술연산결과/ 함수식 / ...), 조건값1, 결과값1, 조건값2, 결과값2, 조건값3, 결과값3, .... , 디폴트결과값);
  - 자바에서 switch문 유사
 - 마지막 디폴트결과값은 생략 가능 
*/

-- EMPLOYEE테이블로부터 사원명, 성별(남/여)
SELECT
       EMP_NAME,
       DECODE(SUBSTR(EMP_NO, 8, 1), 1, '남', 2, '여') AS "성별"
  FROM
       EMPLOYEE;
        
        
-- 직원들의 급여 인상시켜서 조회
-- 직급코드가 'J7'인 사원들의 급여를 10%인상해서 조회
-- 직급코드가 'J6'인 사원들의 급여를 15%인상해서 조회
-- 직급코드가 'J5'인 사원들의 급여를 20%인상해서 조회
-- 그 외 직급코드 사원들의 급여는 5%인상해서 조회

SELECT
       EMP_NAME,
       SALARY,
       LPAD(JOB_CODE, 5),
       DECODE(JOB_CODE, 'J7', SALARY * 1.1, 'J6', SALARY * 1.15, 'J5', SALARY * 1.2, SALARY * 1.05) AS "인상된급여"
  FROM
       EMPLOYEE;
        
--------------------------------------------------------------------------------

/*

CASE WHEN THEN
- DECODE 선택함수와 비교했을 때 DECODE는 해당 조건검사 시 동등비교만을 수행
- CASE WHEN THEN구문으로 특정 조건 제시 시 내맘대로 조건식 기술 가능

--> 자바에서의 if - else if문 같은 느낌

[표현법]
CASE
    WHEN 조건식1 THEN 결과값1(참일 경우)
    WHEN 조건식2 THEN 결과값2
    ...
    ELSE 결과값 (위 조건에 모두 부합하지 못했을 때)
END 

*/
      -- 참고 DECODE  
SELECT        
       EMP_NAME,
       DECODE(SUBSTR(EMP_NO, 8, 1), 1, '남', 2, '여', '성별 선택 안함') AS "성별"
  FROM
       EMPLOYEE;
       
-- CASE WHEN THEN
SELECT
       EMP_NAME,
       CASE
        WHEN SUBSTR(EMP_NO, 8, 1) = '1' THEN '남'
        WHEN SUBSTR(EMP_NO, 8, 1) = '2' THEN '여'
        ELSE '성별선택안함'
       END
  FROM
       EMPLOYEE;
       
--------------------------------------------------------------------------------


-- 단일행함수와 그룹함수는 함께 사용할 수 없다. : 결과 행의 개수가 다르기 때문.
--------------------------------< 그룹 함수 >-------------------------------------
/*
N개의 값을 읽어서 1개의 결과를 반환(하나의 그룹별로 함수 실행결과 반환)
*/
-- 1. SUM(숫자타입) : 해당 컬럼값들의 총 합계를 반환해주는 함수

SELECT
       TO_CHAR(SUM(SALARY), 'L999,999,999')
  FROM
       EMPLOYEE;
       
-- 부서코드가 'D5'인 사원들의 총 급여합계
SELECT
       SUM(SALARY)
 FROM
       EMPLOYEE
 WHERE
       DEPT_CODE = 'D5';
       
       
--------------------------------------------------------------------------------

-- 2. AVG(숫자타입) : 해당 컬럼값들의 평균값을 구해서 반환
-- 전체 사원들의 급여
SELECT
       ROUND(AVG(SALARY)) -- 소수점 몇 번째 자리 반올림인지 안 쓰면 1번째에서 반올림해서 정수로.
  FROM
       EMPLOYEE;
       
--------------------------------------------------------------------------------

-- 3. MIN(ANY 타입) : 해당 컬럼값들 중 가장 작은 값 반환
SELECT
       MIN(SALARY) "가장 작은 급여값",
       MIN(EMP_NAME) "가장 빠른 이름",
       MIN(HIRE_DATE) "가장 빠른 입사일"
  FROM 
       EMPLOYEE;
    --> 다른 언어가 섞여있으면 영어우선/ 나머지 나라들끼리는 국가코드순위/ 
    

-- 4. MAX(ANY TYPE) : 해당 컬럼값들 중 가장 큰 값 반환
SELECT
       MAX(SALARY) "가장 높은 급여",
       MAX(EMP_NAME) "가장 느린 이름",
       MAX(HIRE_DATE) "가장 늦은 입사일"
  FROM
       EMPLOYEE;
       
       
-- 5. COUNT(*/ 컬럼명/ DISTINST 컬럼명) : 행 개수를 세서 반환
-- COUNT(*) : 조회결과에 해당하는 모든 행 개수를 다 세서 반환
-- COUNT(컬럼명) : 제시한 해당 컬럼값이 NULL이 아닌 행만 개수를 세서 반환
-- COUNT(DISTINCT 컬럼명) : 제시한 해당 컬럼값이 중복값이 존재할 경우 하나로만 세서 반환

-- 전체 사원수가 몇 명인지 조회
SELECT
       COUNT(*)
  FROM
       EMPLOYEE;
       
-- 사수가 존재하는 사원의 수
SELECT
       COUNT(MANAGER_ID)
  FROM
       EMPLOYEE; -- 자동으로 NULL이 아닌 행만 세서 알려줌
       
SELECT
       COUNT(*)
  FROM
       EMPLOYEE
 WHERE
       MANAGER_ID IS NOT NULL; -- 위에 것이 더 나은 이유. 생산성 향성(면접준비!)
       
-- 현재 사원들이 속해있는 부서 개수
SELECT COUNT(DISTINCT DEPT_CODE)
  FROM EMPLOYEE;
        
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
