/*
    < DML : DATA MANIPULATION LANGUAGE >
            ������ ���� ���
    INSERT / UPDATE / DELETE
    
    ���̺� ���ο� �����͸� ����(INSERT)�ϰų�,
    ���̺� �����ϴ� �����͸� ����(UPDATE)�ϰų�,
    ���̺� �����ϴ� �����͸� ����(DELETE)�ϴ� ����
*/
/*
    1. INSERT : ���̺� ���ο� ���� �߰����ִ� ����
    
    [ ǥ���� ]
    1) INSERT INTO ���̺�� VALUES (��, ��, ��, ��,...);
    => �ش� ���̺� ��� �÷��� �߰��ϰ��� �ϴ� ���� ���� �Է��ؼ� �� ���� INSERT�ϰ��� �� �� ���
    * �������� : ���� ������ �÷��� ������ �����ϰ� �ۼ��ؾ� �� ***(���̺� ���� �� ������ �� ����)
*/

SELECT * FROM EMPLOYEE;

INSERT
  INTO
       EMPLOYEE
VALUES
       (
       900,
       '���Ի��',
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
       ); -- �÷� ������ŭ �� �־��ָ� not enough values��� �� �� ������ too many values
       
SELECT
       *
  FROM
       EMPLOYEE;
       
/*
    2) INSERT INTO ���̺��(�÷���, �÷���, �÷���...) VALUES( ��, ��, ��); 
    ���� INSERT�ϰ� ���� �÷���� ����.
    => �ش� ���̺� Ư�� �÷��� �����ؼ� �� �÷��� ���� �߰��� �� ���
    INSERT�� ������ �� �� ������ �߰��� �Ǳ� ������ ���̺� �� �ڿ� �ۼ����� ���� �÷��� �⺻������ NULL���� ��
    
    ������ �� ) NOT NULL ���������� �޷��ִ� �÷��� �ݵ�� ���̺�� �ڿ� �÷����� ��� ���� INSERT���־����.
    ���� ���� : NOT NULL ���������� �ɷ������� DEFAULT(�⺻��)�� �����Ǿ� �ִ� ��� ���� ���� ���� ������ DEFAULT���� ��.
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
       '�����Ի��',
       '440404-0404044',
       'J5',
       'S1'
       );
       
SELECT * FROM EMPLOYEE;
--------------------------------------------------------------------------------
/*
    3. INSERT INTO ���̺�� (��������);
    => VALUES(��) �� �����ϴ� �� ��ſ� ���������� ��ȸ�� ������� ��°�� INSERT�ϴ� ����
*/

-- ���ο� ���̺� �ϳ� �����
CREATE TABLE EMP_01(
    EMP_NAME VARCHAR2(20), 
    DEPT_TITLE VARCHAR2(20)
);

SELECT * FROM EMP_01;

-- EMPLOYEE���̺� �����ϴ� ��� ����� �����, �μ����� INSERT
INSERT
  INTO
       EMP_01
       ( -- �������� ����
       SELECT
              EMP_NAME,
              DEPT_TITLE
         FROM
              EMPLOYEE,
              DEPARTMENT
        WHERE
               DEPT_CODE = DEPT_ID(+)
        ); -- 25�� �� ��(��) ���ԵǾ����ϴ�. INSERT�� ������ ���� ����
        
SELECT * FROM EMP_01;

--------------------------------------------------------------------------------
/*
    2. INSERT ALL
    �ϳ��� ���̺� �������� ���� ���� INSERT�ϰų�, ***
    �� �� �̻��� ���̺� ���� INSERT�� �����ؾ� �� �� ����ϴ� ����
*/

-- ���ο� ���̺� �����
-- ù ��° ���̺� : �޿��� 400���� �̻��� ������� �����, ���޸� ���ؼ� ������ ���̺�
CREATE TABLE EMP_JOB(
    EMP_NAME VARCHAR2(30),
    JOB_NAME VARCHAR2(20)
);
-- �� ��° ���̺�, �޿��� 400���� �̻��� ������� �����, �μ��� ���ؼ� ������ ���̺�
CREATE TABLE EMP_DEPT(
    EMP_NAME VARCHAR(30),
    DEPT_TITLE VARCHAR2(20)
);

SELECT * FROM EMP_JOB;
SELECT * FROM EMP_DEPT;

