-- DDL 연습할 새로운 계정 생성
-- CREATE USER 사용자이름 INDENTIFIED BY 비밀번호;
CREATE USER DDL IDENTIFIED BY DDL;

-- 최소한의 권한 부여
-- GRANT 권한 또는 롤, 권한 또는 롤, ...  TO 사용자이름
GRANT CONNECT, RESOURCE TO DDL;