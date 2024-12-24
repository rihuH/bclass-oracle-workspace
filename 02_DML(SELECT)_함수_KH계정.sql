/*

�Լ� < FUNCTION >
�ڹٷ� ������ �޼ҵ�
���޵� ������ ������ ���� ����� ��ȯ


- �������Լ� : N���� ���� �о N���� ���� ����(�� �ึ�� �Լ��� ������ �� ��� ��ȯ)
- �׷��Լ� : N���� ���� �о 1���� ����� ����(�ϳ��� �׷캰�� �Լ� ���� �� ����� ��ȯ) 
-- �׷��� �������Լ��� �׷��Լ��� ����� ���ƿ��� �� ������ �ٸ��Ƿ� ���� �� �� ����.

*/
---------------------<������ �Լ�>--------------------------
/*
    ** �ڹ� String Ư¡ �Һ���ü(Immutalble) ���� ���ϰ� ���� Ư¡ ���ϱ�. ���� �߿��� Ư¡ ����
    
    ����Ŭ�� �Լ��� PURE�ϴ�. �ڹٿ� �ٸ��� ���� �Լ�ó�� ������ ������� ������.
    < ���ڿ��� ���õ� �Լ� > 
    LENGTH / LENGTHB
    
    STR : '���ڿ�' / ���ڿ��� ����ִ� �÷�
    
    - LENGTH(STR) : ���޵� ���ڿ��� ���� �� ��ȯ
    - LENGTHB(STR) : ���޵� ���ڿ��� ����Ʈ �� ��ȯ
    
    ����� NUMBER Ÿ������ ��ȯ.(����Ÿ���� ����Ŭ���� �̷��� ǥ��)
    
    �ѱ� : '��', '��', '��', => �� ���ڴ� 3Byte ���. �� �� �� �� 3����Ʈ
    ����, ����, Ư������ => �� ���ڴ� 1Byte ���
        
*/

SELECT
       LENGTH('����Ŭ!'),
       LENGTHB('����Ŭ!')
  FROM
       DUAL; -- �������̺�(DUMMY TABLE)
       

SELECT
       EMAIL,
       LENGTH(EMAIL)
  FROM
       EMPLOYEE;

--------------------------------------------------------------------------------

/*
INSTR
- INSTR(STR) : ���ڿ��κ��� Ư�� ������ ��ġ�� ��ȯ

INSTR(STR, 'Ư�� ����', ã����ġ�ǽ��۰�, ����)

������� NUMBERŸ������ ��ȯ
ã�� ��ġ�� ���۰��� ������ ���� ����

ã�� ��ġ�� ���۰�
1. : �տ������� ã�ڴ�. (�� ������ �⺻��)
-1 : �ڿ������� ã�ڴ�.

*/

SELECT INSTR('AABAACAABBAA', 'B') -- �տ������� 3��°�ϱ� 3 ����.
  FROM DUAL; -- ã�� ��ġ, ���� ������ �⺻������ �տ������� ù ��° ������ ��ġ �˻�.
  
SELECT INSTR('AABAACAABBAA', 'B', -1)
  FROM DUAL; -- �ڿ������� �˻��ؼ� 10��°�� �� ������ B ����
-- �ش� ���ڿ��� �ڿ������� ù��° 'B'�� �տ������� �� ��°�� �����ϴ��� ��ȯ.

SELECT INSTR('AABAACAABBAA', 'B', 1, 3)
  FROM DUAL;
  -- 3��° B�� ��ġ�� ����
  -- ���� 4��° Bã����� �ϸ� 0 ����
-- �ش� ���ڿ��� �տ������� ����° 'B'�� �տ������� �� ��°�� �����ϴ��� ��ȯ

--- EMPLOYEE���̺�κ��� EMAIL�÷��� ���� �� @ ��ġ ã��!
SELECT
       INSTR(EMAIL, '@') "@�� ��ġ"
  FROM
       EMPLOYEE;
--------------------------------------------------------------------------------

/*
 SUBSTR
 
 - SUBSTR(STR, POSITION, LENGTH) : ���ڿ����� Ư�� ���ڿ��� �����ؼ� ��ȯ
 STR : '���ڿ�' �Ǵ� ����Ÿ�� �÷���
 POSITION : ���ڿ� ���� ������ġ��(������ ���ð���) -> POSITION��° ���ں��� ����
 LENGTH : ������ ���� ����(������ ��������� �ǹ�)
 
*/

SELECT
       SUBSTR('KH����������', 3) -- 3��° ���ں��� ������ ����
  FROM
       DUAL;
----------
SELECT
       SUBSTR('KH����������', 3, 2) -- 3��°���� 2�� '����' ����
  FROM
       DUAL;
       
----------

SELECT
       SUBSTR('KH����������', -3, 2) --���� ������ ���ڸ� -1, �� ���� -2 ��� �ļ� �ڿ������� 3��°���� �����ؼ� �ڷ� 2��.
  FROM
       DUAL;
-- ���� ��ġ�� ������ ��� �ڿ������� N��° ��ġ�κ��� ���ڸ� �����ϰڴ� ��� �ǹ�

--EMPLOYEE���̺�κ��� ������ �̸��� �÷��� EMAIL�÷��� ���̵� ���� ��ȸ
SELECT
       EMP_NAME,
       EMAIL,
       SUBSTR(EMAIL, 1, INSTR(EMAIL, '@') - 1) ���̵�
  FROM
       EMPLOYEE;
-- INSTR ��ȯ���� �����̹Ƿ� ����ó�� ���.

------

��������鸸 ��ȸ
SELECT
       EMP_NAME
  FROM 
       EMPLOYEE
 WHERE
       SUBSTR(EMP_NO, 8, 1) IN ('2', '4');
       
--------------------------------------------------------------------------------

/*
LPAD / RPAD

- LPAD / RPAD (STR, ���������� ��ȯ�� ������ ����(����Ʈ), �е��� ����)
 : ������ ���ڿ��� ������ ���ڸ� ���� �Ǵ� �����ʿ� ���ٿ��� ���� N���̸�ŭ�� ���ڿ��� ��ȯ
 
 ������� CHARACTERŸ������ ��ȯ
 �����̰��� �ϴ� ���ڴ� ���� ����

-- �е� �� �� �е��� ���Ӹ�
*/

SELECT
       LPAD(EMAIL, 25)
  FROM
       EMPLOYEE; -- �����̰��� �ϴ� ���� ������ �⺻������ ����
       
-------------

SELECT
       RPAD(EMAIL, 25, '#')
  FROM
       EMPLOYEE;

--------------

SELECT
       EMP_NAME,
       EMP_NO
  FROM
       EMPLOYEE;
       
-- ----
SELECT RPAD('770101 - 1', 14, '*')
  FROM DUAL;
  -- ����ŷ �۾��̶� �Ѵ�.
  
-- EMPLOYEE���̺��� ��� ������ ������ �ֹε�Ϲ�ȣ �� 6�ڸ��� ����ŷó���ؼ� ��ȸ�ϱ�.
SELECT
       EMP_NAME,
       RPAD(SUBSTR(EMP_NO, 1, 8), 14, '*') "�ֹι�ȣ"
  FROM 
       EMPLOYEE;

--------------------------------------------------------------------------------

/*
 LTRIM / RTRIM
 
 - LTRIM / RTRIM (STR, �����ϰ����ϴ¹���)
 : ���ڿ��� ���� �Ǵ� �����ʿ��� �����ϰ��� �ϴ� ���ڵ��� ã�Ƽ� ������ ������ ���ڿ��� ��ȯ
 
 ������� CHARACTER Ÿ������ ��ȯ
 �����ϰ����ϴ� �ι�° ���ڰ��� ���� ����
 
*/

SELECT
       LTRIM('      K   H')
  FROM 
       DUAL;
       -- LTRIM�� ���ʿ� �ִ� ���鹮��
       
SELECT
       LTRIM('123123KH123', '123')
  FROM
       DUAL; -- KH123/ 123�� ���� �����
       
--------------------------------------------------------------------------------
/*

TRIM
- TRIM(BOTH / LEADING / TRAILING '���Ž�Ű�����ϴ¹���' FROM STR)
 : ���ڿ��� �� / �� / ���ʿ� �ִ� Ư�� ���ڸ� ������ ������ ���ڿ��� ��ȯ
 
 ������� CHARACTERŸ������ ��ȯ
 BOTH / LEADING / TRAILING ������ �⺻���� BOTH

*/

