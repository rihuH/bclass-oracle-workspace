CREATE TABLE BOARD(
    BOARD_NO NUMBER PRIMARY KEY,
    BOARD_TITLE VARCHAR2(50) NOT NULL,
    BOARD_CONTENT VARCHAR2(4000),
    BOARD_WRITER NUMBER(20) NOT NULL REFERENCES MEMBER,
    CREATE_DATE DATE DEFAULT SYSDATE,
    DELETE_STATUS CHAR(1) DEFAULT 'N' CHECK(DELETE_STATUS IN ('Y', 'N')) 
);

CREATE SEQUENCE SEQ_BOARDNO;
INSERT INTO BOARD VALUES(SEQ_BOARDNO.NEXTVAL, '�Խñ� �׽�Ʈ', '�׽�Ʈ�Դϴ�.', 1, SYSDATE, DEFAULT);
INSERT INTO BOARD VALUES(SEQ_BOARDNO.NEXTVAL, '�ι�° ��', '�̸��̴�~~', 2, SYSDATE, DEFAULT);
INSERT INTO BOARD VALUES(SEQ_BOARDNO.NEXTVAL, '���� ���~', '����̴�����', 3, SYSDATE, DEFAULT);

SELECT * FROM BOARD;
SELECT BOARD_NO, BOARD_TITLE, BOARD_CONTENT, USERNAME FROM BOARD JOIN MEMBER ON (USERNO = BOARD_WRITER);
COMMIT;

DROP TABLE TB_MEMBER;
CREATE TABLE TB_MEMBER(
    NAME VARCHAR2(12) PRIMARY KEY,
    WIN NUMBER DEFAULT 0,
    LOSE NUMBER DEFAULT 0,
    WINNING_RATE NUMBER DEFAULT 0,
    MONEY NUMBER DEFAULT 5000
);
SELECT * FROM TB_MEMBER;
INSERT INTO TB_MEMBER VALUES ('������', 100, 0, 100, 1000000);

ALTER TABLE TB_MEMBER MODIFY WINNING_RATE DEFAULT 0;
COMMIT;