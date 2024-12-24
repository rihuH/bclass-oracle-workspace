/*
    * DDL (DATA DEFINITION LANGUAGE) : ������ ���� ���
    
    ���� ��ü�� �����ϴ� ���� �ַ� DB������, �����ڰ� �����.
    
    DDL : CREATE, ALTER, DROP 
    
    ����Ŭ���� �����ϴ� ��ü(OBJECT)�� 
    ���Ӱ� �����(CREATE), ������ �����ϰ�(ALTER), ������ü�� �����ϴ�(DROP)�ϴ� ��ɹ�
    
    ����Ŭ������ ��ü(����)�� : �����(USER), ���̺�(TABLE), ��(VIEW), ������(SEQUENCE), ...
                        �ε���(INDEX), ��Ű��(PACKAGE), Ʈ����(TRIGGER), 
                        ���ν���(PROCEDURE), �Լ�(FUNCTION), ���Ǿ�(SYNONYM),...
                        
    DML : SELECT(DML�� �ٷ�ٰ� DQL�� �и��ϴ°� �߼�) / INSERT, UPDATE, DELETE
                        
*/

/*
    < CREATE TABLE >
    
    ���̺��̶�? : ��(ROW), ��(COLUMN)�� �����Ǵ� ���� �⺻���� �����ͺ��̽� ��ü
                ��� �����͸� ���̺��� ���ؼ� ������(�����͸� �����ϰ��� �Ѵٸ� �ݵ�� ���̺��� ������ ��)
    VIEW-CONTROLLER-DAO-DB�� �����ϴµ� ������ ����(����)�� �ʿ���.������ ���̺�
    
    ���̺� ����� ��
    [ǥ����]
    CREATE TABLE TB_���̺��(TB�� TABLE�̶�� �ǹ��� ���ξ�) (
        �÷��� �ڷ���, -- ���⼭�� Ű���� USER���� �� ������� �ʴ� ���� ����
        �÷��� �ڷ���,
        �÷��� �ڷ���,
        ...
    
--    ���̺� ��
    )
    
    < �ڷ��� >
    - ����(CHAR(ũ������) / VARCHAR2(ũ������)) : ũ�� �� BYTE? BYTE����. 
                                            ����, ������, Ư������ => 1���ڴ� 1BYTE
                                            �ѱ�, �Ϻ���, �߱��� => 1���ڴ� 3BYTE
    - CHAR(����Ʈ��) : �ִ� 2000BYTE���� ��������
                    ��������(�ƹ��� ���� ���� ���͵� �������� ä���� ó�� �Ҵ��� ũ�� ����)
                    �ַ� ���� ���� ���ڼ��� ������ ���� ��� ���.
                    ��) ��/��, M/F, 
    - VARCHAR2(ũ��): VAR�� '����'�� �ǹ�, 2�� '2��'�� �ǹ�->CHAR���� �ִ� 2000BYTE�ϱ� �ִ� 4000BYTE
                    ��������(���� ���� ������ ��䰪�� ���缭 ũ�Ⱑ �پ��) --> CLOB, BLOB
    - ����(NUMBER) : ����/ �Ǽ� ��� ���� NUMBER
    - ��¥(DATE) : �����.�ú���

*/

--> ȸ���� ����(���̵�, ��й�ȣ, �̸�, ȸ��������)�� ������� ���̺� �����ϱ�!
CREATE TABLE TB_USER(
    USER_ID     VARCHAR2(15), -- �� �ٿ� 1�÷�
    USER_PWD    VARCHAR2(20),
    USER_NAME   VARCHAR2(30),
    CREATE_DATE DATE
);

SELECT * FROM TB_USER;
DROP TABLE TB_USER;
/*
    �÷��� �ּ��ޱ� == ����ٴ� ���
    
    COMMENT ON COLUMN ���̺��.�÷��� IS '�ް��������'
    
    
*/
COMMENT ON COLUMN TB_USER.USER_ID IS 'ȸ�����̵�';
COMMENT ON COLUMN TB_USER.USER_PWD IS 'ȸ����й�ȣ';
COMMENT ON COLUMN TB_USER.USER_NAME IS 'ȸ���̸�';
COMMENT ON COLUMN TB_USER.CREATE_DATE IS 'ȸ��������';

SELECT * FROM USER_TABLES; -- ���� ���̺�鵵 ���̺�� ����
-- ���� �� ������ ������ �ִ� ���̺���� �������� ������ Ȯ���� �� �ִ� ������ ��ųʸ�

SELECT * FROM USER_TAB_COLUMNS; 
-- ���� �� ������ ������ �ִ� ���̺���� ��� �÷��� ������ ��ȸ�� �� �ִ� ������ ��ųʸ�

-- ������ ��ųʸ� : ��ü���� ������ �����ϰ� �ִ� �ý��� ���̺�

-- �����͸� �߰��� �� �ִ� ���� : INSERT --> �� �� ������ �߰�, ���� ������ �߿�. ���� �� ���� �� ����(NULL ���̶� ������)
-- INSERT INTO ���̺�� VALUES(ù ��° �÷��� ���� ��, �� ��° �÷��� ���� ��, �� ��° �÷��� ���� ��...)
INSERT INTO TB_USER VALUES('admin', '1234', '������', '2024-09-09'); -- ��¥�� ��κ��� ���� �� �� ��.
INSERT INTO TB_USER VALUES('user01', 'pass01', '�̽�ö', '2024/10/10');
INSERT INTO TB_USER VALUES('user02', 'pass02', 'ȫ�浿', SYSDATE);
--------------------------------------------------------------------------------

INSERT INTO TB_USER VALUES(NULL, NULL, NULL, SYSDATE); -- ���̵�, ��й�ȣ �ڸ��� NULL�� ������ �ȵǴµ� �Էµ�
INSERT INTO TB_USER VALUES('user02', 'pass03', '��浿', SYSDATE); -- �ߺ��� ���̵� �� �� ����.

SELECT * FROM TB_USER;

-- NULL���̳� �ߺ��� ���̵��� ��ȿ���� ���� ����
-- ��ȿ�� �����Ͱ��� �����ϱ� ���ؼ��� ���������� �ɾ������

--------------------------------------------------------------------------------

/*
    < �������� CONSTRAINT > 
    
    - ���̺� ���ϴ� �����Ͱ��� �����ϱ� ���ؼ�(�����ϱ� ���ؼ�) Ư�� �÷����� ����(������ ���Ἲ ������ ��������)
    - ���������� �ο��ϸ� �÷��� �����͸� ���� �Ǵ� ������ ������ �������ǿ� ������� �ʴ��� �˻�
    
    - ���� : NOT NULL, UNIQUE, CHECK, PRIMARY KEY, FOREIGN KEY
    
    - ���������� �ο��ϴ� ��� : �÷����� / ���̺���

*/

/*

    1. NOT NULL ��������
    �ش� �÷��� �ݵ�� ���� �����ؾ� �� ��� ���(NULL���� ���� ���ͼ��� �� �Ǵ� �÷��� �ο�)
    INSERT / UPDATE �� NULL���� ������� �ʵ��� ����
    
    NOT NULL���������� �÷����� ������θ� �ο��� �� ����
*/

-- ���ο� ���̺��� �����ϸ鼭 NOT NULL�������� �ޱ�
-- �÷�������� : �÷��� �ڷ��� �������� => ���������� �ο��ϰ��� �ϴ� �÷� �ڿ� ��ٷ� ���
CREATE TABLE TB_USER_NOT_NULL (
    USER_NO NUMBER NOT NULL,
    USER_ID VARCHAR2(15) NOT NULL,
    USER_PWD VARCHAR2(20) NOT NULL,
    USER_NAME VARCHAR2(30),
    GENDER CHAR(3),
    PHONE VARCHAR2(13)
);
DROP TABLE TB_USER_NOT_NULL;
SELECT * FROM TB_USER_NOT_NULL;