-- �⺻������ ���ʿ� �ִ� ���� ����
SELECT
       TRIM('     K  H     ')
  FROM
       DUAL;
-------- LEADING�� LTRIM�� ����
SELECT
       TRIM(LEADING 'Z' FROM 'ZZZKHZZZ')
  FROM
       DUAL; -- LEADING : ����
-------- TRAILING RTRIM�� ����
SELECT
       TRIM(TRAILING 'Z' FROM 'ZZZKHZZZ')
  FROM
       DUAL; -- TRAILING : ����
       
SELECT
       TRIM('Z' FROM 'ZZZKHZZZ')
  FROM 
       DUAL;
--------------------------------------------------------------------------------

/*
LOWER / UPPER / INITCAP

- LOWER(STR)
 : �� �ҹ��ڷ� ����
 
- UPPER(STR)
 : �� �빮�ڷ� ����
 
- INICAP(STR)
 : �� �ܾ�� �ձ��ڸ� �빮�ڷ� ����
 
 ������� ��� CHARACTERŸ������ ��ȯ
 
*/

SELECT
       LOWER('HELLO WORLD')
  FROM
       DUAL;
       
SELECT
       UPPER('hello world')
  FROM
       DUAL;
       
SELECT
       INITCAP('HELLO WORLD')
  FROM
       DUAL;
       
--------------------------------------------------------------------------------

/*
CONCAT

- CONCAT (STR1, STR2)
 : ���޵� �� ���� ���ڸ� �ϳ��� ��ģ ����� ��ȯ
 
 ������� CHARACTER Ÿ������ ��ȯ
*/

SELECT CONCAT('��Ƿ�������', '����������')
  FROM DUAL;
  
--------------------------------------------------------------------------------

/*
 REPLACE
 
 - REPLACE(STR, ã������, �ٲܹ���)
  : STR�κ��� ã�� ���ڸ� ã�Ƽ� �ٲܹ��ڷ� �ٲ� ���ڿ��� ��ȯ
  
  ������� CHARACTERŸ������ ��ȯ
*/

SELECT
       REPLACE('����� �߱� ���빮�� 120 ���Ϻ���', '���Ϻ���', '�׷����� û��')
  FROM 
       DUAL;
       
SELECT
       EMP_NAME,
       EMAIL,
       REPLACE(EMAIL, 'kh.or.kr', 'iei.or.kr')
  FROM
       EMPLOYEE;
       
--------------------------------------------------------------------------------

/*

<���ڿ� ���õ� �Լ�>
- ABS(NUMBER) : ���밪�� �����ִ� �Լ�

*/

SELECT
       ABS(-10)
  FROM
       DUAL;
       
--------------------------------------------------------------------------------

/*
MOD
 - MOD(NUMBER1, NUMBER2) : �� ���� ���� ���������� ��ȯ
 
 -- NUMBERŸ���� ���ڱ⸸ �ϸ� ����, �Ǽ� ���� ����.
*/

SELECT
       MOD(10,3)
  FROM
       DUAL;
       
SELECT
       MOD(-10, 3)
  FROM
       DUAL;
       
SELECT
       MOD(10.8, 3)
  FROM
       DUAL;
       
SELECT
       10/3
  FROM DUAL; -- ����Ŭ�� �Ǽ� ���굵 �� �ȴ�.������ ���ϰ� �Ǽ��� ����.
  
--------------------------------------------------------------------------------

/*
ROUND
 - ROUND(NUMBER, ���°�ڸ��ݿø�?) : �ݿø� ó�����ִ� �Լ�
 ��ġ : �Ҽ��� �Ʒ� N��° ��ġ�� ������ �� ����.
 ������ �⺻���� 0
*/

SELECT
       ROUND(123.456)
  FROM
       DUAL;
       
SELECT
       ROUND(123.456, 1)
  FROM
       DUAL;
       
SELECT
       ROUND(123.456, 2)
  FROM 
       DUAL;
       
SELECT
       ROUND(123.456, -1)
  FROM
       DUAL; -- -1���� �Ѱ��ָ� �Ҽ��� ���̶�� �ǹ�
       
--------------------------------------------------------------------------------

/*
CEIL
 - CEIL(NUMBER)
: �Ҽ��� �Ʒ��� ���� ������ �ø� ó�����ִ� �Լ�
*/

