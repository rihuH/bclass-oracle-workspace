/*
    < TCL : TRANSACTION CONTROL LANGUAGE >
            Ʈ����� ���� ���
            
    * TRANSACTION
    - �����ͺ��̽��� ���� ������� (�����ڰ� ������ �Ǵ��ϴ�)
    - �������� �������(DML)���� �ϳ��� Ʈ��������� ��� ���� -- 3�� �� �ϳ��� ���� �ϳ��� Ʈ������� �������
        COMMIT(Ȯ��)�ϱ� �������� ������׵��� �ϳ��� Ʈ����ǿ� ��Ե�
    - Ʈ������� ����� �Ǵ� SQL : INSERT, UPDATE, DELETE  (DML)
    
    TRANSACTION�� 4���� �Ӽ�
    ACID
    
    1. Atomicity(���ڼ�) : Ʈ����� ���� ��� �۾��� ����ǰų�, ���� ������� �ʾƾ��ϴ� ��Ģ// 1 �ƴϸ� 0
    2. Consistency(�ϰ���) : Ʈ������� ���������� �Ϸ� �� �Ŀ��� �����ͺ��̽��� ��ȿ�� ���¸� �����ؾ� �Ѵٴ� ��Ģ
    3. Isolation(����) : ���ÿ� ����Ǵ� ���� Ʈ������� ��ȣ���� ������ ��ġ�� �ʵ��� �ϴ� ��Ģ // a�� Ʈ������� b�� Ʈ����ǿ� ������ ��ġ�� �ȵ�
    4. Durability(���Ӽ�) : Ʈ������� ���������� ����Ǹ�, �ý����� ������ �߻��ϴ��� ���������� ����Ǿ�� �ϴ� ��Ģ
    
    COMMIT(Ʈ������� ���� ó�� �� Ȯ��), ROLLBACK(Ʈ����� ���), SAVAPOINT(�ӽ������� ���)

*/

SELECT * FROM EMPLOYEE_COPY WHERE EMP_ID = 222;

-- ����� 222���� ��� ����
DELETE -- DELETE���� TRANSACTION ����. �Ʒ��� ��� TRANSACTION �ȿ� ��. DELETE/ 221���� DELETE... // SELECT�� ��ȸ�� �ϴ� �Ŷ� TRANSACTION �� ������ ��ġ�� �ʴ´�.
  FROM 
       EMPLOYEE_COPY
 WHERE  
       EMP_ID = 222;
       
-- ����� 221���� �������
DELETE
  FROM
       EMPLOYEE_COPY
 WHERE
       EMP_ID = 221;

SELECT * FROM EMPLOYEE_COPY;

ROLLBACK; -- ROLLBACK�ϸ� Ʈ������� �������. �� Ʈ����� �ȿ� �ִ� �۾��� DELETE 222 DELETE 221 ��� �����ǰ� �� ������ ���·� ���ư�.
--------------------------------------------------------------------------------

SELECT * FROM EMPLOYEE_COPY; -- Ʈ����ǰ��� �ƹ� ������ ����
-- ����� 222���� ��� ����

DELETE FROM EMPLOYEE_COPY WHERE EMP_ID = 222; -- Ʈ����� ����

UPDATE EMPLOYEE_COPY SET EMP_NAME = '������' WHERE EMP_NAME = 'ȫ�浿'; -- DELETE �ϸ鼭 ������ Ʈ����� �ȿ� �߰���.

SELECT * FROM EMPLOYEE_COPY;

COMMIT; -- ���� TRANSACTION�� �ö� �ִ� �۾������� Ȯ��. TRANSACTION�� �۾� ���Ϸ� SSD � �����ϰ� �����
ROLLBACK; -- �׷��� ���� TRANSACTION�� ���ִ� DELETE�� �ص� �ƹ� ��ȭ�� ���� ��.
--------------------------------------------------------------------------------

-- ����� 217, 216, 214�� ��� ����
DELETE -- TRANSACTION ��������� DELETE �ϳ� �ö�
  FROM
       EMPLOYEE_COPY
 WHERE
       EMP_ID IN (217, 216, 214);
-- 3�� �� ��(��) ������ ������ SAVEPOINT ����
SAVEPOINT DELETE3ROWS; -- ������ �ϳ� ����// �� ���Ŀ� �۾��� ���븸 ROLLBACK�Ǿ� �����. �� ������ �۾����� TRANSACTION�� ��������.

-- ������� �������� ����� �̸��� ȫ�浿���� ����
UPDATE -- DELETE�� �ö��ִ� TRANSACTION�� UPDATE�� �ö�
       EMPLOYEE_COPY
   SET
       EMP_NAME = 'ȫ�浿'
 WHERE
       EMP_NAME = '������';
       
ROLLBACK TO DELETE3ROWS; -- ���̺�����Ʈ�� ROLLBACK
       
SELECT * FROM EMPLOYEE_COPY;
ROLLBACK;
--------------------------------------------------------------------------------

COMMIT;
-- ** ���ǻ���
-- ����� 218���� ��� ����
DELETE  
  FROM
       EMPLOYEE_COPY
 WHERE
       EMP_ID = 218;
       
SELECT * FROM EMPLOYEE_COPY;

CREATE TABLE HAHA(
    HID NUMBER
);
DROP TABLE HAHA;
ROLLBACK;

/*
    DDL����(CREATE, ALTER, DROP)�� �����ϴ� ����
    ������ Ʈ����ǿ� �ִ� ��� �۾����׵��� ������ ***COMMIT***�ؼ� ���� DB�� �ݿ���Ų �Ŀ� DDL�� ����
    --> DDL������ Ʈ������� ��������ִٸ� COMMIT/ROLLBACK�ϰ��� DDL�� �����ؾ���
*/