INSERT INTO TB_USER_NOT_NULL VALUES(1, 'admin', '1234', '������', '��', '010-1234-5678');

INSERT INTO TB_USER_NOT_NULL VALUES(NULL, NULL, NULL, NULL, NULL, NULL); -- NOT NULL �������ǿ� ����

INSERT
  INTO
       TB_USER_NOT_NULL
VALUES
       (
       2, -- �� ������ �������� ����� �� �˷��ش�. (������, ���̺��, �ȵǴ��÷���)
       'user01',
       'pass01',
       NULL,
       NULL,
       NULL
       ); -- NOT NULL ���������� �ο��Ǿ� �ִ� �÷����� �ݵ�� NULL�� �ƴ� ���� �����ؾ���!
       
SELECT * FROM TB_USER_NOT_NULL;

INSERT
  INTO
       TB_USER_NOT_NULL
VALUES
       (
       3,
       'user01', --�ߺ�
       '1234',
       NULL,
       NULL,
       NULL
       );
--------------------------------------------------------------------------------
/*
    2. UNIQUE ��������
    �÷��� �ߺ����� �����ϴ� ��������
    INSERT / UPDATE �� ������ �ش� �÷��� �� �ߺ����� ���� ��� �߰� �Ǵ� ������ �� �� ������ ����
    
    �÷����� / ���̺� ���� ��� �� �� ���� (NOT NULL�� �÷����� ����)
*/

--CREATE -- ������ ����
--INSERT -- ������� ������ ������ �߰�

CREATE TABLE TB_USER_UNIQUE(
    USER_NO   NUMBER       NOT NULL,
    USER_ID   VARCHAR2(15) NOT NULL UNIQUE, -- �÷� ���� �ڿ� �������� ���̴� ���� �÷���������̶�� ��.
    USER_PWD  VARCHAR2(20) NOT NULL,
    USER_NAME VARCHAR2(30),
    GENDER    CHAR(3),
    PHONE     VARCHAR2(13)
);
DROP TABLE TB_USER_UNIQUE;
--> ���̺� ����� ��


CREATE TABLE TB_USER_UNIQUE(
    USER_NO   NUMBER       NOT NULL,
    USER_ID   VARCHAR2(20), 
    USER_PWD  VARCHAR2(20) NOT NULL,
    USER_NAME VARCHAR2(30),
    GENDER    CHAR(3),
    PHONE     VARCHAR2(13),
    UNIQUE(USER_ID) -- USER_ID �÷��� UNIQUE ��������
);

SELECT * FROM TB_USER_UNIQUE;

INSERT INTO TB_USER_UNIQUE VALUES(1, 'admin', '1234', NULL, NULL, NULL);
INSERT INTO TB_USER_UNIQUE VALUES(2, NULL, '3456', NULL, NULL, NULL);
-- UNIQUE �������ǿ� ����Ǿ����Ƿ� INSERT�� ����
-- ������������ ����ũ ���������� ����Ǿ��ٴ� ����� �˷��ֱ�� ������ � �÷��� ���������� �� �˷���
-- ���� �ľ��ϱ� ��ƴٴ� ������ ���� --> �������� �ο��� �ý����� �˾Ƽ� ������ �������Ǹ��� �ο� SYS_C~~ ����-���̺�-�������ǿ��� Ȯ���� �� ����
INSERT INTO TB_USER_UNIQUE VALUES(3, NULL, '3456', NULL, NULL, NULL);
/*
    * �������� �ο� �� �������Ǹ� �����ϴ� ���
    > �÷����� ���
    CREATE TABLE ���̺��(
        �÷��� �ڷ���,
        �÷��� �ڷ��� CONSTRAINT �������Ǹ� ��������,
    );
    
    > ���̺��� ���
    CREATE TABLE ���̺��(
        �÷��� �ڷ���,
        �÷��� �ڷ���,
        CONSTRAINT �������Ǹ� ��������(�÷���)
    );
*/

