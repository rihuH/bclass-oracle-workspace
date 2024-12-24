
DROP TABLE MEMBER;
DROP TABLE NOTICE;
DROP TABLE BOARD;
DROP TABLE REPLY;

DROP SEQUENCE SEQ_NNO;      -- 공지사항번호 발생시킬 시퀀스
DROP SEQUENCE SEQ_BNO;      -- 게시판번호 발생시킬 시퀀스
DROP SEQUENCE SEQ_RNO;      -- 댓글번호 발생시킬 시퀀스


--------------------------------------------------
--------------     MEMBER 관련	------------------	
--------------------------------------------------

CREATE TABLE MEMBER (            
  USER_ID VARCHAR2(30) PRIMARY KEY,   
  USER_PWD VARCHAR2(100) NOT NULL,  
  USER_NAME VARCHAR2(15) NOT NULL,            
  EMAIL VARCHAR2(100),   
  GENDER VARCHAR2(1) CHECK (GENDER IN('M', 'F')),
  AGE NUMBER,
  PHONE VARCHAR2(13),
  ADDRESS VARCHAR2(100),
  ENROLL_DATE DATE DEFAULT SYSDATE,
  MODIFY_DATE DATE DEFAULT SYSDATE,
  STATUS VARCHAR2(1) DEFAULT 'Y' CHECK (STATUS IN('Y', 'N'))
);

COMMENT ON COLUMN MEMBER.USER_ID IS '회원아이디';
COMMENT ON COLUMN MEMBER.USER_PWD IS '회원비밀번호';
COMMENT ON COLUMN MEMBER.USER_NAME IS '회원이름';
COMMENT ON COLUMN MEMBER.EMAIL IS '회원이메일';
COMMENT ON COLUMN MEMBER.GENDER IS '회원성별';
COMMENT ON COLUMN MEMBER.AGE IS '회원나이';
COMMENT ON COLUMN MEMBER.PHONE IS '회원전화번호';
COMMENT ON COLUMN MEMBER.ADDRESS IS '회원주소';
COMMENT ON COLUMN MEMBER.ENROLL_DATE IS '회원가입날짜';
COMMENT ON COLUMN MEMBER.MODIFY_DATE IS '회원수정날짜';
COMMENT ON COLUMN MEMBER.STATUS IS '회원상태값';

INSERT INTO MEMBER
VALUES ('admin', '1234', '관리자', 'admin@kh.or.kr', 'F', 30, '010-1111-2222', '서울시 성동구 용답동', '20240101', '20240601', DEFAULT);

INSERT INTO MEMBER
VALUES ('user01', 'pass01', '홍길동', 'user01@kh.or.kr', 'M', 25, '010-3333-4444', '서울시 마포구 공덕동', '20240201', '20240602', DEFAULT);

INSERT INTO MEMBER
VALUES ('user02', 'pass02', '김말똥', 'user02@kh.or.kr', 'F', 23, '010-5555-6666', '서울시 영등포구 양평동', '20240301', '20240603', DEFAULT);


--------------------------------------------------
--------------     NOTICE 관련	-------------------
--------------------------------------------------

CREATE TABLE NOTICE(
  NOTICE_NO NUMBER PRIMARY KEY,
  NOTICE_TITLE VARCHAR2(30) NOT NULL,
  NOTICE_WRITER VARCHAR2(30) NOT NULL,
  NOTICE_CONTENT VARCHAR2(200) NOT NULL,
  CREATE_DATE DATE DEFAULT SYSDATE,
  FOREIGN KEY(NOTICE_WRITER) REFERENCES MEMBER ON DELETE CASCADE
);

COMMENT ON COLUMN NOTICE.NOTICE_NO IS '공지사항번호';
COMMENT ON COLUMN NOTICE.NOTICE_TITLE IS '공지사항제목';
COMMENT ON COLUMN NOTICE.NOTICE_WRITER IS '공지사항작성자아이디';
COMMENT ON COLUMN NOTICE.NOTICE_CONTENT IS '공지사항내용';
COMMENT ON COLUMN NOTICE.CREATE_DATE IS '공지사항작성날짜';

CREATE SEQUENCE SEQ_NNO NOCACHE;

INSERT INTO NOTICE
VALUES (SEQ_NNO.NEXTVAL, '관리자 공지', 'admin', '공지서비스를 게시합니다. 많이 이용해 주세요', '20240603');