SELECT
       CEIL(123.456)
  FROM 
       DUAL;
       
/*
FLOOR
- FLOOR(NUMBER) 
: �Ҽ��� �Ʒ��� ���� ������ ����ó�����ִ� �Լ�.
*/

SELECT
       FLOOR(123.456)
  FROM
       DUAL;
       
-- �� �������� ����Ϻ��� ���ñ����� �ٹ� �ϼ� ��ȸ + �����
SELECT
       EMP_NAME,
       CONCAT(FLOOR(SYSDATE - HIRE_DATE), '��') AS "�ٹ�����" -- �Ҽ����Ʒ��� �ú����̹Ƿ� �����ؼ� ��Ÿ�� �� �ִ�(�տ��� ��)
  FROM 
       EMPLOYEE
 WHERE
       FLOOR(SYSDATE - HIRE_DATE) > 365 * 10;
       
-------------------------------

/*
TRUNC
-TRUNC(NUMBER, ��ġ) : ��ġ ���������� ���� ó�� �Լ�
��ġ�� 2 ������ �Ҽ��� �Ʒ� 2���� ����� �ڸ��ٴ� �Ҹ�
*/

SELECT
       TRUNC(123.456, -3)
  FROM
       DUAL;
       
--------------------------------------------------------------------------------

/*
< ��¥ ���� �Լ� > 
DATE Ÿ�� : ��, ��, ��, ��, ��, �ʸ� ��� ������ �ڷ���
*/

-- SYSDATE : ���� �ý��� ��¥ ��ȯ
SELECT
       SYSDATE
  FROM
       DUAL;

--- MONTHS__BETWEEN(DATE1, DATE2) : �� ��¥������ ������ ��ȯ(NUMBERŸ������ ��ȯ, DATE2�� �� �̷��� ��� ������ ���� �� ����)

-- EMPLOYEE ���̺�κ��� �� ����� �����, ����Ϸκ��� �ٹ��ϼ��� �ٹ������� ��ȸ
SELECT
       EMP_NAME,
       TRUNC(SYSDATE - HIRE_DATE),
       FLOOR(MONTHS_BETWEEN(SYSDATE, HIRE_DATE)) || '����' AS "������"
  FROM
       EMPLOYEE;
       
--ADD_MONTHS(DATE, NUMBER) : Ư�� ��¥�� �ش� ���ڸ�ŭ�� ���� ���� ���� ��¥�� ��ȯ(DATEŸ������ ��ȯ)
-- ���ó�¥�κ��� 5���� ��
SELECT
       ADD_MONTHS(SYSDATE, 5)
  FROM
       DUAL;
       
-- ������, �Ի���, �Ի��Ϸκ��� 3������ �귶�� �� ��¥ ��ȸ
SELECT
       EMP_NAME,
       HIRE_DATE,
       ADD_MONTHS(HIRE_DATE, 3)
  FROM
       EMPLOYEE;

-- NEXT_DAY(DATE, ����) : Ư�� ��¥���� ���� ����� ������ ã�� �� ��¥�� ��ȯ
SELECT
       NEXT_DAY(SYSDATE, '�ݿ���')
  FROM
       DUAL;
       
SELECT
       NEXT_DAY(SYSDATE, '��')
  FROM
       DUAL;

SELECT
       NEXT_DAY(SYSDATE, 6) -- �Ͽ��Ϻ��� 1  �����ؼ� 6�̶�� �ϸ� �ݿ���
  FROM
       DUAL;
       
SELECT
       NEXT_DAY(SYSDATE, 'FRIDAY') -- FRIDAY�� �ȵ�. ó�� ��ġ�� �� �ü�� �� ���󰡱� ������ �츮 �ü���� �ѱ���� ���� �ѱ���� ������ �� ��.
  FROM
       DUAL;
-- ������ �� �ʿ䰡 ���� ���� ����
-- ����
ALTER SESSION SET NLS_LANGUAGE = AMERICAN;

SELECT
       NEXT_DAY(SYSDATE, 'FRIDAY') -- ���� �ٲٸ� FRI�� �ǰ� FRIDAY �� ��.
  FROM
       DUAL;

ALTER SESSION SET NLS_LANGUAGE = KOREAN;