CREATE TABLE TB_USER_CONSTRAINT(
    USER_NUMBER NUMBER CONSTRAINT NUM_NOT_NULL NOT NULL,
    USER_ID     VARCHAR2(20) NOT NULL,
    USER_PWD    VARCHAR2(20) NOT NULL,
    USER_NAME   VARCHAR2(30),
    GENDER      CHAR(3),
    PHONE       CHAR(13),
    CONSTRAINT USER_ID_UNIQUE UNIQUE(USER_ID)
);
-- �׷��� ������ NOT NULL�� ��� �÷��� �������� �ڼ��� �˷��༭ CONSTRAINT �� �ʿ� ����
INSERT INTO TB_USER_CONSTRAINT VALUES(1, 'admin', '1234', NULL, NULL, NULL);
INSERT INTO TB_USER_CONSTRAINT VALUES(2, 'admin', '3456', NULL, NULL, NULL);
-- �������Ǹ��� �����ϸ� ���� �߻� �� ������ ���� �÷��� ���� �� ���� ������ �� ����

INSERT INTO TB_USER_CONSTRAINT VALUES(3, 'user01', 'pass01', NULL, '��', NULL);
SELECT * FROM TB_USER_CONSTRAINT;
-- GENDER �÷����� '��' �Ǵ� '��'��� ���� ���� �ϰ� ����
--------------------------------------------------------------------------------
/*
    3. CHECK ��������
    �÷��� ��ϵ� �� �ִ� ���� ���� ������ ������ �� ����!
    
    CHECK(���ǽ�)
*/

CREATE TABLE TB_USER_CHECK(
    USER_NUMBER NUMBER NOT NULL,
    USER_ID VARCHAR2(20) NOT NULL UNIQUE,
    USER_PWD VARCHAR2(20) NOT NULL,
    USER_NAME VARCHAR2(20),
    GENDER CHAR(3) CHECK(GENDER IN ('��', '��')), -- ���ǽ��� ����� �����ؾ߸� �÷��� ���� INSERT�� �� ����.
    PHONE VARCHAR2(13), 
    ENROLL_DATE DATE
);
SELECT * FROM TB_USER_CHECK;

INSERT INTO TB_USER_CHECK VALUES(1, 'admin', '1234', NULL, '��', NULL, SYSDATE);
INSERT INTO TB_USER_CHECK VALUES(2, 'user01', '2345', NULL, '��', NULL, SYSDATE);

INSERT INTO TB_USER_CHECK VALUES(3, 'user02', 'pass02', NULL, NULL, NULL, SYSDATE);
-- CHECK ���������� �ο��߾ NULL���� INSERT�� �� �ִ� -> NULL���� ������ ���� ���� �ʹٸ� NOT NULL ���������� ���� �ο��ؾ��Ѵ�.

-- ȸ���������� �׻� SYSDATE������ �ް� ���� ��� ���̺��� ���� ����!
--------------------------------------------------------------------------------
/*
    * Ư�� �÷��� ���� ���� ���� �⺻���� �����ϴ� ��� => ���������� �ƴ�. (�ڿ� PK �⺻Ű�� �ٸ���, �⺻�� ����)
    
    -- ���̺� ����� �ǽ�--
    ���̺� �� : TB_USER_DEFAULT
    �÷� : 
        1. ȸ�� ��ȣ�� ������ �÷� : NULL�� ����
        2. ȸ�� ���̵� ������ �÷� : NULL�� ����, �ߺ��� ����
        3. ȸ�� ��й�ȣ�� ������ �÷� : NULL�� ����,
        4. ȸ�� �̸��� ������ �÷�
        5. ȸ�� �г����� ������ �÷� : �ߺ��� ����
        6. ȸ�� ������ ������ �÷� : '��' �Ǵ� '��'�� INSERT�� �� ����
        7. ��ȭ��ȣ ����
        8. �̸��� ����
        9/ �ּ� ����
        10. ������ ���� :  NULL�� ����
*/