INSERT INTO NOTICE
VALUES (SEQ_NNO.NEXTVAL, '공지서비스 오픈 환영', 'admin', '드디어 오픈되었군요. 많이 이용하겠습니다.', '20240603');

INSERT INTO NOTICE
VALUES (SEQ_NNO.NEXTVAL, '공지서비스 이용 안내', 'admin', '공지서비스는 회원만 이용할 수 있습니다. 회원 가입하세요.', '20240603');


----------------------------------------------------
----------------     BOARD 관련     -----------------
----------------------------------------------------

CREATE TABLE BOARD(
  BOARD_NO NUMBER PRIMARY KEY,
  BOARD_TITLE VARCHAR2(100) NOT NULL,
  BOARD_WRITER VARCHAR2(4000) NOT NULL,
  BOARD_CONTENT VARCHAR2(4000) NOT NULL,
  ORIGIN_NAME VARCHAR2(100),
  CHANGE_NAME VARCHAR2(100),
  COUNT NUMBER DEFAULT 0,
  CREATE_DATE DATE DEFAULT SYSDATE,
  STATUS VARCHAR2(1) DEFAULT 'Y' CHECK (STATUS IN ('Y', 'N')),
  FOREIGN KEY (BOARD_WRITER) REFERENCES MEMBER ON DELETE CASCADE
);

COMMENT ON COLUMN BOARD.BOARD_NO IS '게시글번호';
COMMENT ON COLUMN BOARD.BOARD_TITLE IS '게시글제목';
COMMENT ON COLUMN BOARD.BOARD_WRITER IS '게시글작성자아이디';
COMMENT ON COLUMN BOARD.BOARD_CONTENT IS '게시글내용';
COMMENT ON COLUMN BOARD.ORIGIN_NAME IS '첨부파일원래이름';
COMMENT ON COLUMN BOARD.CHANGE_NAME IS '첨부파일변경이름';
COMMENT ON COLUMN BOARD.COUNT IS '게시글조회수';
COMMENT ON COLUMN BOARD.CREATE_DATE IS '게시글작성날짜';
COMMENT ON COLUMN BOARD.STATUS IS '게시글상태값';

CREATE SEQUENCE SEQ_BNO NOCACHE;

INSERT INTO BOARD
VALUES (SEQ_BNO.NEXTVAL, '관리자 게시글', 'admin', '저희 사이트를 이용해 주셔서 감사합니다.', NULL, NULL, DEFAULT, DEFAULT, DEFAULT);

INSERT INTO BOARD
VALUES (SEQ_BNO.NEXTVAL, 'JAVA란?', 'user01', '답안을 채워 넣어 주시기 바랍니다.', NULL, NULL, DEFAULT, DEFAULT, DEFAULT);

INSERT INTO BOARD
VALUES (SEQ_BNO.NEXTVAL, 'ORACLE은 무엇인가요', 'user02', '답안을 채워 넣어 주시기 바랍니다.', NULL, NULL, DEFAULT, DEFAULT, DEFAULT);

INSERT INTO BOARD
VALUES (SEQ_BNO.NEXTVAL, 'JDBC', 'admin', '답안을 채워 넣어 주시기 바랍니다.', NULL, NULL, DEFAULT, DEFAULT, DEFAULT);

INSERT INTO BOARD
VALUES (SEQ_BNO.NEXTVAL, 'HTML로 화면을 만들어봅시다!', 'admin', '답안을 채워 넣어 주시기 바랍니다.', NULL, NULL, DEFAULT, DEFAULT, DEFAULT);

INSERT INTO BOARD
VALUES (SEQ_BNO.NEXTVAL, 'CSS란?', 'user01', '답안을 채워 넣어 주시기 바랍니다.', NULL, NULL, DEFAULT, DEFAULT, DEFAULT);

INSERT INTO BOARD
VALUES (SEQ_BNO.NEXTVAL, 'JavaScript 랑 Java 는 비슷한가요?', 'user02', '답안을 채워 넣어 주시기 바랍니다.', NULL, NULL, DEFAULT, DEFAULT, DEFAULT);

INSERT INTO BOARD
VALUES (SEQ_BNO.NEXTVAL, 'jQuery', 'user02', '답안을 채워 넣어 주시기 바랍니다.', NULL, NULL, DEFAULT, DEFAULT, DEFAULT);

