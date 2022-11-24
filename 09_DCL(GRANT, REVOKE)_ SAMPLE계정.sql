-- CREATE TABLE 할 수 있는 권한이 없어서 문제 발생
-- 3_1. CREATE TABLE 권한 부여받기
-- 3_2. TABLESPACE 할당 받기
CREATE TABLE TEST(
    TEST_ID NUMBER PRIMARY KEY,
    TEST_NAME VARCHAR2(10) NOT NULL
); -- 테이블 생성 가능

SELECT * FROM TEST;
INSERT INTO TEST VALUES(10, '안녕'); -- 테이블 조작 가능

--------------------------------------------------------------------------------
-- BR계정의 EMPLOYEE테이블에 접근해서 조회할 수 있는 권한 없음
-- 4. SELECT ON BR.EMPLOYEE 권한 부여받기
SELECT * 
FROM BR.EMPLOYEE;
-- 5. INSERT ON BR.DEPARTMENT 권한 부여받기
INSERT INTO BR.DEPARTMENT VALUES('D0', '회계부', 'L1');

ROLLBACK;