CREATE TABLE TB_USER_DEFAULT(
    USER_NUMBER NUMBER NOT NULL,
    USER_ID VARCHAR2(20),
    USER_PWD VARCHAR2(20) NOT NULL,
    USER_NAME VARCHAR2(30),
    USER_NICKNAME VARCHAR2(20) CONSTRAINT USER_NICKNAME_UNIQUE UNIQUE,
    GENDER CHAR(3) CONSTRAINT GENDER_CHECK CHECK(GENDER IN ('��', '��')),
    PHONE CHAR(13),
    USER_EMAIL VARCHAR2(30),
    USER_ADDRESS VARCHAR2(150),
    ENROLL_DATE DATE DEFAULT SYSDATE NOT NULL,
    UNIQUE (USER_ID, USER_NUMBER) -- ������ �ϰ������ ������***
);

DROP TABLE TB_USER_DEFAULT;
-- INSERT INTO TB_USER_DEFAULT VALUES(1, 'admin', 'pass01', NULL, NULL, '��', NULL, NULL, NULL, NULL);
-- DEFAULT �ؼ� NULL ���� �� ��

/*
    INSERT INTO ���̺��(�÷���1, �÷���2, �÷���3, ...) 
    VALUES (��1, ��2, ��3, ...)
*/
INSERT
  INTO
       TB_USER_DEFAULT
       (
       USER_NUMBER,
       USER_ID,
       USER_PWD
       )
VALUES
       (
       1,
       'admin',
       'pass01'
       );
       
SELECT * FROM TB_USER_DEFAULT;
-- ���� �� �� �÷��� �⺻������ NULL���� ������
-- ���� DEFAULT���� �ο��Ǿ� �ִٸ� NULL�� ��� DEFAULT�� �����س��� ���� INSERT��!
--------------------------------------------------------------------------------
/*
    4.  PRIMARY KEY(�⺻Ű) �������� *****�߿�****
    
    �ڵ��� ��ȣ , ��й�ȣ, �г���..
    A
    010-1234-5678 aaaa ����A��
    
    B
    010-1234-5678 BBBB ����B��
    -- �ڵ�����ȣ�� A, B�� �ĺ��� �� ����
    
***** ���̺��� �� ����� ������ �����ϰ� �ĺ��� �뵵�� �÷��� �ο��ϴ� ��������
    -> �� ����� ������ �� �ִ� �ĺ����� ����
        ��) ȸ����ȣ, �Խñ۹�ȣ, �й�, ���, �����ȣ, �ֹ���ȣ...
    -> �ߺ��� �߻��ؼ� �ȵǰ�, ���� �����ؾ߸� �ϴ� �÷��� PRIMARY KEY �ο�
    
    �� ���̺� �� �� ���� ��� ����
*/

CREATE TABLE TB_USER_PK(
    USER_NO   NUMBER CONSTRAINT PK_USER PRIMARY KEY, -- �÷� ���� ���
    USER_ID   VARCHAR2(15) NOT NULL UNIQUE,
    USER_PWD  VARCHAR2(20) NOT NULL,
    USER_NAME VARCHAR2(30),
    GENDER    CHAR(3) CHECK(GENDER IN ('��','��')),
    PHONE     VARCHAR2(13)
    -- PRIMARY KEY(USER_NO) ���̺��� ���
);
DROP TABLE TB_USER_PK;
INSERT INTO TB_USER_PK
VALUES (1, 'admin', '1234', NULL, NULL, NULL);

INSERT INTO TB_USER_PK
VALUES (1, 'user01', '3456', NULL, NULL, NULL);
-- UNIQUE �������� ���� == �⺻Ű �÷����� �ߺ����� INSERT�� �� ����

