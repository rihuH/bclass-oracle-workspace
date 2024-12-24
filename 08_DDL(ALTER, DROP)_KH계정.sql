/*
    < DDL : DATA DEFINITION LANGUQGE >
    
    ��ü���� ���Ӱ� ����(CREATE)�ϰ� ����(ALTER)�ϰ� ����(DROP)�ϴ� ����
    
    DQL : SELECT                 => ����
    DML : INSERT/ UPDATE/ DELETE => ������ ����
    DDL : CREATE/ ALTER/ DROP    => ���� ����
    
    1. ALTER
    ��ü ������ �����ϴ� ����
    
    < ���̺� ���� >
    ALTER TABLE ���̺�� �����ҳ���;
    - ������ ����
    1) �÷� �߰� / �÷� ���� / �÷� ����
    2) �������� �߰� / ���� => ������XXX(���� �� �ٽ� �߰��ϴ� ������� �����ؾ���)
    3) ���̺�� / �÷���/ �������Ǹ�
*/

-- 1) �÷� �߰� / ���� / ����
SELECT * FROM DEPT_COPY;

-- 1_1) �÷��߰� (ADD) : ADD �߰����÷��� �ڷ��� DEFAULT �⺻��(DEFAULT�� ���� ����)

--- BOSS �÷� �߰�
ALTER TABLE DEPT_COPY ADD BOSS VARCHAR2(20);
-- ���ο� �÷� �߰� �� �⺻������ NULL���� ä����

-- LOCATION_NAME �÷� �߰� DEFAULT �� �����ؼ�
ALTER TABLE DEPT_COPY ADD LOCATION_NAME VARCHAR2(20) DEFAULT '�ѱ�';
-- NULL���� �ƴ� DEFAULT������ ä����

-- 1_2) �÷����� (MODIFY)
-- ������ Ÿ�� ���� : ALTER TABLE ���̺�� MODIFY �������÷��� �ٲٰ����ϴµ�����Ÿ��;
-- DEFAULT �� ���� : ALTER TABLE ���̺�� MODIFY �������÷��� DEFAULT �ٲٰ����ϴ±⺻��;

SELECT * FROM DEPT_COPY;

-- DEPT_ID �÷� ������Ÿ���� CHAR(3)�� ����
ALTER TABLE DEPT_COPY MODIFY DEPT_ID CHAR(3);
ALTER TABLE DEPT_COPY MODIFY DEPT_ID CHAR(1); -- cannot decrease column length because some value is too big
ALTER TABLE DEPT_COPY MODIFY DEPT_ID NUMBER; -- column to be modified must be empty to change datatype/ ���� �̹� �ִµ� ���� ���ڰ� �ƴ�. ���� ���� �ٲٴ��� �϶�� ��
ALTER TABLE DEPT_COPY MODIFY DEPT_TITLE VARCHAR2(10); -- cannot decrease column length because some value is too big
-- ���� �����ϰ��� �ϴ� �÷��� �̹� ����ִ� ���� ������ �ٸ� Ÿ�� / �Ǵ� ���� ũ��δ� ������ �Ұ����ϴ�.
-- ���� ����->���� X / ������ ���X/ ũ�� Ȯ��� O // �ٵ� �����Ͱ� ��������� ��� ���µ�.

-- DEPT_TITLE �÷� ������Ÿ���� VARCHAR2(40)
-- LOCATION_ID �÷� ������Ÿ���� VARCHAR2(3)
-- LOCATION_NAME �÷� �⺻���� '�̱�'

ALTER TABLE DEPT_COPY
MODIFY DEPT_TITLE VARCHAR2(40)
MODIFY LOCATION_ID VARCHAR2(3)
MODIFY LOCATION_NAME DEFAULT '�̱�'; -- MODIFY�� �� ���� ����� �� �ִ�.

CREATE TABLE DEPT_COPY2 AS
SELECT * FROM DEPT_COPY;

-- 1_3) �÷����� (DROP COLUMN) : DROP COLUMN �����ϰ��� �÷���
SELECT * FROM DEPT_COPY2;

