---------------------- �ǽ� �ð� ----------------------------------

-- '�ѱ�'���� �ٹ��ϴ� ������� ���, �̸�, �μ���, ���޸�, �ٹ��������� ��ȸ�ϼ���!

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
       NATIONAL_NAME = '�ѱ�';
       
--------------------------------------------------------------------------------

/*
    < VIEW �� >
    
    SELECT(������)�� �����ص� �� �ִ� ��ü
    �ӽ����̺��� ���� (���� �����Ͱ� ����ִ� ���� �ƴ�!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!)
*/

/*
    1. VIEW ���� ���
    
    [ ǥ���� ] 
    CREATE VIEW ��� 
        AS ��������;
*/

CREATE OR REPLACE VIEW VW_EMPLOYEE -- VIEW��� �ǹ̷� VW�� �ٿ���
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
-- ���� KH ������ CREATE VIEW ������ ����
-- �����ڰ������� ���� �ο�
GRANT CREATE VIEW TO KH;

-- �ٽ� KH
-- ���� VIEW ������ �� �� ����. ���� VIEW�� SELECT�� �� �� �ִ�.
SELECT * FROM VW_EMPLOYEE;

-- �ѱ����� �ٹ��ϴ� ���
SELECT
       *
  FROM
       VW_EMPLOYEE
 WHERE
       NATIONAL_NAME = '�ѱ�';
       
-- �Ϻ����� �ٹ��ϴ� ���
SELECT
       *
  FROM
       VW_EMPLOYEE
 WHERE
       NATIONAL_NAME = '�Ϻ�';
       
-- ���� ���� : �� �������� �ʿ��Ҷ����� �׶��׶� �ۼ��ϸ� ����.
--             ���� ���� �������� �� �� ��� �����θ� �׶����� �並 �̿��ؼ� �����ϰ� ��ȸ�� �� ���� - �� ��� ����.
-- ��� ���� ����

-- �ش� ������ ������ �ִ� VIEW�鿡 ���� ������ ��ȸ�� �� �ִ� ������ ��ųʸ�
SELECT * FROM USER_VIEWS;
-- ��� �����͸� �����ϰ� �ִ°� �ƴϰ�, ����� ���� ���� �������� �ؽ�Ʈ ���·� ������ �ִ� ��.
-- �׸��� �װ� ������ ����� ��ȯ���ִ� ��
-- ��� ������ ������ ���̺� => ���������� �����͸� �����ϰ� ���� ����(�������� TEXT���·� �����س���)
--------------------------------------------------------------------------------
/*
    CREATE OR REPLACE VIEW ���
        AS ��������;
        
    �� ���� �� ������ �ߺ��� �̸��� �䰡 �������� �ʴ´ٸ� ���ο� �並 �������ְ�,
    ������ ������ �̸��� �䰡 �����Ѵٸ� ����(����)�ϴ� �ɼ�

*/

/*
    * �� ���� �� �÷��� ��Ī �ο�
    ���������� SELECT���� �Լ� �Ǵ� ���������� ����Ǿ� �ִ� ��� �ݵ�� ��Ī ����
*/

-- ����� �����, ����, �ٹ������ ��ȸ�� �� �ִ� SELECT���� ��� ����

CREATE OR REPLACE VIEW VW_EMP(�����, ����, �ٹ����)
    AS
SELECT
       EMP_NAME,
       SALARY * 12 AS "����",
       EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM HIRE_DATE) AS "�ٹ����"
  FROM
       EMPLOYEE;
-- must name this expression with a column alias
-- �÷��� ��Ī�� �������� �ʾƼ� ���� �߻�
-- ��Ī�� �����ָ� ��������

SELECT * FROM VW_EMP;

-- ��Ī�ο� ��� �� ��°!!
CREATE OR REPLACE VIEW VW_EMP(�����, ����, �ٹ����) -- �� ��� �÷��� ��Ī�� �ٿ������. ���ڰ� �����ϸ� ������ ����.
    AS
SELECT
       EMP_NAME,
       SALARY * 12,
       EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM HIRE_DATE) 
  FROM
       EMPLOYEE;
       
-- �並 �����ϰ� �ʹٸ�
DROP VIEW ���̸�;

