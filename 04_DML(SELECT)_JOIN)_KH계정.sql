-----> JOIN�� ���� ������� �ش��ϴ� �÷��� ��Ī��Ų�ٸ� ��ġ �ϳ��� �����ó�� ��ȸ

-- KH
-- ���� �����忡 � ���簡 �����ϴ°�

CREATE TABLE CLASS_ROOM(
    CLASS_ID VARCHAR2(5),
    LECTURE_NAME VARCHAR2(20)
);

INSERT INTO CLASS_ROOM VALUES('a', '�鵿��');
INSERT INTO CLASS_ROOM VALUES('b', '�̽�ö');
INSERT INTO CLASS_ROOM VALUES('c', 'ȫ�浿');
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

INSERT INTO STUDENT VALUES('a', '��浿');
INSERT INTO STUDENT VALUES('b', '��浿');
INSERT INTO STUDENT VALUES('b', '��浿');
COMMIT;

SELECT
       CLASS_ID,
       STUDENT_NAME
  FROM
       STUDENT;
       

SELECT
       DISTINCT STUDENT_NAME,   -- DISTINCT�� �ڿ� ���� �̹� JOIN�� ���̺��� �Ǿ�������Ƿ� DISTINCT�� �길 �� ���� ����.
        -- �ٵ� �� ���ٿ� ���ϱ� �� �� ����. �׷��� �������� �� �ȴٰ� ��..... �Ǵ°Ű�����......
       CLASS_ROOM.CLASS_ID, -- � ���̺� � �÷����� ��Ȯ�ϰ�. �� �׷��� AMBIGUOSLY �ϴٰ� ���� ����.
       STUDENT.CLASS_ID,
       LECTURE_NAME
  FROM
       CLASS_ROOM, STUDENT 
 WHERE
       CLASS_ROOM.CLASS_ID = STUDENT.CLASS_ID;
       -- 1 ���� ��ȸ�ϰ� ���� ���̺� FROM�� ��� ����
    -- �׷��� �� ���̺��� �� ���� ��� ���ؼ� ���� �� 9�� ���� ����
       -- ���ϴ� �� ��� ���� ������ ( ������ �������� �ʴ� ���� �����ϰ� ��ȸ�ϰ� ��)
       
/*
< JOIN >
�� �� �̻��� ���̺��� �����͸� �Բ� ��ȸ�ϰ��� �� �� ����ϴ� ����
��ȸ����� �ϳ��� �����(RESULT SET)�� ����

������ �����ͺ��̽������� �ּ��� �����ͷ� ������ ���̺� �����͸� �����ϰ� ����(�ߺ��� �ּ�ȭ �ϱ� ���ؼ�)
-> JOIN ������ ����ؼ� ���� ���� ���̺� �� "����"�� �ξ ���� ��ȸ �ؾ���
-> ������ JOIN�ؼ� �����ϴ� ���� �ƴϰ�, ���̺� �� "�����"�� �ش��ϴ� �÷��� ��Ī���Ѽ� ��ȸ�ؾ� ��.

JOIN�� ũ�� "����Ŭ ���뱸��"�� "ANSI(�̱�����ǥ����ȸ)����"�� ������.
����Ŭ���뱸���� ����Ŭ������, ANSI�� �ٸ� �������� ����� �� �ִ�.

====================================================
   ����Ŭ ���� ���� | ANSI(����Ŭ + �ٸ� DBMS) ����
==================================================
�����            | ��������
(EQUAL JOIN)        | (INNER JOIN)
----------------------------------------------------
��������            | 
(LEFT OUTER)        | ���� �ܺ�����(LEFT OUTER JOIN)
(RIGHT OUTER)       | ������ �ܺ�����(RIGHT OUTER JOIN)
                    | ��ü �ܺ�����(FULL OUTER JOIN) => ��� ����Ŭ���������� �Ұ���. ANSI�� ����Ŭ���� �� ���߿� ��������� ���ο�� �߰���.
------------------------------------------------------------------------------------------------------------------------------
ī�׽þ� ��          | ��������
(CARTESIAN PRODUCT) | (CROSS JOIN)
-------------------------------------------------------
��ü����(SELF JOIN)
������(NON EQUAL JOIN)

=========================================================

*/
    


/*

1. �����(EQUAL JOIN) / ��������(INNER JOIN)

JOIN�� �����Ű�� �÷��� ���� ��ġ�ϴ� ��鸸 ���εż� ��ȸ(== ��ġ���� �ʴ� ������ ��ȸ���� ����)

*/