ALTER TABLE DEPT_COPY2 DROP COLUMN DEPT_TITLE; -- ������ �÷��� ������ �� ����.
-- ������ ���� �׷���, ������ ���� �ּ� 1���� �÷��� �־�� �Ѵ�.

/*
CREATE TABLE ABC(

);
*/
--------------------------------------------------------------------------------
-- 2) �������� �߰�/ ���� (������ �Ұ�)
/*
    2_1) �������� �߰�
    
    ������ �������Ǹ��� ���� ADD [CONSTRAINT �������Ǹ�] ��������
    ���� ���� : ���������� TABLE�� �ٴ� ���� �ƴ϶� ������ �ٴ� ���̴�. �׷��� �� ������ ������ �ִ� �������Ǹ�� �浹�ϴ� ���������� ���� �� ����.
    ���� ������ ������ �ִ� ������ �������Ǹ�� �浹�ϸ� �ȵ�!
*/

ALTER TABLE DEPT_COPY
--  ADD CONSTRAINT DCOPY_UQ UNIQUE(DEPT_TITLE)
MODIFY LOCATION_NAME CONSTRAINT DCOPY_NN NOT NULL; -- NOT NULL�� �÷��� �ٴ� �Ŷ� MODIFY

/*
    2_2) �������� ����
    PRIMARY KEY, FOREIGN KEY, UNIQUE, CHECK : DROP CONSTRAINT �������Ǹ�
    NOT NULL : MODIFY �÷��� NULL
*/

ALTER TABLE DEPT_COPY DROP CONSTRAINT DCOPY_UQ; -- �÷�����°� �ƴϰ� �������� ����°Ŵϱ� �������Ǹ����� DROP�ؾ��Ѵ�.
--------------------------------------------------------------------------------
-- 3) �÷��� / �������Ǹ� / ���̺�� ����(RENAME)

-- 3_1) �÷��� ���� : ALTER TABLE ���̺�� RENAME COLUMN �����÷��� TO �ٲ��÷���;
ALTER TABLE DEPT_COPY RENAME COLUMN LOCATION_NAME TO LNAME;

-- 3_2) �������Ǹ� ���� : ALTER TABLE ���̺�� RENAME CONSTRAINT �����������Ǹ� TO �ٲ��������Ǹ�;
ALTER TABLE DEPT_COPY RENAME CONSTRAINT DCOPY_NN TO DCOPY_NOT_NULL;

-- 3_3) ���̺�� ���� : ALTER TABLE ���̺�� RENAME �������̺�� TO �ٲ����̺��;
ALTER TABLE DEPT_COPY RENAME TO DEPT_TEST; -- ALTER TABLE ���̺�� �ϸ鼭 �������̺���� �����Ƿ�, �ڿ� �����ϰ� �����ص� ��. �Ϲ������� �̷��� ����.
SELECT * FROM DEPT_TEST;

ALTER TABLE DEPT_TEST ADD PRIMARY KEY(DEPT_ID);

CREATE TABLE DEPT_CHILD(
    DEPT_ID CHAR(3) REFERENCES DEPT_TEST(DEPT_ID)
);

INSERT INTO DEPT_CHILD VALUES('D1');
COMMIT;
--------------------------------------------------------------------------------

/*
    2. DROP
    ��ü�� �����ϴ� ����
*/
SELECT * FROM DEPT_TEST; -- �θ����̺�
SELECT * FROM DEPT_CHILD; -- �ڽ����̺�

DROP TABLE DEPT_TEST;
-- �����Ͱ� �ڽ����̺��� �����ǰ� ����!! DROP�� �� ����
-- 1. �ڽ����̺��� ���� ������ �� �θ����̺��� ����

DROP TABLE �θ����̺� CASCADE CONSTRAINTS; -- CASCADE�� ���̸� �ڽĿ��� �����ص� �����ϰ� �θ� ���� �� �ִ�. CONSTAINTS�� �������Ǳ���

-- DROP USER ������ -- ������ ������ ���� �� �ȴ�/  ������ �����ڰ������� �ؾ��Ѵ�/