--------------------------------------------------------------------------------
/*
    * ������ �並 �̿��ؼ� DML(INSERT, UPDATE, DELETE)�� ���డ��
    �並 ���� DML�� �����ص� ���� �����Ͱ� ����ִ� ���̺�(���̽����̺�)�� ����
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
       '����'
       );
       
SELECT * FROM JOB;

UPDATE VW_JOB
   SET JOB_NAME = '���Ի��'
 WHERE JOB_NAME = '����';
 
SELECT * FROM JOB;

DELETE FROM VW_JOB WHERE JOB_CODE = 'J8';
-- VIEW�� ������ DML�� ������ �� ����. �׷����� ���������� ����(���������� ��� �����ϴ°Ŵϱ�)
-- �׸��� ���������� ����. ���̺��� ��� �Ǿ��ִ��� ���� Ȯ���ؾ��ϴϱ�??
--------------------------------------------------------------------------------
-- �׸��� VIEW�� ������ DML�� �Ұ����� ��찡 ����
/*
    �並 ������ DML�� �Ұ����� ���
    1) �信 ���ǵǾ����� ���� �÷��� �����ϴ� ���
    2) �信 ���ǵǾ� �ִ� �÷��߿� ���̽����̺� �� NOT NULL ���������� ������ ���
    3) �������� �Ǵ� �Լ��� ���ؼ� ���ǵ� ���
    4) DISTINCT ������ ���Ե� ��� 
    5) JOIN�� �̿��ؼ� ���� ���̺��� ��Ī���ѳ��� ���
*/ 
-- �׷��� ��� ���̺��� �����ϴ� ���� ������� �ʴ´�.
--------------------------------------------------------------------------------
/*
        * VIEW ���� �� �ɼ�
        [��ǥ����]
        CREATE OR REPLACE FORCE/NOFORCE VIEW ���
            AS ��������
          WITH CHECK OPTION
          WITH READ ONLY;
          
          1) OR REPLACE : �ش� �䰡 �������� ���� ��� �並 ���� ���� / �ش� �䰡 �̹� �����Ѵٸ� ���Ž����ִ� �ɼ�
          2) FORCE / NOFORCE
            - FORCE : ���������� ����� ���̺��� �������� �ʾƵ� ������ �並 ����
            - NOFORCE(���� �� �⺻��) : ���������� ����� ���̺��� �ݵ�� �����ؾ߸� �並 ����
          3) WITH CHECK OPTION : ���������� �������� ����� ���뿡 �����ϴ� �����θ� DML�� ����
                                ���ǿ� �������� �ʴ� ������ INSERT/UPDATE�ϴ� ��� ���� �߻�
          4) WITH READ ONLY : �信 ���ؼ� ��ȸ�� ����(DML�� �ƿ� ����Ұ�)
*/

-- 2) FORCE / NOFORCE
CREATE OR REPLACE /*NO FORCE*/ VIEW VW_TEST
    AS SELECT TCODE
         FROM TT;
         
CREATE OR REPLACE FORCE VIEW VW_TEST
    AS SELECT TCODE
         FROM TT;
-- ���: ������ ������ �Բ� �䰡 �����Ǿ����ϴ�.

SELECT * FROM VW_TEST; -- ���� ������� ��δ� �ƹ��͵� ����. 

CREATE TABLE TT(
    TCODE NUMBER
);

SELECT * FROM VW_TEST; -- ������ ���� ���̺��� ������� �Ŀ��� �� �並 ����� �� �ִ�.

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
-- �������� WHERE���� ����� ���ǰ� �������� �ʱ� ������ DML�� ���� �Ұ���

UPDATE VW_EMP_SALARY
   SET SALARY = 10000000
 WHERE EMP_ID = 201;
 
 SELECT * FROM VW_EMP_SALARY;
 ROLLBACK;
--------------------------------------------------------------------------------
 -- 4) WITH READ ONLY
 -- RO : �̷��� ���������� READ ONLY
 
CREATE OR REPLACE VIEW VW_JOB_RO
   AS SELECT * FROM JOB
  WITH READ ONLY;
  
SELECT * FROM VW_JOB_RO; -- �д� ���� �������� ����

DELETE FROM VW_JOB_RO;
-- DML��ü�� ���� �Ұ�. �б⸸ ������.