-- EMP_JOB���̺��� EMPLOYEE���̺��� �޿��� 400���� �̻��� ������� �����, ���޸� INSERT
-- EMP_DEPT���̺��� EMPLOYEE���̺��� �޿��� 400���� �̻��� ������� �����, �μ��� INSERT

/*
    2_1) INSERT ALL
            INTO ���̺��1 VALUES(�÷���, �÷���,..)
            INTO ���̺��2 VALUES(�÷���, �÷���,..)
            ��������;
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
       SALARY >= 4000000; -- 10�� �� ��(��) ���ԵǾ����ϴ�.
       
SELECT * FROM EMP_JOB; -- 5�� ��
SELECT * FROM EMP_DEPT; -- 5�� ��

-- �����, �Ի��� => 2010�⵵ ������ �Ի��� ���
CREATE TABLE EMP_OLD
    AS SELECT EMP_NAME, HIRE_DATE
         FROM EMPLOYEE
        WHERE 0 = 1;

-- �����, �Ի��� => 2010�⵵ ���Ŀ� �Ի��� ���
CREATE TABLE EMP_NEW
    AS SELECT EMP_NAME, HIRE_DATE
         FROM EMPLOYEE
        WHERE 0 = 1;
        
SELECT EMP_NAME, HIRE_DATE
  FROM EMPLOYEE 
 WHERE --HIRE_DATE < '2010/01/01'; -- 2010�� ���� �Ի��� 9��
       HIRE_DATE >= '2010/01/01'; -- 2010�� ���� �Ի��� 15��
       
/*
    2_1_2) INSERT ALL
           WHEN ����1 THEN
           INTO ���̺��1 VALUES(�÷���, �÷���)
           WHEN ����2 THEN
           INTO ���̺��2 VALUES(�÷���, �÷���)
           ��������
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
          INTO ���̺�� VALUES (��, ��, ��..)
          INTO ���̺�� VALUES (��, ��, ��,,)
          ...
        SELECT *
          FROM DUAL;
*/

INSERT
   ALL
  INTO EMP_OLD VALUES('����', SYSDATE)
  INTO EMP_OLD VALUES('ȣȣ', SYSDATE)
  INTO EMP_OLD VALUES('����', SYSDATE)
SELECT
       *
  FROM
       DUAL;
--------------------------------------------------------------------------------
/*
    3. UPDATE
    ���̺� ��ϵ� ������ �����͸� �����ϴ� ����
    
    [ ǥ���� ]
    UPDATE 
           ���̺��
       SET
           �÷��� = �ٲܰ�,
           �÷��� = �ٲܰ�,
           ...      => ���� ���� �÷� ���� ���ÿ� �ٲ� �� ����. ','�� �����ؾ� ��!!! AND �ƴ�!!!! AND �ƴ� !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
     WHERE
           ���ǽ�; => WHERE�� ��������
           
*/

-- ���̺� �ϳ� ����
CREATE TABLE DEPT_COPY
    AS SELECT * FROM DEPARTMENT;
    
SELECT * FROM DEPT_COPY;

-- DEPT_COPY ���̺��� �ؿܿ���3�� �μ����� �̷�����η� ����
UPDATE
       DEPT_COPY
   SET
       DEPT_TITLE = '�̷������'; -- ��������� �ϰ� �ϸ� 9�� �� ��(��) ������Ʈ�Ǿ����ϴ�.
-- ��ü ���� ��� DEPT_TITLE�÷��� ���� ���� �̷������ UPDATE

ROLLBACK;

UPDATE
       DEPT_COPY
   SET
       DEPT_TITLE = '�̷������'
 WHERE
       DEPT_TITLE = '�ؿܿ���3��'; -- 1 �� ��(��) ������Ʈ�Ǿ����ϴ�.
    
SELECT * FROM DEPT_COPY;

--------------------------------------------------------------------------------
-- ���̺� ����
CREATE TABLE EMP_SALARY
    AS SELECT EMP_NAME, SALARY, BONUS
         FROM EMPLOYEE;
         
-- EMP_SALARY ���̺��� ���Ի������� �޿��� 400�������� ����
UPDATE
       EMP_SALARY
   SET
       SALARY = 4000000
 WHERE
       EMP_NAME = '���Ի��';
       
SELECT * FROM EMP_SALARY;

-- ��ü ����� �޿��� ���� �޿����� 10%�λ��ϵ��� ����
UPDATE
       EMP_SALARY
   SET
       SALARY = SALARY * 1.1; -- 25�� �� ��(��) ������Ʈ�Ǿ����ϴ�. -- �� �˸��� ���� ??
       