-- LAST_DAY(DATE) : ��¥�� ���޹޾Ƽ� �ش� ��¥�� �ִ� ���� ������ ��¥�� ���ؼ� ��ȯ(DATEŸ��)
SELECT
       LAST_DAY(SYSDATE)
  FROM
       DUAL;
       
--------------------------------------------------------------------------------

/*
EXTRACT : �⵵ �Ǵ� �� �Ǵ� �� ������ �����ؼ� ��ȯ(NUMBERŸ��)

- EXTRACT(YEAR FROM DATE) : Ư�� ��¥�κ��� �⵵�� ����
- EXTRACT(MONTH FROM DATE) : Ư�� ��¥�κ��� ���� ����
- EXTRACT(DAY FROM DATE) : Ư�� ��¥�κ��� �ϸ� ����
*/

-- EMPLOYEE���̺�κ��� �����, �Ի�⵵, �Ի��, �Ի��� ��ȸ

SELECT
       EMP_NAME,
       EXTRACT(YEAR FROM HIRE_DATE) || '��' AS "�Ի�⵵",
       EXTRACT(MONTH FROM HIRE_DATE) || '��' AS "�Ի��",
       EXTRACT(DAY FROM HIRE_DATE) || '��' AS "�Ի���"
  FROM
       EMPLOYEE;

--------------------------------------------------------------------------------

/*
< ����ȯ �Լ� >

NUMBER / DATE => CHARACTER

- TO_CHAR(NUMBER/ DATE, ����) : ������ �Ǵ� ��¥�� �����͸� ������ ������Ÿ������ ��ȯ

*/

SELECT
       TO_CHAR(1234)
  FROM
       DUAL; --> 1234�����µ� ���ڰ� �ƴϰ� ����Ÿ���� ��
       
       
SELECT
       TO_CHAR(1234, '000000')
  FROM 
       DUAL; --> 001234, LPAD�̶� ���
-- : �ڸ������� ū ������ 0���� ä��

SELECT
       TO_CHAR(1234,'999999')
  FROM
       DUAL; -->  999.. �ϸ� �� �ڸ����� ���鹮�ڷ� ä����
       -->'  1234' �ڸ������� ū ������ ���鹮�ڷ� ä��

SELECT
       TO_CHAR(1234, 'L00000')
  FROM
       DUAL; -- ��1234�� ����. ���� ������ ����(LOCAL)�� ȭ�����. �� ��ǻ�� �ü���� �ѱ����̹Ƿ� �̱��� ��ǻ�� �������� Ȯ���ص� ��ȭ�� ���´�.
       
SELECT
       TO_CHAR(123124124, 'L999,999,999,999')
  FROM
       DUAL;
       
SELECT
       EMP_NAME,
       TO_CHAR(SALARY, '999,999,999') || '��'
  FROM
       EMPLOYEE;
       
--------------------------------------------------------------------------------

-- DATE(����Ͻú���) => CHARACTER
SELECT
       TO_CHAR(SYSDATE)
  FROM
       DUAL; -- �׳� ��¥��°� �����غ������� ���ڵ�����(CHARACTER)Ÿ���� �� ��.
       
    
SELECT
       TO_CHAR(SYSDATE, 'YYYY-MM-DD')
  FROM
       DUAL; -- 2024-10-15
       
       
SELECT
        TO_CHAR(SYSDATE, 'PM HH:MI:SS') -- MONTH�� MM MINUTE�� MI
  FROM
       DUAL; -- PM�� ����/ ���ĸ� ���, �����̸� ����, ���ĸ� ���ķ� ����.
       
SELECT
       TO_CHAR(SYSDATE, 'HH24:MI:SS')
  FROM
       DUAL; -- 16:28:01 : HH24�� 24�ð�����
       
       
SELECT
       TO_CHAR(SYSDATE, 'MON DY, YYYY')
  FROM
       DUAL; -- 10�� ȭ, 2024 : MON -��, DY �� ����, 
       
--------------------------------------------------------------------------------

-- ������ �� �� �ִ� ����
SELECT
       TO_CHAR(SYSDATE, 'YYYY'),
       TO_CHAR(SYSDATE, 'RRRR'), -- �� �� ������ ��Ÿ���� RR�� RR'�� *** �˻��Ұ�, 50 �̸��̸� 2000��� YY�� 2000 �ĸ� �ǹ���. ������ �׳� �� YYYY���� ��.
       TO_CHAR(SYSDATE, 'YY'),
       TO_CHAR(SYSDATE, 'RR'),
       TO_CHAR(SYSDATE, 'YEAR') -- TWENTY TWENTY-FOUR
  FROM
       DUAL;

