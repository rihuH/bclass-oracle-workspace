/*
    < TCL : TRANSACTION CONTROL LANGUAGE >
            트랜잭션 제어 언어
            
    * TRANSACTION
    - 데이터베이스의 논리적 연산단위 (개발자가 스스로 판단하는)
    - 데이터의 변경사항(DML)들을 하나의 트랜잭션으로 묶어서 관리 -- 3개 중 하나를 쓰면 하나의 트랜잭션이 만들어짐
        COMMIT(확정)하기 전까지의 변경사항들을 하나의 트랜잭션에 담게됨
    - 트랜잭션의 대상이 되는 SQL : INSERT, UPDATE, DELETE  (DML)
    
    TRANSACTION의 4가지 속성
    ACID
    
    1. Atomicity(원자성) : 트랜잭션 내의 모든 작업이 수행되거나, 전혀 수행되지 않아야하는 원칙// 1 아니면 0
    2. Consistency(일관성) : 트랜잭션이 성공적으로 완료 된 후에도 데이터베이스는 유효한 상태를 유지해야 한다는 원칙
    3. Isolation(고립성) : 동시에 실행되는 여러 트랜잭션이 상호간에 영향을 끼치지 않도록 하는 원칙 // a의 트랜잭션이 b의 트랜잭션에 영향을 미치면 안됨
    4. Durability(지속성) : 트랜잭션이 성공적으로 수행되면, 시스템의 문제가 발생하더라도 영구적으로 저장되어야 하는 원칙
    
    COMMIT(트랜잭션을 종료 처리 후 확정), ROLLBACK(트랜잭션 취소), SAVAPOINT(임시저장점 잡기)

*/

SELECT * FROM EMPLOYEE_COPY WHERE EMP_ID = 222;

-- 사번이 222번인 사원 삭제
DELETE -- DELETE부터 TRANSACTION 생성. 아래로 계속 TRANSACTION 안에 들어감. DELETE/ 221삭제 DELETE... // SELECT는 조회만 하는 거라 TRANSACTION 에 영향을 끼치지 않는다.
  FROM 
       EMPLOYEE_COPY
 WHERE  
       EMP_ID = 222;
       
-- 사번이 221번인 사원삭제
DELETE
  FROM
       EMPLOYEE_COPY
 WHERE
       EMP_ID = 221;

SELECT * FROM EMPLOYEE_COPY;

ROLLBACK; -- ROLLBACK하면 트랜잭션이 사라진다. 그 트랜잭션 안에 있던 작업인 DELETE 222 DELETE 221 모두 삭제되고 그 이전의 상태로 돌아감.
--------------------------------------------------------------------------------

SELECT * FROM EMPLOYEE_COPY; -- 트랜잭션과는 아무 연관이 없음
-- 사번이 222번인 사원 삭제

DELETE FROM EMPLOYEE_COPY WHERE EMP_ID = 222; -- 트랜잭션 생성

UPDATE EMPLOYEE_COPY SET EMP_NAME = '흥흥흥' WHERE EMP_NAME = '홍길동'; -- DELETE 하면서 생성된 트랜잭션 안에 추가됨.

SELECT * FROM EMPLOYEE_COPY;

COMMIT; -- 현재 TRANSACTION에 올라가 있던 작업내용을 확정. TRANSACTION이 작업 파일로 SSD 등에 저장하고 사라짐
ROLLBACK; -- 그래서 이후 TRANSACTION을 없애는 DELETE를 해도 아무 변화가 없는 것.
--------------------------------------------------------------------------------

-- 사번이 217, 216, 214인 사원 삭제
DELETE -- TRANSACTION 만들어져서 DELETE 하나 올라감
  FROM
       EMPLOYEE_COPY
 WHERE
       EMP_ID IN (217, 216, 214);
-- 3개 행 이(가) 삭제된 시점에 SAVEPOINT 지정
SAVEPOINT DELETE3ROWS; -- 저장점 하나 생성// 이 이후에 작업한 내용만 ROLLBACK되어 사라짐. 그 이전의 작업들은 TRANSACTION에 남아있음.

-- 사원명이 흥흥흥인 사원의 이름을 홍길동으로 갱신
UPDATE -- DELETE가 올라가있는 TRANSACTION에 UPDATE도 올라감
       EMPLOYEE_COPY
   SET
       EMP_NAME = '홍길동'
 WHERE
       EMP_NAME = '흥흥흥';
       
ROLLBACK TO DELETE3ROWS; -- 세이브포인트로 ROLLBACK
       
SELECT * FROM EMPLOYEE_COPY;
ROLLBACK;
--------------------------------------------------------------------------------

COMMIT;
-- ** 주의사항
-- 사번이 218번인 사원 삭제
DELETE  
  FROM
       EMPLOYEE_COPY
 WHERE
       EMP_ID = 218;
       
SELECT * FROM EMPLOYEE_COPY;

CREATE TABLE HAHA(
    HID NUMBER
);
DROP TABLE HAHA;
ROLLBACK;

/*
    DDL구문(CREATE, ALTER, DROP)을 수행하는 순간
    기존에 트랜잭션에 있는 모든 작업사항들을 무조건 ***COMMIT***해서 실제 DB에 반영시킨 후에 DDL을 수행
    --> DDL수행전 트랜잭션이 만들어져있다면 COMMIT/ROLLBACK하고나서 DDL을 수행해야함
*/
