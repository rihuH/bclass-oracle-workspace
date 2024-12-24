/*
    < DCL  : DATA CONTROL LANGUAGE >
            ������ ���� ���
            
    �������� �ý��۱��� �Ǵ� ��ü ���� ������ �ο�(GRANT)�ϰų� ȸ��(REVOKE)�ϴ� ���
    
    * ���� �ο�(GRANT)
    - �ý��� ���� : Ư�� DB�� �����ϴ� ����, ��ü���� ������ �� �ִ� ����
    - ��ü (����) ���� : Ư�� ��ü�鿡 �����ؼ� ������ �� �ִ� ����
    
    * �ý��� ������ ����
    - CREATE SESSION : ������ ������ �� �ִ� ����
    - CREATE TABLE : ���̺��� ������ �� �ִ� ����
    - CREATE VIEW : �並 ������ �� �ִ� ����
    - CREATE SEQUENCE : �������� ������ �� �ִ� ����
    ...
    
    [ ǥ���� ]
    GRANT ����1, ����2, ... TO ������;

*/
-- 1. SAMPLE ���� ����
CREATE USER SAMPLE IDENTIFIED BY SAMPLE; -- �������� ��ҹ��ڷ� �Է��ص� �׻� �빮��/ ��й�ȣ�� ��ҹ��ڸ� �����ϹǷ� ������ �ʿ䰡 �ִ�.

--2. SAMPLE������ ������ �� �ֵ��� CREATE SESSION ���� �ο�
GRANT CREATE SESSION TO SAMPLE; -- CREATE SESSION ������ SAMPLE������ �ο�

-- 3_1_2. SAMPLE�������� ���̺��� ������ �� �ֵ��� CREATE TABLE ���� �ο�
GRANT CREATE TABLE TO SAMPLE;

-- 3_2. SAMPLE������ ���̺��� ������ �� �ֵ��� TABLE SPACE�� �Ҵ����ֱ�. (SYSTEM ����)
ALTER USER SAMPLE QUOTA 2M ON SYSTEM; -- 2MB ������ ������ �Ҵ�����

-- 4_2. SAMPLE������ �並 ������ �� �ֵ��� CREATE VIEW���� �ο�
GRANT CREATE VIEW TO SAMPLE;
--------------------------------------------------------------------------------
/*
    * ��ü ���� 
    
    Ư�� ��ü���� ����(SELECT, INSERT, UPDATE, DELETE)�� �� �ִ� ����
    
    [ ǥ���� ]
    GRANT �������� ON Ư����ü TO ������; 
*/

-- 5. SAMPLE ������ KH���� ������ EMPLOYEE���̺��� ��ȸ�� �� �ִ� ���� �ο�
GRANT SELECT ON KH.EMPLOYEE TO SAMPLE;

-- 6_2. SAMPLE������ KH.DEPARTMENT ���̺� �����͸� �߰��� �� �ִ� ���� �ο�
GRANT INSERT ON KH.DEPARTMENT TO SAMPLE;
--------------------------------------------------------------------------------
-- GRANT�� ���� �ο�
-- GRANT CONNECT, RESOURCE TO ������; -- role�̶�� �θ��� �ֵ�

SELECT *
  FROM ROLE_SYS_PRIVS
 WHERE
       ROLE IN ('CONNECT', 'RESOURCE');
       
/*
    < �� ROLE >
    Ư�� ���ѵ��� �ϳ��� �������� ��Ƴ��� ��
    
    CONNECT : CREATE SESSION(DB�� ������ �� �ִ� ����)
    RESOURCE : CREATE TABLE, CREATE SEQUENCE ... (Ư�� ��ü���� ���� �� ������ �� �ִ� ����)
*/
--------------------------------------------------------------------------------

/*
    * ���� ȸ��(REVOKE)
    
    [ ǥ���� ]
    REVOKE ����1, ����2... FROM ������̸�;
*/

-- 7. SAMPLE������ �ο����� ���̺� ���� ���� ȸ��
REVOKE CREATE TABLE FROM SAMPLE;
