-- ���� ����� �� �ִ� ����
SELECT
       TO_CHAR(SYSDATE, 'MM'), 
       TO_CHAR(SYSDATE, 'MON'), -- �ڿ� '��'�� ���� ����
       TO_CHAR(SYSDATE, 'MONTH'), -- �굵 �ڿ� �� ���� ����
       TO_CHAR(SYSDATE, 'RM') -- �θ����ڷ� ǥ�� X ����
  FROM
       DUAL;
       
-- �Ϸ� ����� �� �ִ� ����
SELECT
       TO_CHAR(SYSDATE, 'DD'), -- �Ѵޱ������� 1�Ϻ��� 15��°
       TO_CHAR(SYSDATE, 'D') -- 3�̶�� ���� �����ϱ������� �Ͽ��Ϻ��� ȭ�����̶� �Ͽ�ȭ �ؼ� 3��°��� ��.
       TO_CHAR(SYSDATE, 'DDD'); -- 289, 1�� �������� 1��1�Ϻ��� ��ĥ°����
  FROM
       DUAL;
       
-- ���Ͽ� ����� �� �ִ� ����
SELECT
       TO_CHAR(SYSDATE, 'DAY'), -- ȭ����
       TO_CHAR(SYSDATE, 'DY') -- ȭ / A�� ������ �ǹ���
  FROM
       DUAL;
       
-- EMPLOYEE���̺��� �����, �Ի���
SELECT
       EMP_NAME,
       TO_CHAR(HIRE_DATE, 'YYYY"��"-MM"��"-DD"��" (DY)') -- �ѱ��� ���̿� �ְ� ������ ""�� ���� �־�����Ѵ�.
  FROM
       EMPLOYEE;
    --> �ѱ� �������� ��� �ֵ���ǥ�� �����־�߸� ��� ����
    
--------------------------------------------------------------------------------
/*

NUMBER / CHARACTER => DATE
 - TO_DATE(NUMBER / CHARACTER, ����) : ������ �Ǵ� ������ �����͸� �����ϸ� ��¥������ ��ȯ(DATEŸ�� ��ȯ)
*/

SELECT
       TO_DATE(20241015)
  FROM
       DUAL; -- �⺻������ YY/MM/DD ���·� ��ȯ�ȴ�. 24/10/15
       
SELECT
       TO_DATE('20241015')
  FROM 
       DUAL;     -- �⺻������ YY/MM/DD�� ��ȯ�� �ȴ�
       
SELECT
       TO_DATE(000112)
  FROM
       DUAL; -- 2000������ �ٲ��� �ʰ� ������ ��. NUMBER TYPE�̱� ����. 000�� �տ� �����Ƿ� 112��� �ν��ؼ� ������ ��.
       
SELECT
       TO_DATE('000112')
  FROM
       DUAL;  -- ''�� �ٿ��� ���� ����ǥ�� �����־�߸� ������ ���� ����
       
SELECT
       TO_DATE('240607')
  FROM
       DUAL;
       
SELECT
       TO_DATE('980607', 'RRMMDD') -- RR�� ����ϸ� 2098�� �ƴ϶� 1998�̶�� �ν�
  FROM
       DUAL;
    --> �� �ڸ� �⵵�� ���ؼ� RR������ ������ ��� => 50 �̻��̸� ���� ����, 50�̸��̸� ���� ���⸦ �ǹ��Ѵ�.

--------------------------------------------------------------------------------

/*
CHARACTER => NUMBER
 - TO_NUMBER(CHARACTER, ����) : ������ �����͸� ���������� ��ȯ(NUMBERŸ������ ��ȯ)
*/

SELECT
       TO_NUMBER('01234')
  FROM
       DUAL;
       
SELECT
       '123' + '234'
  FROM
       DUAL; -- ���ڷ� �ߴµ� ���ڷ� �������.
       --> �ڵ����� NUMBERŸ������ ��ȯ�ؼ� ���������� ����
       
SELECT
       '44,000' + '52,000'
  FROM
       DUAL; -- ���� �ȵ�. ����(,)�� ���ԵǾ� �ֱ� ������ �ڵ�����ȯ�� �Ұ���
       
