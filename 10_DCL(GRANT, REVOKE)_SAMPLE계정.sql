
CREATE TABLE TEST(
    TEST_ID NUMBER
);
-- 3_1. SAMPLE������ ���̺��� ������ �� �ִ� ������ ���� ������ ���� �߻�
-- insufficient privileges

-- CREATE TABLE ���� �ο�����!!
CREATE TABLE TEST(
    TEST_ID NUMBER
);
-- tablespace�� �Ҵ� ���� ���ؼ� ���� �߻�
-- no privileges on tablespace

-- TABLESPACE�� �Ҵ���� ��
CREATE TABLE TEST(
    TEST_ID NUMBER
);
-- ���̺� ���� �Ϸ�!

-- ���̺� ���������� �ο��ް� �Ǹ� ������ �����ϰ� �ִ� ���̺��� ������ �� ���� ( ���۱����� ���� ��)

SELECT * FROM TEST;
INSERT INTO TEST VALUES(1);

-- �� ������
CREATE VIEW V_TEST
    AS SELECT * FROM TEST;
-- 4. �� ��ü�� ������ �� �ִ� CREATE VIEW ������ ���� ������ ���� �߻�
-- insufficient privileges

-- CREATE VIEW ���� �ο� ���� �� 
CREATE VIEW V_TEST
    AS SELECT * FROM TEST;
-- �� ���� �Ϸ�
--------------------------------------------------------------------------------

-- SAMPLE�������� KH������ ������ �ִ� ���̺� �����ؼ� ��ȸ�غ���
SELECT * FROM KH.EMPLOYEE;
-- 5. KH������ �����ؼ� ��ȸ�� �� �ִ� ������ ���� ������ ���� �߻�

-- SELECT ON ���� �ο� ��
SELECT *
  FROM KH.EMPLOYEE;
  
SELECT * FROM KH.DEPARTMENT;
-- SAMPLE ������ ���� ������ KH.EMPLOYEE���̱� ������ ��ȸ �Ұ�.

-- SAMPLE �������� KH������ DEPARTMENT���̺� �����ؼ� INSERT �غ���
INSERT INTO KH.DEPARTMENT VALUES('DO', 'ȸ���', 'L1');
-- 6. SAMPLE������ KH������ DEPARTMENT���̺� ������ �� �ִ� ������ ���� ������ INSERT�� ������ �� ����


-- INSERT TO ���� �ο� ��
INSERT INTO KH.DEPARTMENT VALUES('D0', 'ȸ���', 'L1');
-- INSERT ����!

SELECT * FROM KH.DEPARTMENT; -- SELECT�� �� �޾Ƽ� �� �� ����
ROLLBACK; -- �ѹ��� �� �� ����
--------------------------------------------------------------------------------

CREATE TABLE ABC(
    ABC NUMBER
);
-- 7. SAMPLE �������� ���̺��� ������ �� �ִ� ������ ȸ���߱� ������ ���� �߻�



