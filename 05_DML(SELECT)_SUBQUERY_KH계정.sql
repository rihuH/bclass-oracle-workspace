-- �����̶�?

-- ������ �Է�

-- ���Ϸ� ���� : ������ ���

-- ��û -> DB Server�� ��ȸ��û (SELECT������ �ϴ°�)

-- �׻� ���� �����͸� � ���α׷��� �̿��ؼ� � ������ �ϴ��� ??? ������ ��


/*
 < SUB QUERY �������� >
 
 �ϳ��� �ֵ� SQL(SELECT, INSERT, UPDATE, DELETE, CREATE, ...)�ȿ� ���Ե� �� �ϳ��� SELECT��
 MAIN SQL���� ���������� �ϴ� ������

*/

-- ���� �������� ����1
SELECT * FROM EMPLOYEE;
-- ���ε� ����� ���� �μ��� ������� ����� ��ȸ
-- 1) ���� ���ε� ����� �μ��ڵ� ��ȸ
SELECT
       DEPT_CODE
  FROM
       EMPLOYEE
 WHERE
       '���ε�' = EMP_NAME;

-- 2) �μ��ڵ尡 D9�� ������� ����� ��ȸ
SELECT
       EMP_NAME
  FROM
       EMPLOYEE
 WHERE  
       DEPT_CODE = 'D9';

-- ���� �� �ܰ踦 �ϳ��� ���������� ��ġ��
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
                           '���ε�' = EMP_NAME);
--------------------------------------------------------------------------------
-- ���� �������� ���� 2
-- ��ü ����� ��� �޿����� �� ���� �޿��� �ް� �ִ� ������� ���, �����, �����ڵ� ��ȸ
-- 1) ��ü ����� ��ձ޿� ���ϱ�
SELECT
       AVG(SALARY)
  FROM
       EMPLOYEE; -- �뷫 3295488��
       
--2) �޿��� 3295488�� �̻��� ������� ���, �����, �����ڵ� ��ȸ
SELECT
       EMP_ID,
       EMP_NAME,
       JOB_CODE
  FROM
       EMPLOYEE
 WHERE
       SALARY >= 3295488;
       
-- ���� �� �ܰ踦 �ϳ��� ������ ��ġ��
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
-- ������������ �� ���� ������� ���� ���� ���� �������� �ϳ��� �ۼ��ؼ� (����� �� �������� Ȯ���ϰ� *** �߿�)
-- �� ���� �ϳ��� �����ش�.
--------------------------------------------------------------------------------

/*
    ���������� ����
    ���������� ������ ������� �� �� �� ���̳Ŀ� ���� �з���
    
    - ������ [���Ͽ�] �������� : ���������� ������ ������� ������ 1���� ���
    - ������ [���Ͽ�] �������� : �������� ������ ������� ������( + ���Ͽ�)�� ��
    - [������] ���߿� �������� : �������� ������ ������� (������ + )������ �� ��
    - ������ ���߿� �������� : �������� ������ ������� ������ ������ �� ��
    
    -> ���������� ������ ����� �� �� �� ���̳Ŀ� ���� ��밡���� �����ڰ� �޶���
*/

/*
    1. ������ ��������(SINGLE ROW SUBQUERY)
    
    ���������� ��ȸ ������� �� 1�� �� ��
    
    �Ϲ� ������ ��밡��(=, !=, <=, >, ...)
*/

-- �� ������ ��� �޿����� �� ���� �޴� ������� �����, �����ڵ�, ��ȭ��ȣ ��ȸ
-- 1. ��� �޿� ���ϱ�
SELECT
       AVG(SALARY)
  FROM
       EMPLOYEE; 
       -- RESULT SET�� 1��. ������� 1���� ��.
       
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
               -- ���������� ������� 1���̱� ������ SALARY�� ��Һ� ������ �����ϴ� (������ ��������)
               
-- �����޿��� �޴� ����� ���, �����, �����ڵ�, �޿�, �Ի��� ��ȸ
-- 1. �����޿� ���ϱ�
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
                        