SELECT
       TO_NUMBER('44,000', '99,999') + TO_NUMBER('52,000', '99,999')
  FROM
       DUAL;
       
--------------------------------------------------------------------------------

/*

< NULL ó�� �Լ� >
NVL(�÷���, �ش� �÷����� NULL�� ��� ��ȯ�� �����)
NVL : NULL VALUE��� ��
--> �ش� �÷��� ���� ������ ��� �÷��� �״�� ��ȯ, �ش� �÷��� ���� NULL�� ��� �� ��° ���ڷ� ������ ���� ��������� ��ȯ��

*/
       
-- EMPLOYEE���̺�κ��� �����, ���ʽ�
SELECT
       EMP_NAME,
       BONUS,
       NVL(BONUS, 0) -- BONUS�÷� ���� NULL�̸� 0�� ��ȯ
  FROM
       EMPLOYEE;

-- ���ʽ� ���� ���� ��ȸ
SELECT
       EMP_NAME,
       SALARY * (1 + NVL(BONUS, 0)) * 12 AS ���� 
  FROM
       EMPLOYEE;
       
-- EMPLOYEE���̺�κ��� �����, �μ��ڵ� ��ȸ
SELECT
       EMP_NAME,
       NVL(DEPT_CODE, '�μ� ����')
  FROM  
       EMPLOYEE;

-- NVL2(�÷���, �����1, �����2)
-- �ش� �÷��� ���� ������ ��� �����1�� ��ȯ
-- �ش� �÷��� ���� NULL�� ��� �����2�� ��ȯ

-- �����, �μ��ڵ�, �μ��ڵ尡�����ϴ� ��� '�μ���ġ�Ϸ�', NULL�� ��� '�μ�����'���� ��ȸ
SELECT
       EMP_NAME,
       DEPT_CODE,
       NVL2(DEPT_CODE, '�μ���ġ�Ϸ�', '�μ�����')
  FROM
       EMPLOYEE;

-- NULLIF(�񱳴��1, �񱳴��2)
-- �� ���� ���� ������ ��� NULL ��ȯ
-- �� ���� ���� �������� ���� ��� �񱳴��1�� ��ȯ

SELECT
       NULLIF('1', '1')
  FROM
       DUAL; -- ������ NULL
       
SELECT
       NULLIF('1', '2')
  FROM  
       DUAL; -- �� ������ 1

--------------------------------------------------------------------------------

/*

 < �����Լ� >
 
 DECODE(�񱳴��(�÷���/ ���������/ �Լ��� / ...), ���ǰ�1, �����1, ���ǰ�2, �����2, ���ǰ�3, �����3, .... , ����Ʈ�����);
  - �ڹٿ��� switch�� ����
 - ������ ����Ʈ������� ���� ���� 
*/

-- EMPLOYEE���̺�κ��� �����, ����(��/��)
SELECT
       EMP_NAME,
       DECODE(SUBSTR(EMP_NO, 8, 1), 1, '��', 2, '��') AS "����"
  FROM
       EMPLOYEE;
        
        
-- �������� �޿� �λ���Ѽ� ��ȸ
-- �����ڵ尡 'J7'�� ������� �޿��� 10%�λ��ؼ� ��ȸ
-- �����ڵ尡 'J6'�� ������� �޿��� 15%�λ��ؼ� ��ȸ
-- �����ڵ尡 'J5'�� ������� �޿��� 20%�λ��ؼ� ��ȸ
-- �� �� �����ڵ� ������� �޿��� 5%�λ��ؼ� ��ȸ

SELECT
       EMP_NAME,
       SALARY,
       LPAD(JOB_CODE, 5),
       DECODE(JOB_CODE, 'J7', SALARY * 1.1, 'J6', SALARY * 1.15, 'J5', SALARY * 1.2, SALARY * 1.05) AS "�λ�ȱ޿�"
  FROM
       EMPLOYEE;
        
--------------------------------------------------------------------------------

