SELECT * FROM MEMBER;

SELECT * FROM BOARD ORDER BY BOARD_NO DESC;

-- 페이징 처리 위해 10개씩 조회하기
SELECT RNUM, 
       BOARD_NO,
       CATEGORY_NAME,
       BOARD_TITLE,
       USER_ID,
       COUNT,
       CREATE_DATE    
FROM (SELECT 
       ROWNUM RNUM, 
       BOARD_NO,
       CATEGORY_NAME,
       BOARD_TITLE,
       USER_ID,
       COUNT,
       CREATE_DATE
  FROM (SELECT
           BOARD_NO,
           CATEGORY_NAME,
           BOARD_TITLE,
           USER_ID,
           COUNT,
           CREATE_DATE
      FROM
           BOARD
      JOIN
           CATEGORY USING (CATEGORY_NO)
      JOIN
           MEMBER ON (BOARD_WRITER = USER_NO)
     WHERE 
           BOARD_TYPE = 1
       AND
           BOARD.STATUS = 'Y'
     ORDER
        BY
           CREATE_DATE DESC))
 WHERE
       RNUM BETWEEN 11 AND 20;
-- ROWNUM을 11부터 20하면 결과가 안 나온다. 1-10, 1-20은 안된다. 
-- 오라클 자체 문제인데, ROWNUM으로 BETWEEN AND 하면 무조건 1부터밖에 시작할 수 없다. 2도 안되고 1만 됨.
-- 문제 원인은 이름이 ROWNUM이어서 그런 것, 별칭을 달아주어야 한다.
-- 그런데 별칭은 실행순서때문에 또 안되니까
-- 인라인뷰 안에 인라인뷰

SELECT CATEGORY_NO, CATEGORY_NAME FROM CATEGORY;
       
SELECT * FROM ATTACHMENT;
SELECT * FROM NOTICE;
SELECT 
			   NOTICE_NO, 
			   NOTICE_TITLE, 
			   NOTICE_CONTENT, 
			   NOTICE_WRITER, 
			   COUNT, 
			   CREATE_DATE 
		  FROM 
		  	   NOTICE 
		 WHERE 
		 	   STATUS = 'Y'
		 ORDER
		    BY
		       NOTICE_NO DESC;
               commit;
SELECT BOARD_NO, BOARD_TITLE, COUNT, 
FILE_PATH||'/'||CHANGE_NAME AS "IMAGEPATH" 
FROM BOARD JOIN ATTACHMENT ON (BOARD_NO = REF_BNO) WHERE BOARD_TYPE = 2 AND FILE_LEVEL = 1 AND BOARD.STATUS = 'Y' ORDER BY BOARD_NO DESC;
-- CONCAT은 2개만 인자를 받을 수 있고 ||는 여러 개를 합칠 수 있다

INSERT INTO REPLY VALUES(SEQ_RNO.NEXTVAL, '내가 일등이당~~', 113, 1, SYSDATE, 'Y');
INSERT INTO REPLY VALUES(SEQ_RNO.NEXTVAL, '내가 이등이당~~', 113, 2, SYSDATE, 'Y');
INSERT INTO REPLY VALUES(SEQ_RNO.NEXTVAL, '내가 삼등이당~~', 113, 3, SYSDATE, 'Y');

COMMIT;

SELECT * FROM REPLY;

        SELECT 
			   BOARD_NO AS boardNo, 
			   BOARD_TITLE AS boardTitle, 
			   M1.USER_ID AS boardWriter, 
			   COUNT, 
			   BOARD.CREATE_DATE createDate, 
               BOARD_CONTENT AS boardContent,
               REPLY_NO AS replyNo,
               M1.USER_ID  AS replyWriter,
               REPLY_CONTENT AS replyContent,
               REPLY.CREATE_DATE AS replyDate
		  FROM 
		  	   BOARD
          LEFT
		  JOIN
		  	   MEMBER M1 ON (USER_NO = BOARD_WRITER) 
          LEFT
          JOIN
               REPLY ON(BOARD_NO = REF_BNO)
          LEFT
          JOIN
               MEMBER M2 ON (REPLY_WRITER = M2.USER_NO)
		 WHERE 
		 	   BOARD_NO = 120
		   AND
		   	   BOARD_TYPE = 1 
		   AND 
		   	   BOARD.STATUS = 'Y'
         ORDER
            BY
               REPLY.CREATE_DATE DESC;
            
SELECT BOARD_NO, USER_ID, BOARD_TITLE, CREATE_DATE, COUNT FROM BOARD JOIN MEMBER ON (BOARD_WRITER = USER_NO) WHERE BOARD.STATUS = 'Y' AND BOARD_TITLE LIKE '%니다%';