-- ������ ����� �޿����� �� ���� �޿��� �޴� ������� �����, �μ��� ��ȸ
SELECT
       SALARY
  FROM
       EMPLOYEE
 WHERE
       '������' = EMP_NAME;

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
                        '������' = EMP_NAME);
-- JOIN�� ����

-- ����� ����� ���� �μ��� ������� �����, ��ȭ��ȣ, ���޸� ��ȸ(��, ����� ����� ����)
SELECT
       DEPT_CODE
  FROM
       EMPLOYEE
 WHERE
       EMP_NAME = '�����';

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
                           EMP_NAME = '�����');
   AND
       EMP_NAME != '�����';
    
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
                           EMP_NAME = '�����')
   AND
       EMP_NAME != '�����'
 ORDER
    BY
       EMP_NAME;
-- SQL (Structured Query Language)

-- �μ����� �޿� �հ谡// ���� ū �μ���// �μ���, �μ��ڵ�, �޿��հ�
--1. �� �μ��� �޿��հ�
SELECT
       SUM(SALARY)
  FROM
       EMPLOYEE
 GROUP
    BY
       DEPT_CODE;
--2. �μ��� �޿��հ� �� ���� ū �޿���
SELECT
       MAX(SUM(SALARY))
  FROM
       EMPLOYEE
 GROUP
    BY
       DEPT_CODE;
-- 3. �μ��ڵ�, �޿��հ� ����  �μ����� JOIN
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
       DEPT_TITLE; -- GROUP BY ������ �׷����� �͸� SELECT ���� ����� �� �ְ�, �������� GROUP BY ���� �� �� �ִ�. �׷� DEPT_TITLE�� SELECT���� �� �� ����.
       -- ��� �׷캰�� �����°� �Ȱ��ƾ���
HAVING
       SUM(SALARY) = 1926000;
       
--4. ������� ������ �ϳ��� ��ġ��
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
    2. ���� �� ��������(MULTI ROW SUBQUERY)
    ���������� ��ȸ ������� ���� ���� �� 
    
    - IN (10, 20, 30, ..) : ���� ���� ����� �߿��� �� ���� ��ġ�ϴ� ���� �ִٸ�
    - NOT IN �ϳ��� ��ġ�ϴ� ���� ������
    
*/

-- �� �μ��� �ְ�޿��� �޴� ����� �̸�, �����ڵ�, �޿� ��ȸ
-- 1) �� �μ��� �ְ� �޿� ��ȸ
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

-- �̽�ö ��� �Ǵ� ������ ����� ���� �μ��� ������� �����, �ڵ�����ȣ ��ȸ
SELECT
       DEPT_CODE
  FROM
       EMPLOYEE
 WHERE
       EMP_NAME IN ('�̽�ö', '������');
       
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
                            EMP_NAME IN ('�̽�ö', '������'));

-- ��� < �븮 < ���� < ���� < ����
-- �븮 �����ε� �������޺��� �޿��� ���� �޴� �������� �����, ���޸�, �޿�

-- 1) ���� ������ �޿�
SELECT 
       SALARY
  FROM
       JOB J,
       EMPLOYEE E
 WHERE
       J.JOB_CODE = E.JOB_CODE
   AND
       JOB_NAME = '����'; -- 3200000, 2500000, 4760000
       
-- 2) ���� �޿����� ���� �޿��� �޴� �������� �����, ���޸�, �޿�
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
       JOB_NAME = '�븮';
/*
 X(�÷�) > ANY(��, ��, ��)
 X�� ���� ANY ��ȣ ���� �� �߿� �ϳ��� ũ�� ��
 -- > ANY(10, 20, 30) : ���� ���� ����� �߿��� "�ϳ���" Ŭ ���
                        ���� ��ȯ
                        --
                        ���� ���� ����� �� ANY ��ȣ �ȿ� �ִ� �� �� ���� ���� ������ Ŭ ���)
                        
    < ANY(10, 20, 30) : ���� ���� ����� �߿����� "�ϳ���" ���� ���
                        ==
                         ���� ���� ����� �� (ANY��ȣ �ȿ� �ִ� �� �� ���� ū ������ ���� ���)
*/