/*

CASE WHEN THEN
- DECODE �����Լ��� ������ �� DECODE�� �ش� ���ǰ˻� �� ����񱳸��� ����
- CASE WHEN THEN�������� Ư�� ���� ���� �� ������� ���ǽ� ��� ����

--> �ڹٿ����� if - else if�� ���� ����

[ǥ����]
CASE
    WHEN ���ǽ�1 THEN �����1(���� ���)
    WHEN ���ǽ�2 THEN �����2
    ...
    ELSE ����� (�� ���ǿ� ��� �������� ������ ��)
END 

*/
      -- ���� DECODE  
SELECT        
       EMP_NAME,
       DECODE(SUBSTR(EMP_NO, 8, 1), 1, '��', 2, '��', '���� ���� ����') AS "����"
  FROM
       EMPLOYEE;
       
-- CASE WHEN THEN
SELECT
       EMP_NAME,
       CASE
        WHEN SUBSTR(EMP_NO, 8, 1) = '1' THEN '��'
        WHEN SUBSTR(EMP_NO, 8, 1) = '2' THEN '��'
        ELSE '�������þ���'
       END
  FROM
       EMPLOYEE;
       
--------------------------------------------------------------------------------


-- �������Լ��� �׷��Լ��� �Բ� ����� �� ����. : ��� ���� ������ �ٸ��� ����.
--------------------------------< �׷� �Լ� >-------------------------------------
/*
N���� ���� �о 1���� ����� ��ȯ(�ϳ��� �׷캰�� �Լ� ������ ��ȯ)
*/
-- 1. SUM(����Ÿ��) : �ش� �÷������� �� �հ踦 ��ȯ���ִ� �Լ�

SELECT
       TO_CHAR(SUM(SALARY), 'L999,999,999')
  FROM
       EMPLOYEE;
       
-- �μ��ڵ尡 'D5'�� ������� �� �޿��հ�
SELECT
       SUM(SALARY)
 FROM
       EMPLOYEE
 WHERE
       DEPT_CODE = 'D5';
       
       
--------------------------------------------------------------------------------

-- 2. AVG(����Ÿ��) : �ش� �÷������� ��հ��� ���ؼ� ��ȯ
-- ��ü ������� �޿�
SELECT
       ROUND(AVG(SALARY)) -- �Ҽ��� �� ��° �ڸ� �ݿø����� �� ���� 1��°���� �ݿø��ؼ� ������.
  FROM
       EMPLOYEE;
       
--------------------------------------------------------------------------------

-- 3. MIN(ANY Ÿ��) : �ش� �÷����� �� ���� ���� �� ��ȯ
SELECT
       MIN(SALARY) "���� ���� �޿���",
       MIN(EMP_NAME) "���� ���� �̸�",
       MIN(HIRE_DATE) "���� ���� �Ի���"
  FROM 
       EMPLOYEE;
    --> �ٸ� �� ���������� ����켱/ ������ ����鳢���� �����ڵ����/ 
    

-- 4. MAX(ANY TYPE) : �ش� �÷����� �� ���� ū �� ��ȯ
SELECT
       MAX(SALARY) "���� ���� �޿�",
       MAX(EMP_NAME) "���� ���� �̸�",
       MAX(HIRE_DATE) "���� ���� �Ի���"
  FROM
       EMPLOYEE;
       
       
-- 5. COUNT(*/ �÷���/ DISTINST �÷���) : �� ������ ���� ��ȯ
-- COUNT(*) : ��ȸ����� �ش��ϴ� ��� �� ������ �� ���� ��ȯ
-- COUNT(�÷���) : ������ �ش� �÷����� NULL�� �ƴ� �ุ ������ ���� ��ȯ
-- COUNT(DISTINCT �÷���) : ������ �ش� �÷����� �ߺ����� ������ ��� �ϳ��θ� ���� ��ȯ

-- ��ü ������� �� ������ ��ȸ
SELECT
       COUNT(*)
  FROM
       EMPLOYEE;
       
-- ����� �����ϴ� ����� ��
SELECT
       COUNT(MANAGER_ID)
  FROM
       EMPLOYEE; -- �ڵ����� NULL�� �ƴ� �ุ ���� �˷���
       
SELECT
       COUNT(*)
  FROM
       EMPLOYEE
 WHERE
       MANAGER_ID IS NOT NULL; -- ���� ���� �� ���� ����. ���꼺 �⼺(�����غ�!)
       
-- ���� ������� �����ִ� �μ� ����
SELECT COUNT(DISTINCT DEPT_CODE)
  FROM EMPLOYEE;
        
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       