INSERT INTO TB_USER_PK
VALUES (NULL, 'user02', '4567', NULL, NULL, NULL);
-- NOT NULL �������� ���� == �⺻Ű �÷����� NULL���� INSERT�� �� ����

CREATE TABLE TB_PRIMARYKEY(
    USER_NO NUMBER PRIMARY KEY,
    USER_ID VARCHAR2(15) PRIMARY KEY,
    USER_PWD VARCHAR2(20)
);
-- table can have only one primary key
-- �� ���� �÷��� ���� PRIMARY KEY ���������� �ο��� �� ����
-- �� ���� �÷��� ��� �ϳ��� PRIMARY KEY�� ���� �� ����
--->> ����. �� ���
DROP TABLE PRODUCT;
CREATE TABLE PRODUCT(
    NAME VARCHAR2(15),
    PRODUCT VARCHAR2(50),
    PRIMARY KEY(NAME, PRODUCT) -- �÷��� ��� PRIMARY KEY �ϳ��� ���� == ����Ű, ���ձ⺻Ű
);
INSERT INTO PRODUCT VALUES('�̽�ö', '��Ʈġ��');
INSERT INTO PRODUCT VALUES('�̽�ö', '��Ʈġ��');
INSERT INTO PRODUCT VALUES('�̽�ö', '����ġ��');
INSERT INTO PRODUCT VALUES('ȫ�浿', '��Ʈġ��');
SELECT
       *
  FROM
       PRODUCT
 WHERE
       NAME = '�̽�ö';
SELECT * FROM PRODUCT;
-- ����� ������ �ĺ�
-- ���Ἲ
-- ���̺� ����
-- ORACLE�� RDBMS�� ���Ե�. R�� RELATIONSHIP 

--------------------------------------------------------------------------------
-- ȸ�� ��޿� ���� ������(��� �ڵ�, ��޸�) �����ϴ� ���̺�
CREATE TABLE USER_GRADE( -- ���� ���ϴ� ���̺� '�θ����̺�'
    GRADE_CODE CHAR(2) PRIMARY KEY,
    GRADE_NAME VARCHAR(20) NOT NULL
);

INSERT INTO USER_GRADE VALUES('G1', '�Ϲ�ȸ��');
INSERT INTO USER_GRADE VALUES('G2', '���ȸ��');
INSERT INTO USER_GRADE VALUES('G3', '�ֿ��ȸ��');

SELECT  
       GRADE_CODE,
       GRADE_NAME
  FROM
       USER_GRADE;

/*
    5. FOREIGN KEY(�ܷ�Ű) ��������
    
    �ٸ� ���̺� �����ϴ� ���� �÷��� INSERT �ϰ� ���� �� �ο��ϴ� ��������
    => �ٸ� ���̺�(�θ����̺�)�� �����Ѵٰ� ǥ��
    �����ϰ� �ִ� ���̺� �����ϴ� ���� INSERT�� �� ����
    => FOREIGN KEY ���������� �̿��ؼ� �ٸ� ���̺��� ���踦 ������ �� ����
    
    [ ǥ���� ]
    - �÷� ���� ���
    �÷��� �ڷ��� REFERENCES ���������̺��(�������÷���)
    - ���̺� ���� ���
    FOREIGN KEY(�÷���) REFERENCES ���������̺��(�������÷���)
    
    �� ���� ��� ��� ������ �÷����� ���� ����.
    ������ ��� �ڵ����� ������ ���̺��� PRIMARY KEY�÷��� ������ �÷������� ������.
    PK������??
*/

CREATE TABLE TB_USER_CHILD( -- ���� '�ϴ�' ���̺��� �ڽ����̺�
    USER_NO NUMBER PRIMARY KEY, -- �������� �������� PK ���� �տ� ����.
    USER_ID VARCHAR2(15) NOT NULL UNIQUE,
    USER_PWD VARCHAR2(20) NOT NULL,
    GRADE_ID CHAR(2) REFERENCES USER_GRADE -- �÷��������
--    FOREIGN KEY(GRADE_ID) REFERENCES USER_GRADE ���̺������
);
DROP TABLE TB_USER_CHILD;
INSERT INTO TB_USER_CHILD
VALUES (1, 'admin', '1234', 'G1');