-- ������ - > ��ǻ�� �ٷ�� ��� / ��ǻ�� -> ������ġ + ������ġ / Java, SQL -> �����ڰ� ��ǻ�͸� �ٷ�� ���� ���� ����
-- ���� �۾��ϴ� ��ǻ�� -> H/W�� ������ġ(CPU), ������ġ(RAM(�ֹ߼� �޸�, Java�۾��� RAM�޸𸮿� ������ �÷����� ����ϴ� ��,), SSD/HDD)
-- DBMS�� ��ġ�� ��ǻ�� = DB Server. 
-- Oracle ������ ������ �����ǰ� ����. ���μ��� ���·�
-- ����Ŭ DBMS�� ����ϴϱ� ����Ŭ�翡�� ���� ����Ŭ developer�� �۾�
-- �� �ǽø� DBserver�� �����, Ŭ���̾�Ʈ���α׷��� �ش��ϴ� SQLDeveloper�� �̿��ؼ� �� ��ǻ�Ϳ� �����ִ� ���μ����� ��û�� ������ ��. DBserver�� ��û ó�����ְ� ���� ����� ��ȯ���ְ� ����.
-- SQL�� SSD/ HDD�� �����͸� �÷����� ó�����ְ� ����

--------------------------------------------------------------------------------

/*
    * UPDATE ���� ���������� ���
    
    UPDATE
           ���̺��
       SET
           �÷��� = (��������)
     WHERE
           ����; => ��������
*/
       
SELECT * FROM EMP_SALARY;

-- �����Ի���� �޿��� ���Ի���� �޿���ŭ ���ʽ��� �����ϻ���� ���ʽ���ŭ���� ����

UPDATE 
       EMP_SALARY
   SET
       SALARY = (SELECT
                        SALARY
                   FROM 
                        EMP_SALARY
                  WHERE
                        EMP_NAME = '���Ի��'), -- �÷����� ���� ,�� �ϴ� �� ����
       BONUS =  (SELECT
                         BONUS
                    FROM
                         EMP_SALARY
                   WHERE
                         EMP_NAME = '������')
 WHERE
       EMP_NAME = '�����Ի��';
--------------------------------------------------------------------------------
-- UPDATE�ÿ��� �ٲٰ� ���� ���� �ش� �÷��� �������ǿ� ����Ǹ� �ȵ�!!
-- ������ ����� ����� 200������ ����
UPDATE
       EMPLOYEE
   SET
       EMP_ID = 200
 WHERE
       EMP_NAME = '������'; -- unique constraint// PRIMARY KEY �������� ����

UPDATE
       EMPLOYEE
   SET
       EMP_ID = NULL
 WHERE
       EMP_ID = 200; -- PRIMARY KEY �������� ����
       
COMMIT; -- ��� ������׵��� Ȯ������ ��ɾ�
--------------------------------------------------------------------------------

/*
    4. DELETE
    ���̺� ��ϵ� **��**�� �����ϴ� ����
    
    [ǥ����]
    DELETE
      FROM
           ���̺��
     WHERE
           ����; =>��������
*/

DELETE FROM EMPLOYEE; -- 25�� �� ��(��) �����Ǿ����ϴ�.
SELECT * FROM EMPLOYEE; -- ��� �� ������
ROLLBACK; -- �ѹ� �� ������ Ŀ�Խ������� ���ư�.

DELETE
  FROM
       EMPLOYEE
 WHERE
       --EMP_NAME = '���Ի��' OR EMP_NAME = '�����Ի��'
       --EMP_NAME IN ('���Ի��', '�����Ի��')
       EMP_NAME LIKE '%���';
       
COMMIT; -- �̰� �ϰ� ROLLBACK �ϸ� ����� ��. ���� ������ �߿��Ѱ� �ƴϰ� �����ߴ� ������ �߿�.

--------------------------------------------------------------------------------

/*
    * TRUNCATE : ���̺��� ��ü ���� ������ �� ����ϴ� ����(����)
                (�̷������δ�) DELETE���� ����ӵ��� ����
                ������ ���Ǻο� �Ұ�. ROLLBACK�� �Ұ�!!!
                
*/

SELECT * FROM EMP_SALARY;
DELETE FROM EMP_SALARY; -- 0.034
ROLLBACK;
TRUNCATE TABLE EMP_SALARY; -- 0.044 �ѹ����ε� ���ƿ��� ����
