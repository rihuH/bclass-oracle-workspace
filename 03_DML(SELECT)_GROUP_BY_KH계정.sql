-- EMPLOYEE ���̺� �����ϴ� ��ü ����� �� �޿��� �� ��ȸ

SELECT
       SUM(SALARY)
  FROM 
       EMPLOYEE; --> EMPLOYEE���̺� �����ϴ� ��ü ������� �ϳ��� �׷����� ��� �� �հ踦 ���� ���
       
    

/*
 <GROUP BY ��>
 �׷��� ������ ������ ������ �� �ִ� ����
 ���� ���� ������ �ϳ��� �׷����� ��� ó���� �������� ���

*/

-- �μ��� �� �޿� ��
SELECT
       SUM(SALARY),
       DEPT_CODE
  FROM
       EMPLOYEE
 GROUP
    BY
       DEPT_CODE; -- �μ��ڵ尡 ���� �ֵ鳢�� ���� ���̴�
       
-- ��ü �����
SELECT
       COUNT(*)
  FROM
       EMPLOYEE;
       
-- �μ��� �����
SELECT
       DEPT_CODE,
       COUNT(*)
  FROM
       EMPLOYEE
 GROUP
    BY
       DEPT_CODE;
       
-- �� �μ��� �޿��հ踦 ��������(�μ��ڵ�) �����ؼ� ��ȸ
SELECT
       DEPT_CODE,
       SUM(SALARY) --> ����3
  FROM
       EMPLOYEE --> ����1
 GROUP
    BY
       DEPT_CODE -->����2
 ORDER
    BY
       DEPT_CODE ASC; --> ����4
       
-- ���� ���� ī��Ʈ

SELECT
       COUNT(*),
       SUBSTR(EMP_NAME, 1, 1)
  FROM
       EMPLOYEE
 GROUP
    BY
       SUBSTR(EMP_NAME, 1, 1);
       
       
-- EMPLOYEE �� ���޺��� �����ڵ�, �� �޿��� ��, �����, ���ʽ��� �޴� �����, ��ձ޿�, �ְ�޿�, �ּұ޿��� ��ȸ���ּ���
       
SELECT
       JOB_CODE AS "�����ڵ�",
       SUM(SALARY) AS "�� �޿��� ��",
       COUNT(*) AS "�����",
       COUNT(BONUS) AS "���ʽ��� �޴� �����",
       ROUND(AVG(SALARY)) AS "��ձ޿�",
       MAX(SALARY) AS "�ְ�޿�",
       MIN(SALARY) AS "�ּұ޿�"
  FROM
       EMPLOYEE
 GROUP
    BY
       JOB_CODE
 ORDER
    BY
       JOB_CODE;

------------------------------

-- GROUP BY ���� ������ ��
-- : GROUP BY�� ���� GROUP���� ������ ���� �÷��� SELECT������ ����� �� ����.
/*
SELECT
       EMP_NAME -- �׷� ����� ���·� ���� �̸��� ��ȸ�� �� ����.
  FROM
       EMPLOYEE
 GROUP
    BY
       JOB_CODE; -- �׷��� ����� ����
 */      
       
-- �μ��ڵ�, �� �μ��� ��� �޿�
-- ��� �޿��� 300���� �̻��� �޿�
/*
SELECT
       DEPT_CODE,
       AVG(SALARY)
  FROM
       EMPLOYEE
 WHERE
       AVG(SALARY) >= 3000000 -- �̷��� �ϸ� ���� �߻�. �����������
       -- �Ϲ������� �ϸ� FROM ���� WHERE�� 2��. �׷� EMPLOYEE��ü�� ����� ���ϰ� �� �̹� �ϳ��� ���� ���� �ٽ� GROUP BY �� �� ����.
 GROUP
    BY
       DEPT_CODE; 
*/       

/*
 < HAVING �� >
 �׷쿡 ���� ������ ������ �� ����ϴ� ����.
 (�׷��Լ��� ������ ������ ����)

*/

SELECT
       DEPT_CODE,
       AVG(SALARY)
  FROM
       EMPLOYEE
 GROUP
    BY
       DEPT_CODE
HAVING
       AVG(SALARY) >= 3000000;
       
/*
SELECT 6�ѻ�
<������� *** �߿�>
5 : SELECT ��ȸ�ϰ��� �ϴ� �÷��� / �Լ���/ �������� / * / ��Ī..
1 : FROM ��ȸ�ϰ��� �ϴ� ���̺��
2 : WHERE ���ǽ�
3 : GROUP BY �׷� ���ؿ� �ش��ϴ� �÷��� / �Լ���
4 : HAVING �׷��Լ��Ŀ� �ش��ϴ� ���ǽ�
6 : ORDER BY ���ı��ؿ� �ش��ϴ� �÷��� / �Լ��� / ��Ī / �÷����� --- ASC / DESC --- NULLS FIRST / NULLS LAST

*/


-- EMPLOYEE ���̺�κ��� �� ���޺� �� �޿����� 1000���� �̻��� �����ڵ� , �޿��� ��ȸ// ��, �����ڵ尡 J6�� �׷��� ����

SELECT
       SUM(SALARY),
       JOB_CODE
  FROM
       EMPLOYEE
 WHERE
       JOB_CODE != 'J6'
 GROUP
    BY
       JOB_CODE
HAVING
       SUM(SALARY) >= 10000000
 ORDER
    BY
       SUM(SALARY);
       
-- ���ʽ��� �޴� ����� ���� �μ��ڵ常 ��ȸ
       
-- ��       
SELECT
       DEPT_CODE
  FROM
       EMPLOYEE
 GROUP
    BY
       DEPT_CODE
HAVING
       COUNT(BONUS) = 0;
 -- COUNT�� NULL �ƴ� �͸� ��.
-----------------------------









