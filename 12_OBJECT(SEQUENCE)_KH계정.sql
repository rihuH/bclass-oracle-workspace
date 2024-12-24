/*
    < SEQUENCE 시퀀스 >
    자동으로 번호를 발생시켜주는 역할을 하는 객체
    정수값을 자동으로 순차적으로 하나씩 생성해줌
    
    예 ) 회원번호, 사원번호, 게시글번호, 예약번호, 주문번호... PK가 붙은 컬럼이 필요. 보편적으로 숫자를 쓰면 편함.
        -> 이런 경우 채번할 때 쓰는 친구 ( 채번 : 번호를 발생)
        
    1. 시퀀스 객체 생성 구문
    
    [ 표현법 ]
    CREATE SEQUENCE 시퀀스명
    START WITH 시작숫자 -> 처음 발생시킬 시작값을 지정할 수 있는 옵션 ( 생략하면 1부터 만들어짐)
    INCREMENT BY 증가값 -> 값을 증가시킬 때 몇 씩 증가시킬건지 지정할 수 있는 옵션 (생략하면 1씩 증가)
    MAXVALUE 최대값 -> 최대값 지정, 생략가능
    MINVALUE 최소값 -> 최소값 지정, 생략가능
    CYCLE/NOCYCLE -> MAXVALUE가 되면 MINVALUE부터 돌도록 순환여부 지정, 생략 가능
    CACHE 바이트크기 지정/ NOCACHE-> 캐시메모리 여부 지정, CACHE_SIZE 기본값은 20BYTE, 생략가능
    
    * 여기서 말하는 CACHE : 미리 발생할 값들을 생성해서 저장해 둘것인지 여부 지정
                          매 번 호출할때마다 새롭게 번호를 생성하는 것보다는 
                          캐시공간에 미리 생성된 값들을 가져다 쓰는 것이 훨씬 속도가 빠르기 때문에 속도적인 측면에서 이득이 있음.
                          단, 접속이 끊기고 나서 재접속 후 기존에 생성된 값들은 날아가고 없음.
    
*/

CREATE SEQUENCE SEQ_INCREATE_NUM; -- 보통 이렇게 적고 사용

DROP SEQUENCE SEQ_INCREATE_NUM;

/*
    * 접두사
    - 테이블명 : TB_
    - 뷰 : VW_
    - 시퀀스 : SEQ_
    - 트리거 : TRG_
    
*/

SELECT * FROM EMPLOYEE;

CREATE SEQUENCE SEQ_EMPNO
 START WITH 223
 INCREMENT BY 5
 MAXVALUE 240
 NOCYCLE
 NOCACHE;
 
 /*
    2. 시퀀스 사용구문
    시퀀스명.CURRVAL : 현재 시퀀스의 값(마지막으로 성공적으로 발생한 NEXTVAL 값)   -- CURRVAL - CURRENTVALUE라는 뜻
    시퀀스명.NEXTVAL : 시퀀스값을 증가시키고 증가된 시퀀스의 값.
                      기존 시퀀스값에서 INCREMENT BY값만큼 증가한 값
                      (시퀀스명.CURRVAL + INCREMENT BY 값)
                      
    시퀀스 생성 시 첫 NEXTVAL은 START WITH로 지정된 시작값으로 발생
 */
 
 SELECT SEQ_EMPNO.CURRVAL FROM DUAL;
 -- NEXTVAL을 한 번이라도 수행하지 않으면 CURRVAL을 사용할 수 없음.
 -- CURRVAL은 마지막에 성공적으로 수행된 NEXTVAL값 저장해서 보여주는 임시 값.
 
SELECT SEQ_EMPNO.NEXTVAL FROM DUAL; -- 223 처음 수행값은 옵션으로 지정한 START WITH 값이다. 지정해두지 않으면 1이 된다.
SELECT SEQ_EMPNO.CURRVAL FROM DUAL; -- 223
SELECT SEQ_EMPNO.NEXTVAL FROM DUAL; -- 228, 233

SELECT * FROM USER_SEQUENCES;
-- LAST_NUMBER 컬럼 : 현재 상황에서 NEXTVAL을 수행할 경우 나올 값. 한 번 NEXTVAL 하면 그 이전으로 돌아갈 수 없으므로 사용 전 한 번 확인하는 것이 좋다.
SELECT SEQ_EMPNO.NEXTVAL FROM DUAL; -- 238
SELECT SEQ_EMPNO.NEXTVAL FROM DUAL; -- 지정된 MAXVALUE(240)를 초과했기 때문에 오류 발생. MAXVALUE를 초과해서 오류.

--------------------------------------------------------------------------------
/*
    3. 시퀀스 변경
    
    ALTER SEQUENCE 시퀀스명
    모든 옵션 수정이 가능
    
    * START WITH만 빼고 수정가능. 이건 바꾸고 싶으면 해당 시퀀스 삭제 후 다시 생성해야함.

*/

ALTER SEQUENCE SEQ_EMPNO
      INCREMENT BY 10
      MAXVALUE 400;
      
SELECT SEQ_EMPNO.NEXTVAL FROM DUAL; 248, 258...288

--SEQUENCE 삭제
DROP SEQUENCE SEQ_EMPNO;
--------------------------------------------------------------------------------
DROP SEQUENCE SEQ_EID;
CREATE SEQUENCE SEQ_EID
START WITH 224;

-- 사원이 추가 될 때마다 실행할 INSERT

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
       /*223*/ SEQ_EID.NEXTVAL,
       '붕어빵',
       '111111-1111111',
       'J2',
       'S1'
       ); -- 원래 추가하는 방법
       
SELECT * FROM EMPLOYEE;

-- SQL 끝
--------------------------------------------------------------------------------

/*
 Java /  ORACLE
 
 영속성
 데이터를 만들어서 생긴 데이터들은 영구적으로 지속되지 않는다. 프로그램이 종료되어 메모리에서 지우면 사라짐.
 메모리에서 지우기 전에 비휘발성 메모리에다가 저장을 해야 사라지지 않는다.
 어디에 저장?
 DB - 오라클
 오라클을 써서 저장까지는 하는데, 자바랑 연관이 없음.
 둘을 연결시켜주는 기술 이름이 JDBC
 
 ORACLE / My-SQL / MariaDB / MS-SQL... DBMS종류가 많은데 자바랑 관련은 없음. 얘네끼리도 회사 다르고 연관이 없음.
 자바입장에서는 DB에 저장할 필요가 있음
 그래서 자바에서 DB들을 사용할 수 있도록 API를 만들어줬음. ->  JDBC
 API - Math, String, StringTokenizer, Scanner, File ...... 개발자들의 편의를 위해 자바에서 제공하는 클래스. 개발자는 메소드를 하나하나 만들지 않아도 기능을 이용할 수 있음.
 JDBC : Java DataBase Connectivity => Interface
 왜 Interface? 각 DB프로그램마다 일관된 사용법을 적용하여 개발자들이 여러번 공부하지 않도록 인터페이스로 제공
 인터페이스가 가지고 있는 것은 메소드의 모양뿐. 메소드의 기능 반환값 매개변수 등. 인터페이스를 사용하는 클래스는 내부로직은 다르더라도 메소드 사용방법을 동일하게 구현하게 된다.
 개발자 편의를 위한 것



*/

DELETE FROM EMPLOYEE WHERE EMP_NAME = '김김';


SELECT * FROM EMPLOYEE;