-- 3) ���� ������� �ϳ��� ���������� ��ġ��
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
                           JOB_NAME = '����') 
   AND
       JOB_NAME = '�븮';
       
-- ���������ӿ��� ��� ���� ������ �޿����� �� ���� �޴� ����
SELECT
       SALARY
  FROM
       EMPLOYEE
  JOIN
       JOB USING(JOB_CODE)
 WHERE
       JOB_NAME = '����';
       
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
                            JOB_NAME = '����')
   AND
       JOB_NAME = '����';
--------------------------------------------------------------------------------

/*
    3. ���߿� ��������
        ��ȸ ����� �� �������� ������ �÷��� ���� �������� ��
        
*/
-- ���Ѽ� ����� ���� �μ��ڵ�, ���� �����ڵ忡 �ش��ϴ� ������� �����, �μ��ڵ�, �����ڵ�, �Ի��� ��ȸ
SELECT 
       DEPT_CODE,
       JOB_CODE
  FROM
       EMPLOYEE
 WHERE
       EMP_NAME = '���Ѽ�'; -- D5/ J5
    
-- �����, �μ��ڵ�, �����ڵ�, �Ի��� ��ȸ �μ��ڵ尡 D5�̸鼭 �����ڵ尡 J5�� ���
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
-- ���� �������� �ϳ��� ���������� ��ġ��
SELECT
       EMP_NAME,
       DEPT_CODE,
       JOB_CODE,
       HIRE_DATE
  FROM
       EMPLOYEE
 WHERE 
       DEPT_CODE = (SELECT DEPT_CODE FROM EMPLOYEE WHERE EMP_NAME = '���Ѽ�')
   AND
       JOB_CODE = (SELECT JOB_CODE FROM EMPLOYEE WHERE EMP_NAME = '���Ѽ�');
-- �̰� ������ ���
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
                                       EMP_NAME = '���Ѽ�');
-- ������ ���߿� �������� ���
--------------------------------------------------------------------------------

/*
    4. ������ ���߿� ��������
    �������� ���� ����� ���� �� ���� �÷��� ���

*/

-- �� ���޺� �ּ� �޿��� �޴� ����� ��ȸ(�̸�, �����ڵ�, �޿�)
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
                                     JOB_CODE); -- IN ���. IN�� �����̶� �����
                            
--------------------------------------------------------------------------------

/*
    5. �ζ��� ��(INLINE-VIEW) ************ �߿�
    
    FROM ���� ���������� �ۼ��ϴ� �� (FROM���� ���������� ����� ���� �ζ��κ��� �Ѵ�)
    
    SELECT���� ������ (RESULT SET)�� ���̺� ��� ���
*/

-- ������ �ζ��� �� ����
-- ������� �̸�, ���ʽ����� ����
-- ���ʽ� ���� ������ 4000���� �̻��� ����� ��ȸ
SELECT
       EMP_NAME,
       SALARY * (1 + NVL(BONUS,0)) * 12 AS "���ʽ� ���� ����"
  FROM
       EMPLOYEE
 WHERE
       "���ʽ� ���� ����" > 40000000;
       -- ������������� WHERE���� ��Ī�� ����� �� ����
--> �ζ��� �並 ����غ��ô�.

SELECT
       "�����"
       "���ʽ� ���� ����"
  FROM 
       (SELECT
               EMP_NAME,
               SALARY * (1 + NVL(BONUS,0)) * 12 AS "���ʽ� ���� ����"
          FROM
               EMPLOYEE)
 WHERE
       "���ʽ� ���� ����" > 40000000;
       
--> �ζ��� �並 �ַ� ����ϴ� ��
--> TOP-N �м� : �����ͺ��̽� �� �ִ� ���� �� �ֻ��� N���� �ڷḦ ���� ���ؼ� ���!

-- �� ���� �� �޿��� ���� ���� ���� 5��

-- * ROWNUM : ����Ŭ���� �������ִ� �÷�, ��ȸ�� ������� 1������ ������ �ٿ���.
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
       SALARY DESC; -- ������������� ORDER BY ���� ���� ROWNUM���� �ڸ��� ��
       