INSERT INTO TB_USER_CHILD
VALUES (2, 'user01', '3456', 'G2');

INSERT INTO TB_USER_CHILD
VALUES (3, 'user02', '4444', 'G2');

INSERT INTO TB_USER_CHILD
VALUES (4, 'user03', '3333', NULL); -- ���������� FK �������ǿ��� NULL ��. 

SELECT * FROM TB_USER_CHILD;

INSERT
  INTO
       TB_USER_CHILD
VALUES
       (
       5,
       'user04',
       '1111',
       'g4'
       );
-- integrity constraint : ������ ���Ἲ ��������. / parent key not found

-- ȸ����ȣ, ȸ�����̵�, ��޸��� ��ȸ���ּ���~
SELECT
       USER_NO,
       USER_ID,
       GRADE_NAME
  FROM
       USER_GRADE
 RIGHT
  JOIN
       TB_USER_CHILD ON (GRADE_CODE = GRADE_ID);

-- �θ����̺�(USER_GRADE)���� �����͸� ����
-- ���������� DROP ; DROP TABLE -- / DROP USER -- 

-- �����͸� ����� ���� ���� DELETE
-- USER_GRADE ���̺��� GRADE_CODE�� G1�� ���� ����
DELETE 
  FROM
       USER_GRADE -- ��������� ������ ���̺� �ִ� �� ���� ����. ���� �ڽ��� �־ ����� ���ٰ� ����
 WHERE
       GRADE_CODE = 'G1'; -- ���⵵ ���Ἲ����. CHILD �־
       -- �����ͺ��̽� ���� ���ѻ� CIA - Confidentiality(��м�) Integrity(���Ἲ) Availavility(���뼺)
-- child record found
-- �ڽ����̺��� �����͸� ����ϰ� �ִ� �÷��� �����ϱ� ������ ������ �� ����.

-- �ڽ����̺��� �θ����̺� �����ϴ� ���� ����ϰ� ���� ��� ������ �Ұ����� '�������ѿɼ�'�� �ɷ�����.
-- ���̺� ���� �� ���� ���� �ɼ��� ������ �� ����

DELETE
  FROM
       USER_GRADE
 WHERE
       GRADE_CODE = 'G3';
-- �ڽ����̺��� ����ϰ� ���� ���� �����ʹ� ���� �� ��

SELECT * FROM USER_GRADE;

ROLLBACK;
--------------------------------------------------------------------------------

/*
    * �ڽ����̺� ���� �� �ܷ�Ű ���������� �ο��� ���
    �θ����̺��� �����Ͱ� �����Ǿ��� �� �ڽ����̺����� ��� ó���� ������ �ɼ��� ������ �� ����
    
    �����ɼ��� ���� �������� �ʴ´ٸ� �⺻������ ON DELETE RESTRICTIED(���� ����)�� ������.
*/

-- 1) ON DELETE SET NULL --  �θ� ������ ������ �ش� �����͸� ����ϰ� �ִ� �ڽ� ���ڵ带 NULL������ �����Ű�� �ɼ�
CREATE TABLE TB_USER_ODSN(
    USER_NO NUMBER PRIMARY KEY,
    GRADE_ID CHAR(2),
    FOREIGN KEY(GRADE_ID) REFERENCES USER_GRADE ON DELETE SET NULL
);
INSERT INTO TB_USER_ODSN VALUES(1, 'G1');
INSERT INTO TB_USER_ODSN VALUES(2, 'G2');
INSERT INTO TB_USER_ODSN VALUES(3, 'G1');

