/*
    < SEQUENCE ������ >
    �ڵ����� ��ȣ�� �߻������ִ� ������ �ϴ� ��ü
    �������� �ڵ����� ���������� �ϳ��� ��������
    
    �� ) ȸ����ȣ, �����ȣ, �Խñ۹�ȣ, �����ȣ, �ֹ���ȣ... PK�� ���� �÷��� �ʿ�. ���������� ���ڸ� ���� ����.
        -> �̷� ��� ä���� �� ���� ģ�� ( ä�� : ��ȣ�� �߻�)
        
    1. ������ ��ü ���� ����
    
    [ ǥ���� ]
    CREATE SEQUENCE ��������
    START WITH ���ۼ��� -> ó�� �߻���ų ���۰��� ������ �� �ִ� �ɼ� ( �����ϸ� 1���� �������)
    INCREMENT BY ������ -> ���� ������ų �� �� �� ������ų���� ������ �� �ִ� �ɼ� (�����ϸ� 1�� ����)
    MAXVALUE �ִ밪 -> �ִ밪 ����, ��������
    MINVALUE �ּҰ� -> �ּҰ� ����, ��������
    CYCLE/NOCYCLE -> MAXVALUE�� �Ǹ� MINVALUE���� ������ ��ȯ���� ����, ���� ����
    CACHE ����Ʈũ�� ����/ NOCACHE-> ĳ�ø޸� ���� ����, CACHE_SIZE �⺻���� 20BYTE, ��������
    
    * ���⼭ ���ϴ� CACHE : �̸� �߻��� ������ �����ؼ� ������ �Ѱ����� ���� ����
                          �� �� ȣ���Ҷ����� ���Ӱ� ��ȣ�� �����ϴ� �ͺ��ٴ� 
                          ĳ�ð����� �̸� ������ ������ ������ ���� ���� �ξ� �ӵ��� ������ ������ �ӵ����� ���鿡�� �̵��� ����.
                          ��, ������ ����� ���� ������ �� ������ ������ ������ ���ư��� ����.
    
*/

CREATE SEQUENCE SEQ_INCREATE_NUM; -- ���� �̷��� ���� ���

DROP SEQUENCE SEQ_INCREATE_NUM;

/*
    * ���λ�
    - ���̺�� : TB_
    - �� : VW_
    - ������ : SEQ_
    - Ʈ���� : TRG_
    
*/

SELECT * FROM EMPLOYEE;

CREATE SEQUENCE SEQ_EMPNO
 START WITH 223
 INCREMENT BY 5
 MAXVALUE 240
 NOCYCLE
 NOCACHE;
 
 /*
    2. ������ ��뱸��
    ��������.CURRVAL : ���� �������� ��(���������� ���������� �߻��� NEXTVAL ��)   -- CURRVAL - CURRENTVALUE��� ��
    ��������.NEXTVAL : ���������� ������Ű�� ������ �������� ��.
                      ���� ������������ INCREMENT BY����ŭ ������ ��
                      (��������.CURRVAL + INCREMENT BY ��)
                      
    ������ ���� �� ù NEXTVAL�� START WITH�� ������ ���۰����� �߻�
 */
 
 SELECT SEQ_EMPNO.CURRVAL FROM DUAL;
 -- NEXTVAL�� �� ���̶� �������� ������ CURRVAL�� ����� �� ����.
 -- CURRVAL�� �������� ���������� ����� NEXTVAL�� �����ؼ� �����ִ� �ӽ� ��.
 
SELECT SEQ_EMPNO.NEXTVAL FROM DUAL; -- 223 ó�� ���ప�� �ɼ����� ������ START WITH ���̴�. �����ص��� ������ 1�� �ȴ�.
SELECT SEQ_EMPNO.CURRVAL FROM DUAL; -- 223
SELECT SEQ_EMPNO.NEXTVAL FROM DUAL; -- 228, 233

SELECT * FROM USER_SEQUENCES;
-- LAST_NUMBER �÷� : ���� ��Ȳ���� NEXTVAL�� ������ ��� ���� ��. �� �� NEXTVAL �ϸ� �� �������� ���ư� �� �����Ƿ� ��� �� �� �� Ȯ���ϴ� ���� ����.
SELECT SEQ_EMPNO.NEXTVAL FROM DUAL; -- 238
SELECT SEQ_EMPNO.NEXTVAL FROM DUAL; -- ������ MAXVALUE(240)�� �ʰ��߱� ������ ���� �߻�. MAXVALUE�� �ʰ��ؼ� ����.

--------------------------------------------------------------------------------
/*
    3. ������ ����
    
    ALTER SEQUENCE ��������
    ��� �ɼ� ������ ����
    
    * START WITH�� ���� ��������. �̰� �ٲٰ� ������ �ش� ������ ���� �� �ٽ� �����ؾ���.

*/

ALTER SEQUENCE SEQ_EMPNO
      INCREMENT BY 10
      MAXVALUE 400;
      
SELECT SEQ_EMPNO.NEXTVAL FROM DUAL; 248, 258...288

--SEQUENCE ����
DROP SEQUENCE SEQ_EMPNO;
--------------------------------------------------------------------------------
DROP SEQUENCE SEQ_EID;
CREATE SEQUENCE SEQ_EID
START WITH 224;

-- ����� �߰� �� ������ ������ INSERT

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
       '�ؾ',
       '111111-1111111',
       'J2',
       'S1'
       ); -- ���� �߰��ϴ� ���
       
SELECT * FROM EMPLOYEE;

-- SQL ��
--------------------------------------------------------------------------------

/*
 Java /  ORACLE
 
 ���Ӽ�
 �����͸� ���� ���� �����͵��� ���������� ���ӵ��� �ʴ´�. ���α׷��� ����Ǿ� �޸𸮿��� ����� �����.
 �޸𸮿��� ����� ���� ���ֹ߼� �޸𸮿��ٰ� ������ �ؾ� ������� �ʴ´�.
 ��� ����?
 DB - ����Ŭ
 ����Ŭ�� �Ἥ ��������� �ϴµ�, �ڹٶ� ������ ����.
 ���� ��������ִ� ��� �̸��� JDBC
 
 ORACLE / My-SQL / MariaDB / MS-SQL... DBMS������ ������ �ڹٶ� ������ ����. ��׳����� ȸ�� �ٸ��� ������ ����.
 �ڹ����忡���� DB�� ������ �ʿ䰡 ����
 �׷��� �ڹٿ��� DB���� ����� �� �ֵ��� API�� ���������. ->  JDBC
 API - Math, String, StringTokenizer, Scanner, File ...... �����ڵ��� ���Ǹ� ���� �ڹٿ��� �����ϴ� Ŭ����. �����ڴ� �޼ҵ带 �ϳ��ϳ� ������ �ʾƵ� ����� �̿��� �� ����.
 JDBC : Java DataBase Connectivity => Interface
 �� Interface? �� DB���α׷����� �ϰ��� ������ �����Ͽ� �����ڵ��� ������ �������� �ʵ��� �������̽��� ����
 �������̽��� ������ �ִ� ���� �޼ҵ��� ����. �޼ҵ��� ��� ��ȯ�� �Ű����� ��. �������̽��� ����ϴ� Ŭ������ ���η����� �ٸ����� �޼ҵ� ������� �����ϰ� �����ϰ� �ȴ�.
 ������ ���Ǹ� ���� ��



*/

DELETE FROM EMPLOYEE WHERE EMP_NAME = '���';


SELECT * FROM EMPLOYEE;