-- ORDER BY���� �̿��ؼ� ���� ������ ���� �� ROWNUM�� �̿��ؼ� �ټ����� ��ȸ�ϱ�

SELECT
       EMP_NAME,
       SALARY
  FROM(SELECT -- ������ ���� RESULT SET�� FROM���� ���̺�� ��.
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
      -- PHONE, -- �̷��� ���� ��ȸ�� �� ����. ���� ����ϴ� ���� ���� ������ RESULT SET�� ����� ������ ��ȸ�ϴ� �Ŷ� EMP_NAME, SALARY�� ��ȸ�� �� ����.
       A.* -- FROM���� �ζ��κ信 ��Ī�� ���� �� ��Ī.*�� �ۼ��ϸ� �ش� �ζ��κ��� ��� �÷��� ��ȸ�� �� ����.
  FROM(SELECT 
              EMP_NAME,
              SALARY
         FROM
              EMPLOYEE
        ORDER
           BY
              SALARY DESC)A -- ���⵵ ��Ī�� ���� �� �ִ�.
 WHERE  
       ROWNUM <= 5;
       
-- ���� �ֱٿ� �Ի��� ��� 5���� ������ �Ի��� ��ȸ
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
               HIRE_DATE DESC) -- �ֱټ� ����
 WHERE
       ROWNUM < 6;

-- �� �μ��� ��� �޿��� ���� 3�� �μ��� �μ��ڵ�, ��ձ޿�(����ó��)�� ��ȸ�ϼ���.
SELECT
       DEPT_CODE,
       "��ձ޿�" -- FROM �ȿ� RESULT SET���� �÷��� ���� �����ؼ� ���� �÷��� �־ ���� ������� ������ �ȵǰ� ��Ī���� �ҷ���� �Ѵ�.
  FROM
       (SELECT
              DEPT_CODE,
              ROUND(AVG(SALARY)) "��ձ޿�"
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

-----�� ��

SELECT
       DEPT_CODE,
       "AVG(SALARY)" -- �ƴϸ� �������·� �ҷ���� �Ѵ�. �ƹ�ư �÷����� �ҷ���� �Ѵ� ����� ����
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
    6. ���� �ű�� �Լ�
    RANK() OVER(���ı���)
    DENSE_RANK() OVER(���ı���)
    
    ** ������ SELECT�������� �ۼ� ����
    
*/
-- ������� �޿��� ���� ������� ������ �Űܼ� �����, �޿�, ���� ��ȸ
SELECT
       EMP_NAME,
       SALARY,
       RANK() OVER(ORDER BY SALARY DESC) "����" -- SELECT�� �ȿ��� �����ϰ� ���� ������ �ۼ��Ѵ�.
  FROM
       EMPLOYEE;
-- RANK() OVER �ϸ� ���� 7�� 2���̸� �� ������ --> 9��/

SELECT
       EMP_NAME,
       SALARY,
       DENSE_RANK() OVER(ORDER BY SALARY DESC) "����"
  FROM
       EMPLOYEE;
-- DENSE_RANK() OVER �ϸ� ���� 7�� 2�� --> �� ���� 8��

SELECT
       EMP_NAME,
       SALARY,
       DENSE_RANK() OVER(ORDER BY SALARY DESC) "����"
  FROM
       EMPLOYEE
 WHERE
       DENSE_RANK() OVER(ORDER BY SALARY DESC) <= 5; -- WHERE������ WINDOW �Լ� ����� �Ұ���. ��ȸ�Ұ�
       -- �̷� ��Ȳ���� ����� �ζ��κ�

SELECT *
  FROM (SELECT
               EMP_NAME,
               SALARY,
               DENSE_RANK() OVER(ORDER BY SALARY DESC) "����"
          FROM
               EMPLOYEE)
 WHERE ���� <= 5;

SELECT
       (SELECT MAX(SALARY) FROM EMPLOYEE), -- SELECT���� ����ϴ� ���������� ��Į�� ����������� �Ѵ�. - Ư¡, �ݵ�� �����÷����� ��ȯ�ؾ���.
       EMP_NAME