SELECT * FROM TB_USER_ODSN;
-- �θ����̺� (USER_GRADE)�� GRADE_CODE�� G1�� ���� ����
DELETE
  FROM
       USER_GRADE
 WHERE
       GRADE_CODE = 'G1';
-- �ڽ����̺�(TB_USER_ODSN)�� GRADE_ID�÷��� ���� G1�̴� ģ������ ��� NULL�� �ٲ�

ROLLBACK;

-- 2) ON DELETE CASCADE : �θ����� ���� �� �ش� �����͸� ����ϰ� �ִ� �ڽĵ����͵� ���� ����
CREATE TABLE TB_USER_ODC(
    USER_NO NUMBER PRIMARY KEY,
    GRADE_ID CHAR(2),
    FOREIGN KEY(GRADE_ID) REFERENCES USER_GRADE ON DELETE CASCADE
);

INSERT INTO TB_USER_ODC VALUES(1, 'G1');
INSERT INTO TB_USER_ODC VALUES(2, 'G2');
INSERT INTO TB_USER_ODC VALUES(3, 'G3');
INSERT INTO TB_USER_ODC VALUES(4, NULL);

SELECT * FROM TB_USER_ODC;

DELETE FROM USER_GRADE WHERE GRADE_CODE = 'G1';
-- ���� ����
-- �ڽ����̺�(TB_USER_ODC)�� GRADE_ID�÷��� ���� G1�� ����� ��� ����!
/*
    �� �ܷ�Ű ���������� �ɷ��־�߸� JOIN�� �� �� �ִ� ���� �ƴ�
*/
--------------------------------------------------------------------------------
/*
    -- ���⼭���ʹ� ������ ������ KH �������� -- 
    * SUBQUERY�� �̿��� ���̺� ����(���� ����)
    
    [ǥ����]
    CREATE TABLE ���̺��
        AS ��������;
        
    ���������� ������ ����� ���Ӱ� ���̺��� ��������
*/

SELECT * FROM EMPLOYEE;
CREATE TABLE EMPLOYEE_COPY 
    AS SELECT * FROM EMPLOYEE;

SELECT * FROM EMPLOYEE_COPY;
-- �÷���, ��ȸ����� �����Ͱ���, �� ���������� NOT NULL�� �����.

SELECT * FROM EMPLOYEE WHERE 0 = 1;

CREATE TABLE EMPLOYEE_COPY2 AS
SELECT
       *
  FROM
       EMPLOYEE
 WHERE
       0 = 1;

SELECT * FROM EMPLOYEE_COPY2;

CREATE TABLE EMPLOYEE_COPY3 
    AS
SELECT 
       EMP_ID,
       EMP_NAME,
       SALARY * 12 AS "����"
  FROM
       EMPLOYEE;

SELECT * FROM EMPLOYEE_COPY3;
--------------------------------------------------------------------------------
/*
    * ���̺��� ������ �� ���������� �߰� -> �������� ->  (ALTER TABLE ���̺�� XXXX)
    - XXXX�κп� �Ʒ� �߰�
    - PRIMARY KEY : ADD PRIMARY KEY(�÷���);
    - FOREIGN KEY : ADD FOREIGN KEY(�÷���) REFERENCES ���̺��;
    - UNIQUE : ADD UNIQUE(�÷���);
    - CHECK : ADD CHECK(�÷���);
    - NOT NULL : MODIFY �÷��� NOT NULL;
*/

-- EMPLOYEE_COPY ���̺� �������� ���� PRIMARY KEY �������� �߰� -> EMP_ID �÷���
ALTER TABLE EMPLOYEE_COPY ADD PRIMARY KEY(EMP_ID);

-- EMPLOYEE_COPY ���̺� DEPT_CODE�÷��� �ܷ�Ű �������� �߰�(DEPARTMENT ���̺��� DEPT_ID �����ϵ���)
ALTER TABLE EMPLOYEE_COPY ADD FOREIGN KEY(DEPT_CODE) REFERENCES DEPARTMENT(DEPT_ID);





