INSERT INTO BOARD
VALUES (SEQ_BNO.NEXTVAL, 'JSP', 'user01', '답안을 채워 넣어 주시기 바랍니다.', NULL, NULL, DEFAULT, DEFAULT, DEFAULT);

INSERT INTO BOARD
VALUES (SEQ_BNO.NEXTVAL, 'Servlet 은 뭐죠?', 'admin', '답안을 채워 넣어 주시기 바랍니다.', NULL, NULL, DEFAULT, DEFAULT, DEFAULT);

INSERT INTO BOARD
VALUES (SEQ_BNO.NEXTVAL, 'EL을 이용하면 편리해요', 'admin', '답안을 채워 넣어 주시기 바랍니다.', NULL, NULL, DEFAULT, DEFAULT, DEFAULT);

INSERT INTO BOARD
VALUES (SEQ_BNO.NEXTVAL, 'JSTL을 쓸려면 뭘 해야하죠?', 'user01', '답안을 채워 넣어 주시기 바랍니다.', NULL, NULL, DEFAULT, DEFAULT, DEFAULT);

INSERT INTO BOARD
VALUES (SEQ_BNO.NEXTVAL, 'Framework 의 종류', 'user01', '답안을 채워 넣어 주시기 바랍니다.', NULL, NULL, DEFAULT, DEFAULT, DEFAULT);

INSERT INTO BOARD
VALUES (SEQ_BNO.NEXTVAL, 'MyBatis..', 'user02', '답안을 채워 넣어 주시기 바랍니다.', NULL, NULL, DEFAULT, DEFAULT, DEFAULT);

INSERT INTO BOARD
VALUES (SEQ_BNO.NEXTVAL, 'Spring!', 'user01', '답안을 채워 넣어 주시기 바랍니다.', NULL, NULL, DEFAULT, DEFAULT, DEFAULT);

INSERT INTO BOARD
VALUES (SEQ_BNO.NEXTVAL, '공부를 합시다.', 'admin', '공부하세요.', NULL, NULL, DEFAULT, DEFAULT, DEFAULT);


----------------------------------------------------
---------------     REPLY 관련    -------------------	
----------------------------------------------------

CREATE TABLE REPLY(
  REPLY_NO NUMBER PRIMARY KEY,
  REPLY_CONTENT VARCHAR2(400) NOT NULL,
  REF_BNO NUMBER NOT NULL,
  REPLY_WRITER VARCHAR2(30) NOT NULL,
  CREATE_DATE DATE DEFAULT SYSDATE NOT NULL,
  STATUS VARCHAR2(1) DEFAULT 'Y' CHECK (STATUS IN ('Y', 'N')),
  FOREIGN KEY (REF_BNO) REFERENCES BOARD(BOARD_NO),
  FOREIGN KEY (REPLY_WRITER) REFERENCES MEMBER ON DELETE CASCADE
);

COMMENT ON COLUMN REPLY.REPLY_NO IS '댓글번호';
COMMENT ON COLUMN REPLY.REPLY_CONTENT IS '댓글내용';
COMMENT ON COLUMN REPLY.REF_BNO IS '참조게시글번호';
COMMENT ON COLUMN REPLY.REPLY_WRITER IS '댓글작성자아이디';
COMMENT ON COLUMN REPLY.CREATE_DATE IS '댓글작성날짜';
COMMENT ON COLUMN REPLY.STATUS IS '댓글상태값';

CREATE SEQUENCE SEQ_RNO NOCACHE;

INSERT INTO REPLY
VALUES (SEQ_RNO.NEXTVAL, '첫번째 댓글입니다.', 1, 'admin', '20240603', DEFAULT);

INSERT INTO REPLY
VALUES (SEQ_RNO.NEXTVAL, '첫번째 댓글입니다.', 13, 'user01', '20240603', DEFAULT);

INSERT INTO REPLY
VALUES (SEQ_RNO.NEXTVAL, '두번째 댓글입니다.', 13, 'user02', '20240603', DEFAULT);

INSERT INTO REPLY
VALUES (SEQ_RNO.NEXTVAL, '세번째 댓글입니다.', 13, 'admin', '20240603', DEFAULT);

COMMIT;