--> ����Ŭ ���뱸�� �����
--> SELECT ������ ��ȸ�ϰ� ���� �÷����� ���� ��� (�� ��ȭ ����)
--> FROM - ��ȸ�ϰ��� �ϴ� ���̺���� , �� �̿��ؼ� ���� �� ����
--> WHERE ������ ��Ī�� ��Ű���� �ϴ� �÷���(�����)�� ���� ������ ������

-- ��ü ������� �����, �μ��ڵ�, �μ����� ���� ��ȸ

-- CASE 1 : ������ �� Į���� �÷����� �ٸ� ��� (DEPT_CODE/ DEPT_ID)

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
-- ��ġ���� �ʴ� ���� ��ȸ���� ���ܵ� ���� Ȯ�� ����
-- DEPT_CODE�� NULL�� ��� 2���� �����Ͱ� ��ȸ���� �ʴ´�. + DEPT_ID�� D3, D4, D7�� �μ������Ͱ� ��ȸ���� ����(EMPLOYEE ���̺� ��� ��� ��ġ�ϴ� ����� ���� �Ǿ)

-- ��ü ������� �����, �����ڵ�, ���޸�
-- EMPLOYEE -> EMP_NAME, JOB_CODE
-- JOB      -> JOB_NAME, JOB_CODE
SELECT
       JOB_CODE,
       JOB_NAME
  FROM
       JOB;
    
-- CASE 2 ������ �� �÷��� �̸��� ���� ���(JOB_CODE)

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
-- �����߻� : COLUMN AMBIGUOUSLY DEFINED => Ȯ���ϰ� � ���̺��� �÷����� ��ø� �������
-- � JOB_CODE����

-- ��� 1. ���̺���� ����ϴ� ���
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
       -- ���̺��� �÷����� �ٸ��� �׳� �ᵵ ��. �򰥸��� �����ϱ�. �׷��� �Ȱ����� ���̺������ ��Ȯ�� �������.
-- ��� 2. ��Ī ���(�� ���̺��� ��Ī �ο� ����)
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
       
--> ANSI����
-- FROM���� ���� ���̺��� �ϳ� ����� �� 
-- �� �� JOIN���� ���� ��ȸ�ϰ��� �ϴ� ���̺��� ���(��Ī��ų �÷��� ���� ���ǵ� ���)
-- USING / ON ����

-- EMP_NAME, DEPT_CODE, DEPT_TITLE
-- �����, �μ��ڵ�, �μ���
-- ������ �� �÷����� �ٸ� ���(EMPLOYEE - DEPT_CODE / DEPARTMENT - DEPT_ID) => ON�̶�� ����
-- ������ ON������ ��밡��(USING������ ��� �Ұ���!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!)
SELECT
       EMP_NAME,
       DEPT_CODE,
       DEPT_TITLE
  FROM
       EMPLOYEE -- ���� ���̺� ���´�
-- INNER -- �� Ű���带 �� ���� �⺻���� INNER JOIN�̶�� ��. �׷��� �ٵ� �� ����.
  JOIN
       DEPARTMENT ON (DEPT_CODE = DEPT_ID); -- �����ϰ���� ���̺��
       
       
-- EMPLOYEE, JOB_CODE, JOB_NAME
-- �����, �����ڵ�, ���޸�
-- ������ �� �÷����� ���� ���(JOB_CODE)
-- ON���� �̿� ) AMBIGUOUSLY�� �߻��� �� �ֱ� ������ ��Ȯ�ϰ� � ���̺��� �÷����� �ۼ����־�� ��.
--����� JOIN�� ���� ���� �� �ƴϰ� FROM �� ���ԵǾ� �ִ� ��. ��������� FROM�� ����.
SELECT
       EMP_NAME,
       E.JOB_CODE,
       JOB_NAME
  FROM
       EMPLOYEE E
  JOIN
       JOB J ON (E.JOB_CODE = J.JOB_CODE);
       
-- USING ���� �̿� ) ����� ������ �÷����� ������ ��� ����� �����ϸ� �񱳿����� �ƴ� USING������ �÷��� ������ �˾Ƽ� ��Ī������
SELECT
       EMP_NAME,
       JOB_CODE,
       JOB_NAME
  FROM
       EMPLOYEE
  JOIN
       JOB USING (JOB_CODE); -- USING�� ��Ī�� �� ��� �ȴ�. ����� ������ �� �÷����� �Ȱ��� ���
       
-- [ ������� ] ���� USING������ ���ô� NATURAL JOIN(�ڿ�����)���ε� ����
 SELECT
        EMP_NAME,
        JOB_CODE,
        JOB_NAME
   FROM  
        EMPLOYEE
NATURAL
   JOIN
        JOB;
-- �׷����� ������ ���� ����. 
-- ���������� ����.
-- �� ���� ���̺��� �����ϴµ� �� ���Ե� �� ���̺� ��ġ�ϴ� �÷��� �����ϰ� �� 1�� ������ ���� �˾Ƽ� ��Ī�ؼ� ��ȸ
-- ���̺��� ���� �ٲ�� ���ε� �ٲ�� NATURAL JOIN�� ������ ũ�� ����.

-- ����� ���޸��� ��ȸ ������ �븮�� ����鸸 ��ȸ
--> ORACLE ����

SELECT
       EMP_NAME,
       J.JOB_NAME
  FROM
       EMPLOYEE E,
       JOB J 
 WHERE
       E.JOB_CODE = J.JOB_CODE
   AND
       JOB_NAME = '�븮';

--> ANSI ����
SELECT
       EMP_NAME,
       JOB_NAME
  FROM
       EMPLOYEE
  JOIN
       JOB USING (JOB_CODE)
 WHERE
       JOB_NAME = '�븮';
       
-- EQUAL JOIN / INNER JOIN : ��ġ���� �ʴ� ���� ���ʿ� ResultSet�� ���Ե��� ����.
--------------------------------------------------------------------------------

/*
 2. �������� / �ܺ����� (OUTER JOIN)
 
 ���̺��� JOIN�� ��ġ���� �ʴ� �൵ ���Խ��Ѽ� ��ȸ ����
 ��, �ݵ�� LEFT/ RIGHT�� �����ؾ��ϰ�, ���� ���̺��� �����ؾ���!
*/

-- "��ü" ������� �����, �μ��� ��ȸ
-- INNER JOIN
SELECT
       EMP_NAME,
       DEPT_TITLE
  FROM
       EMPLOYEE
  JOIN
       DEPARTMENT ON(DEPT_CODE = DEPT_ID);
-- EMPLOYEE���̺��� DEPT_CODE �� NULL�� �� ���� ����� ��ȸX
-- DEPARTMENT ���̺��� �μ��� ������ ����� ���� �μ�(D3, D4, D7)���� ��� ��ȸX

-- 1) LEFT [OUTER] JOIN : �� ���̺� �� ���� ����� ���̺��� �������� JOIN
--      ���ǰ� ������� ���� ����� ���̺��� �����ʹ� ������ ��ȸ(��ġ�ϴ� ���� ã�� ���ϴ��� ��ȸ)
-- (OUTER JOIN) �������� �� ����(�������� ���̸� ����) �� �ִ� ���̺��� �������̺�
--> ANSI
SELECT
       EMP_NAME,
       DEPT_TITLE
  FROM
       EMPLOYEE
  LEFT
-- OUTER LEFT JOIN�� �⺻���� OUTER
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
       DEPT_CODE = DEPT_ID(+); -- �������� ���� ���̺�(EMPLOYEE)�� �÷�(DEPT_CODE) ���� �� �ݴ��� �÷��� (+)�� ���̸� ��������
-- ���� �������� ���� ���̺��� �÷����� �ƴ� �ݴ� ���̺� �÷��� (+)�� �ٿ���!


-- 2) RIGHT [OUTER] JOIN : �� ���̺� �� ������ ����� ���̺��� �������� JOIN
--      ��ġ�ϴ� �÷����� �������� �ʴ��� ������ ����� ���̺��� �����ʹ� ������ ��ȸ

--> ANSI
SELECT
       EMP_NAME,
       DEPT_TITLE
  FROM
       EMPLOYEE
 RIGHT
  JOIN
       DEPARTMENT ON (DEPT_CODE = DEPT_ID); -- ���� �������� DEPARTMENT�� ����. �ƹ��� ������ ���� �μ��� ��µ�.
       
--> ORACLE
SELECT
       EMP_NAME,
       DEPT_TITLE
  FROM
       EMPLOYEE,
       DEPARTMENT
 WHERE  
       DEPT_CODE(+) = DEPT_ID;

-- 3) FULL [OUTER] JOIN : �� ���̺��� ���� ��� ���� ��ȸ�� �� �ֵ��� ����
SELECT
       EMP_NAME,
       DEPT_TITLE
  FROM
       EMPLOYEE
  FULL
 OUTER
  JOIN
       DEPARTMENT ON (DEPT_CODE = DEPT_ID); -- ���� ��ġ���� �ʴ� �����͵� �� ��ȸ.
-- ORACLE�� �� ��. �� �ʿ� (+) (+) �̷��� �ٿ��� �ȵ�. (ONLY ONE OUTER-JOINED TABLE)

--------------------------------------------------------------------------------

--3. ī�׽þ� ��(CARTESIAN PRODUCT) / ��������(CROSS JOIN)
-- ��� ���̺��� �� ����� ���μ��� ���ε� �����Ͱ� ��ȸ��(������)
-- �� ���̺��� ����� ������ ���� ��� => �����Ͱ� ���� ���� ����� ������ ��� => ����ȭ�� ���� => ��� �ϸ� �ȵ� => ���� �ȵ�***


-- ����� �μ���
--> ORACLE
SELECT
       EMP_NAME,
       DEPT_TITLE
  FROM
       EMPLOYEE,
       DEPARTMENT; -- WHERE �� �ϰ� �׳� 23 * 9 207�� ������ �� ī�׽þ� ��
       
--> ANSI
SELECT
       EMP_NAME,
       DEPT_TITLE
  FROM
       EMPLOYEE
 CROSS
  JOIN
       DEPARTMENT; --ũ�ν�����.
 
--------------------------------------------------------------------------------

/*
4. �� ����(NON EQUAL JOIN) -- ���� �� �׳� =�� ������� �ʴ´ٴ¶�. �����Ͱ� �ٸ� ���� ��ȸ�Ѵٴ� �ǹ̰� �ƴ�.

�÷����� ���ϴ� ��찡 �ƴ϶� "����"�� ���ԵǴ� ��� ��Ī

EX) Side Effect -- ���ۿ�.  '��'�� �ƴҺΰ� �ƴϰ� �������̴� �� ���� '��'. '��/ ��'
�Լ������� ���� �� �Լ��� �ؾ� �� ��� ���� �ϰ� �ִ� �μ����� �۾���. ���� �� Setter���� this.num = num; ���� num++�� ���شٰų� �ϸ� �̰� ���ۿ��� ��.
�޼ҵ�� �� ��ɸ� �ؾ��ϹǷ� ���ۿ��� �ִ��� ���־� ��.

*/

-- EMPLOYEE���̺�κ��� �����, �޿� 

SELECT
       EMP_NAME,
       SALARY
  FROM
       EMPLOYEE;

SELECT *
  FROM
       SAL_GRADE;
       
-- EMPLOYEE --> �����(EMP_NAME), �޿�(SALARY)
-- SAL_GRADE --> �޿����(SAL_LEVER)

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
5. ��ü����(SELF JOIN)
���� ���̺��� �ٽ� �� �� �����ϴ� ���
��, �ڱ��ڽ��� ���̺�� ������ �δ� ���
*/

SELECT
       EMP_ID AS "��� ��ȣ",
       EMP_NAME AS "��� �̸�",
       PHONE AS "��ȭ��ȣ",
       MANAGER_ID AS "��� ���"
       -- ��� ��ȭ��ȣ �ʿ��ѵ�?? -- �̰͵� �� ���̺� �־ �����ؾ��� ���
  FROM
       EMPLOYEE;

--> ORACLE
-- ������, �����, ����ڵ�����ȣ, �����ȣ
-- ������, �����, ����ڵ�����ȣ
SELECT
       E.EMP_ID, E.EMP_NAME, E.PHONE, E.MANAGER_ID, -- ���⼱ ��Ī�� ���� ���ۿ� ����. EMPLOYEE�� �Ȱ����Ƿ� ���̺���� �״�� ���� �����δ� �Ǻ��� ���� ���� �����̴�.
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
<���� JOIN>


*/
-- ����� + �μ��� + ���޸� + ������(LOCAL_NAME)
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
  LEFT -- ������ �Ǵ� �� NULL���� ��� ���̺�� ������ JOIN�� ��� �ٿ���� �Ѵ�. �ϳ��� ������ ������ �������� ���´�.
  JOIN
       LOCATION ON (LOCATION_ID = LOCAL_CODE);
    -- ���� ������ �����ؾ� ��.
    -- FROM JOIN JOIN �ϸ� ���ʷ� ���̺� ����� �װŶ� ������ �����ϰ� �װŶ� ������ ������. �׷��� LEFT�� �ϳ��� �� ���̸� ������ ������� ��.
    -- ������ ���ϸ� ������ �� �Ǿ ���ε��� ����.
    
--> ORACLE ����
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
       E.JOB_CODE = J.JOB_CODE; -- ���⵵, DEPT_ ���� NULL �� �� ������ EMPLOYEE�� �� ������ ���̴ϱ�, DEPT�� ������ �Ϳ��� +�� �ٿ��� ���̴�.

--------------------------------------------------------------------------------

/*
<���� ������ SET OPERATOR>
���� ���� �������� ������ �ϳ��� ���������� ����� ������

- UNION ; ������(�� �������� ���� ������� ���� �� �ߺ��Ǵ� �κ��� ������ ��) OR
- INTERSECT : ������(�� �������� ���� ����� �� �ߺ��� ����κ�) AND
- MINUS : ������ (���������� ����� ���� ���������� ������� ���) AND NOT

- UNION ALL : �������� ����� �������� ���� ����
(�� �������� ������ ������� ������ ����. DB�� �ߺ����� ���ִ� �� ����ȭ�Ǿ� �ִµ� �ߺ��� ������ �ʰų�, ������ ��
�����տ��� �ߺ����Ÿ� ���� �ʴ� ��
=> �ߺ��� ���� ���� �� ��ȸ�� �� ����)
*/

-- 1. UNION (������)
-- �μ��ڵ尡 D5 �Ǵ� �޿��� 300���� �ʰ��� ����� ��ȸ(�����, �μ��ڵ�, �޿�)

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
       
-- UNION ���!
SELECT -- ����1 ��ȸ�Ѱ�
       EMP_NAME,
       DEPT_CODE,
       SALARY
  FROM
       EMPLOYEE
 WHERE
       DEPT_CODE = 'D5'
 UNION
SELECT -- ����2 ��ȸ�Ѱ�
       EMP_NAME,
       DEPT_CODE,
       SALARY
  FROM
       EMPLOYEE
 WHERE
       SALARY > 3000000; 
-- ���ǻ��� -- UNION ���� SELECT���� ���ƾ� ��.
-- ���� ���� ��� ���ǽ��� WHERE DEPT_CODE = 'D5' OR SALARY > 3000000�� �ϸ� �Ǵµ�
-- UNION �� ����?

-- �μ��ڵ尡 D1, D2, D3�� �μ��� �޿��հ�
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
-- �ϸ� �Ǵµ� UNION �� ?
-- �������� ���� ��µ� ���򿡴� �� �� ��. OR�� ���� �� ��ü�� �� �־.

--------------------------------------------------------------------------------
-- 2. UNION ALL
-- ��ü�� ����� ���� ���� �Լ�
SELECT -- ����1 ��ȸ�Ѱ�
       EMP_NAME,
       DEPT_CODE,
       SALARY
  FROM
       EMPLOYEE
 WHERE
       DEPT_CODE = 'D5'
 UNION
   ALL
SELECT -- ����2 ��ȸ�Ѱ�
       EMP_NAME,
       DEPT_CODE,
       SALARY
  FROM
       EMPLOYEE
 WHERE
       SALARY > 3000000; 
-- �ߺ����Ÿ� �� �ϰ� ��� �������, UNION�� �ߺ� ���� �����µ�, ��� ��� �������. �׷��� ���ǿ� 2�� �� �����ϴ� �̸��� 2�� ��µ�.
 -------------------------------------------------------------------------------      
 -- 3. INTERSECT (������ - ���� ���� ����� �ߺ��� ������� ��ȸ)
    SELECT -- ����1 ��ȸ�Ѱ�
          EMP_NAME,
          DEPT_CODE,
          SALARY
     FROM
          EMPLOYEE
    WHERE
          DEPT_CODE = 'D5'
INTERSECT
   SELECT -- ����2 ��ȸ�Ѱ�
          EMP_NAME,
          DEPT_CODE,
          SALARY
     FROM
          EMPLOYEE
    WHERE
          SALARY > 3000000; 
-- WHERE DEPT_CODE > 'D5' AND SALARY > 3000000�� ��ü�� �� ����.
--------------------------------------------------------------------------------

--4. MINUS(������  : ��������������� ������������� �� ������)
SELECT -- ����1 ��ȸ�Ѱ�
       EMP_NAME,
       DEPT_CODE,
       SALARY
  FROM
       EMPLOYEE
 WHERE
       DEPT_CODE = 'D5'
 MINUS
SELECT -- ����2 ��ȸ�Ѱ�
       EMP_NAME,
       DEPT_CODE,
       SALARY
  FROM
       EMPLOYEE
 WHERE
       SALARY > 3000000; 
-- WHERE AND NOT �̳� ������ �ݴ�� �ٲ㼭 ��� ����� �� �ִ�.



