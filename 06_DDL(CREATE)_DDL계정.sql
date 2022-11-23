/*
    * DDL (DATA DEFINITION LANGUAGE) : 데이터 정의 언어
    오라클에서 제공하는 객체를 새로이 만들고(CREATE), 구조를 변경하고(ALTER), 구조 자체를 삭제(DROP)하는 언어
    실제 데이터 값이 아닌 구조 자체를 정의하는 언어
    주로 DB관리자, 설계자가 사용함
    
    오라클에서의 객체(구조) : 테이블(TABLE), 뷰(VIEW), 시퀀스(SEQUENCE),
                          인덱스(INDEX), 패키지(PACKAGE), 트리거(TRIGGER),
                          프로시저(PROCEDURE), 함수(FUNCTION), 동의어(SYNONYM), 사용자(USER)
                          
    < CREATE >
    객체를 새로이 생성하는 구문
    
    1. 테이블 생성
    - 테이블(TABLE) : 행(ROW)과 열(COLUMN)로 구성되는 가장 기본적인 데이터베이스 객체
                     모든 데이터들은 테이블에 저장됨
                     
    [표현법]
    CREATE TABLE 테이블명 (
        컬럼명 자료형(크기),
        컬러명 자료형(크기),
        컬럼명 자료형,
        ...
    );
    
    * 자료형
    - 문자 (CHAR(바이트크기) | VARCHAR2(바이트크기))    => 반드시 크기지정
      > CHAR : 최대 2000바이트까지 지정 가능 / 고정 길이 (지정한 크기보다 더 적은 값이 들어오면 빈 공간을 공백으로라도 채움)
               고정된 글자수의 데이터만이 담길 경우 사용
      > VARCHAR2 : 최대 4000바이트까지 지정 가능 / 가변 길이 (담긴 값에 따라서 공간의 크기 맞춰짐)
                   몇 글자의 데이터가 들어올지 모를 경우 사용
                   
    - 숫자 (NUMBER)
    - 날짜 (DATE)
*/

--> 회원에 대한 데이터를 담기 위한 테이블 MEMBER 생성하기
CREATE TABLE MEMBER(
    MEM_NO NUMBER,
    MEM_ID VARCHAR2(20),
    MEM_PWD VARCHAR2(20),
    MEM_NAME VARCHAR2(20),
    GENDER CHAR(3),
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50),
    MEM_DATE DATE
);

SELECT * FROM MEMBER;

-- 데이터 딕셔너리 : 다양한 객체들의 정보를 저장하고 있는 시스템 테이블들
-- [참고] USER_TABLES : 이 사용자가 가지고 있는 테이블들의 전반적인 구조를 확인할 수 있는 시스템 테이블
SELECT * FROM USER_TABLES;
-- [참고] USER_TAB_COLUMNS : 이 사용자가 가지고 있는 테이블들의 모든 컬럼의 구조를 확인할 수 있는 시스템 테이블
SELECT * FROM USER_TAB_COLUMNS;

--------------------------------------------------------------------------------

/*
    2. 컬럼에 주석 달기 (컬럼에 대한 설명)
    
    [표현법]
    COMMENT ON COLUMN 테이블명.컬럼명 IS '주석내용';
    
    >> 잘못 작성했을 경우 수정 후 다시 실행
*/
COMMENT ON COLUMN MEMBER.MEM_NO IS '회원번호';
COMMENT ON COLUMN MEMBER.MEM_ID IS '회원아이디';
COMMENT ON COLUMN MEMBER.GENDER IS '성별(남/여)';
COMMENT ON COLUMN MEMBER.MEM_DATE IS '회원가입일';


-- 테이블에 데이터 추가시키는 구문 (DML : INSERT)
-- INSERT INTO 테이블명 VALUES(값, 값, ...)
INSERT INTO MEMBER VALUES(1, 'user01', 'pass01', '홍길동', '남', '010-1111-2222', 'aaa@naver.com', '22/11/01');
INSERT INTO MEMBER VALUES(2, 'user02', 'pass02', '홍길녀', '여', null, null, SYSDATE);

SELECT * FROM MEMBER;

--------------------------------------------------------------------------------

/*
    < 제약조건 CONSTRAINTS >
    - 원하는 데이터값 (유효한 형식의 값)만 유지하기 위해서 특정 컬럼에 부여하는 제약
    - 데이터 무결성 보장 목적
    
    - 종류 : NOT NULL, UNIQUE, CHECK(조건), PRIMARY KEY, FOREIGN KEY
*/

/*
    * NOT NULL 제약조건
    해당 컬럼에 반드시 값이 존재해야만 할 경우 (즉, 해당 컬럼에 절대 NULL이 들어와서는 안되는 경우)
    삽입 / 수정시 NULL값을 허용하지 않도록 제한
    
    제약조건을 부여하는 방식 크게 2가지 (컬럼레벨방식 / 테이블레벨방식)
    * NOT NULL제약조건은 오로지 컬럼레벨방식밖에 안됨
*/
-- 컬럼레벨방식 : 컬럼명 자료형 제약조건
CREATE TABLE MEM_NOTNULL(
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3),
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50)
);

INSERT INTO MEM_NOTNULL VALUES(1, 'user01', 'pass01', '홍길동', '남', null, null);
INSERT INTO MEM_NOTNULL VALUES(2, 'user02', NULL, '김말순', '여', NULL, 'aaa@naver.com');
--> 의도했던대로 오류남! (NOT NULL 제약조건에 위배되어 오류발생)

INSERT INTO MEM_NOTNULL VALUES(2, 'user01', 'pass02', '김말순', '여', NULL, 'aaa@naver.com');
--> 아이디가 중복되었음에도 불구하고 잘 추가됨

SELECT * FROM MEM_NOTNULL;

--------------------------------------------------------------------------------

/*
    *UNIQUE 제약조건
    해당 컬럼에 중복된 값이 들어가서는 안 될 경우
    컬럼값에 중복값을 제한하는 제약조건
    삽입 / 수정 시 기존에 있던 데이터값 중 중복값이 있을 경우 오류 발생
*/
CREATE TABLE MEM_UNIQUE(
    MEM_NUM NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE, -- 컬럼레벨방식
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3),
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50)
);
DROP TABLE MEM_UNIQUE;

-- 테이블레벨 방식 : 모든 컬럼들 다 나열한 후 마지막에 기술
CREATE TABLE MEM_UNIQUE(
    MEM_NUM NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3),
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50),
    UNIQUE(MEM_ID)  --> 테이블레벨 방식
);
INSERT INTO MEM_UNIQUE VALUES(1, 'user01', 'pass01', '홍길동', null, null, null);
INSERT INTO MEM_UNIQUE VALUES(2, 'user01', 'pass02', '강개똥', null, null, null);
--> UNIQUE 제약조건에 위배되었으므로 INSERT 실패
--> 오류 구문을 제약조건명으로 알려줌 => 쉽게 파악하기 어려움
--> 제약조건 부여시 별도로 제약조건명을 지정해주지 않으면
--  시스템에서 알아서 임의로 제약조건명을 부여해버림

/*
    * 제약조건 부여시 제약조건명까지 지어주는 방법
    
    > 컬럼레벨방식
    CREATE TABLE 테이블명(
        컬럼명 자료형 [CONSTRAINT 제약조건명] 제약조건, 
        컬럼명 자료형,
        ...
    );    
    
    > 테이블레벨방식
    CREATE TABLE 테이블명(
        컬럼명 자료형,
        컬럼명 자료형,
        ...
        [CONSTRAINT 제약조건명] 제약조건(컬럼명)
    );
*/
DROP TABLE MEM_UNIQUE;

CREATE TABLE MEM_UNIQUE(
    MEM_NUM NUMBER CONSTRAINT MEMNO_NN NOT NULL,
    MEM_ID VARCHAR2(20) CONSTRAINT MEMID_NN NOT NULL,
    MEM_PWD VARCHAR2(20) CONSTRAINT MEMPWD_NN NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3),
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50),
    CONSTRAINT MEMID_UQ UNIQUE(MEM_ID)  --> 테이블레벨 방식
);
INSERT INTO MEM_UNIQUE VALUES(1, 'user01', 'pass01', '홍길동', null, null, null);
INSERT INTO MEM_UNIQUE VALUES(2, 'user01', 'pass02', '강개똥', null, null, null);

INSERT INTO MEM_UNIQUE VALUES(2, 'user02', 'pass02', '강개똥', null, null, null);

INSERT INTO MEM_UNIQUE VALUES(3, 'user03', 'pass03', '홍길녀', 'ㅇ', null, null);
--> 성별에 유효한 값이 아닌게 들어와도 잘 INSERT 되어버림

--------------------------------------------------------------------------------

/*
    * CHECK(조건식) 제약조건
    해당 컬럼에 들어올 수 있는 값에 대한 조건을 제시해둘 수 있음
    해당 조건에 만족하는 데이터값만 담길 수 있음
*/
CREATE TABLE MEM_CHECK(
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN ('남', '여')), -- 컬럼레벨방식
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50)
    -- , CHECK(GENDER IN ('남', '여'))    -- 테이블레벨방식
);

INSERT INTO MEM_CHECK
VALUES(1, 'user01', 'pass01', '홍길동', '남', null, null);

INSERT INTO MEM_CHECK
VALUES(2, 'user02', 'pass02', '홍길녀', 'ㅇ', null, null);
--> CHECK 제약조건에 위배되었기 때문에 오류 발생

INSERT INTO MEM_CHECK
VALUES(2, 'user02', 'pass02', '홍길녀', null, null, null);
--> 만일 GENDER 컬럼에 데이터값을 넣고자 할 경우 CHECK제약조건에 만족하는 값을 넣어야함
-- 뿐만 아니라 NULL도 가능

INSERT INTO MEM_CHECK
VALUES(2, 'user03', 'pass03', '강개순', '여', null, null);
--> 회원번호가 동일해도 성공적으로 INSERT 되어버림

--------------------------------------------------------------------------------

/*
    * PRIMARY KEY (기본키) 제약조건
    테이블에서 각 행들을 식별하기 위해 사용될 컬럼에 부여하는 제약조건 (식별자의 역할)
    
    EX) 회원번호, 학번, 사번, 부서코드, 직급코드, 주문번호, 예약번호, 운송장번호, ...
    
    PRIMARY KEY 제약조건을 부여하면 그 칼럼에 자동으로 NOT NULL + UNIQUE 의미
    
    * 유의사항 : 한 테이블당 오로지 한 개만 설정 가능
*/

CREATE TABLE MEM_PRI(
    MEM_NO NUMBER CONSTRAINT MEMNO_PK PRIMARY KEY, --> 컬럼레벨방식
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN ('남', '여')), 
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50)
    --, CONSTRAINT MEMNO_PK PRIMARY KEY(MEM_NO) --> 테이블레벨방식
);
INSERT INTO MEM_PRI
VALUES(1, 'user01', 'pass01', '강개순', '여', '010-2222-3333', null);

INSERT INTO MEM_PRI
VALUES(1, 'user02', 'pass02', '이순신', '남', null, null);
--> 기본키 컬럼에 중복값을 담으려고 할 때 (UNIQUE 제약조건에 위배)

INSERT INTO MEM_PRI
VALUES(null, 'user02', 'pass02', '이순신', '남', null, null);
--> 기본키 컬럼에 NULL을 담으려고 할 때 (NOT NULL 제약조건 위배)

INSERT INTO MEM_PRI
VALUES(2, 'user02', 'pass02', '이순신', '남', null, null);

CREATE TABLE MEM_PRI2(
    MEM_NO NUMBER, 
    MEM_ID VARCHAR2(20),
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN ('남', '여')), 
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50),
    PRIMARY KEY(MEM_NO, MEM_ID) --> 묶어서 PRIMARY KEY 제약조건 부여 (복합키) (테이블레벨방식으로만 가능)
);

INSERT INTO MEM_PRI2 
VALUES(1, 'user01', 'pass01', '홍길동', null, null, null);

INSERT INTO MEM_PRI2 
VALUES(1, 'user02', 'pass02', '홍길녀', null, null, null);

INSERT INTO MEM_PRI2 
VALUES(2, 'user02', 'pass03', '강길동', null, null, null);

INSERT INTO MEM_PRI2 
VALUES(null, 'user02', 'pass03', '강길동', null, null, null);
-- 복합키 각 컬럼에는 절대 NULL 허용하지 않음

-- 복합키 사용 예시 (어떤 회원이 어떤 상품을 언제 찜했는지에 대한 데이터를 보관하는 테이블)
CREATE TABLE TB_LIKE(
    MEM_NO NUMBER,
    PRO_NAME VARCHAR2(10),
    LIKE_DATE DATE,
    PRIMARY KEY(MEM_NO, PRO_NAME)
);

INSERT INTO TB_LIKE VALUES(1, 'A', SYSDATE);
INSERT INTO TB_LIKE VALUES(1, 'B', SYSDATE);
INSERT INTO TB_LIKE VALUES(1, 'A', SYSDATE);

--------------------------------------------------------------------------------

-- 회원등급에 대한 데이터를 따로 보관하는 테이블
CREATE TABLE MEM_GRADE(
    GRADE_CODE NUMBER PRIMARY KEY,
    GRADE_NAME VARCHAR2(30) NOT NULL
);

INSERT INTO MEM_GRADE VALUES(10, '일반회원');
INSERT INTO MEM_GRADE VALUES(20, '우수회원');
INSERT INTO MEM_GRADE VALUES(30, '특별회원');

SELECT * FROM MEM_GRADE;

CREATE TABLE MEM(
    MEM_NO NUMBER PRIMARY KEY,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN ('남', '여')),
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50),
    GRADE_ID NUMBER     -- 회원등급번호를 보관할 컬럼
);
INSERT INTO MEM
VALUES(1, 'user01', 'pass01', '홍길순', '여', null, null, null);

INSERT INTO MEM
VALUES(2, 'user02', 'pass02', '김말똥', null, null, null, 10);

INSERT INTO MEM
VALUES(3, 'user03', 'pass03', '강개순', null, null, null, 40);
--> 유효한 회원등급번호가 아님에도 불구하고 잘 INSERT됨

--------------------------------------------------------------------------------

/*
    * FOREIGN KEY (외래키)
    다른 테이블에 존재하는 값만 들어와야되는 특정 컬럼에 부여하는 제약조건
    --> 다른 테이블을 참조
    
    > 컬럼레벨방식
    컬럼명 자료형 [CONSTRAINT 제약조건명] REFERENCES 참조할테이블명[(참조할컬럼명)]
    
    > 테이블레벨방식
    [CONSTRAINT 제약조건명] FOREIGN KEY(컬럼명) REFERENCES 참조할테이블명[(참조할컬럼명)]
    
    --> 참조할컬럼명 생략시 참조할테이블에 PRIMARY KEY로 지정된 컬럼으로 자동 매칭
*/
DROP TABLE MEM;
CREATE TABLE MEM(
    MEM_NO NUMBER PRIMARY KEY,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN ('남', '여')),
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50),
    GRADE_ID NUMBER REFERENCES MEM_GRADE--(GRADE_CODE) --> 컬럼레벨방식
    --, FOREIGN(GRADE_ID) REFERENCES MEM_GRADE(GRADE_CODE) --> 테이블레벨방식
);

INSERT INTO MEM
VALUES(1, 'user01', 'pass01', '홍길순', '여', null, null, null);
--> 외래키 제약조건이 부여된 컬럼에 기본적으로 NULL 허용됨

INSERT INTO MEM
VALUES(2, 'user02', 'pass02', '김말똥', null, null, null, 10);

INSERT INTO MEM
VALUES(3, 'user03', 'pass03', '강개순', null, null, null, 40);
--> PARENT KEY를 찾을 수 없다는 오류 발생

-- MEM_GRADE(부모테이블) -|-----<- MEM(자식테이블)

INSERT INTO MEM
VALUES(3, 'user03', 'pass03', '강개순', null, null, null, 30);

INSERT INTO MEM
VALUES(4, 'user04', 'pass04', '홍길동', null, null, null, 10);

--> 부모테이블(MEM_GRADE)로부터 데이터값 삭제시 문제 발생
-- 데이터 삭제 : DELETE FROM 테이블명 WHERE 조건;

-- MEM_GRADE 테이블의 10번 등급 삭제
DELETE FROM MEM_GRADE 
WHERE GRADE_CODE = 10;
--> 자식테이블(MEM)에 10이라는 값을 사용하고 있기 때문에 삭제 불가

-- MEM_GRADE 테이블의 20번 등급 삭제
DELETE FROM MEM_GRADE
WHERE GRADE_CODE = 20;
--> 자식테이블(MEM)에 20이라는 값을 사용하고 있지 않기 때문에 삭제 가능

--> 자식테이블에 이미 사용되고 있는 값이 있을 경우
--  부모테이블로부터 삭제가 안되는 "삭제 제한" 옵션이 기본적으로 걸려있음

--------------------------------------------------------------------------------

/*
    자식테이블 생성시 외래키 제약조건 부여할때 "삭제옵션" 지정 가능
    
    * 삭제옵션 : 부모테이블의 데이터 삭제시 그 데이터를 사용하고 있는 자식테이블의 값을 어떻게 처리할 것인지
    
    - ON DELETE RESTRICTED (기본값) : 삭제제한옵션, 자식데이터로 쓰이는 부모데이터는 삭제 불가
    - ON DELETE SET NULL : 부모데이터 삭제시 해당 데이터를 쓰고 있는 자식데이터의 값을 NULL로 변경
    - ON DELETE CASCADE : 부모데이터 삭제시 해당 데이터를 쓰고 있는 자식데이터도 같이 삭제
*/
DROP TABLE MEM;
CREATE TABLE MEM(
    MEM_NO NUMBER PRIMARY KEY,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN ('남', '여')),
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50),
    GRADE_ID NUMBER REFERENCES MEM_GRADE ON DELETE SET NULL
);

INSERT INTO MEM
VALUES(1, 'user01', 'pass01', '홍길순', '여', null, null, null);

INSERT INTO MEM
VALUES(2, 'user02', 'pass02', '김말똥', null, null, null, 10);

INSERT INTO MEM
VALUES(3, 'user03', 'pass03', '강개순', null, null, null, 30);

INSERT INTO MEM
VALUES(4, 'user04', 'pass04', '홍길동', null, null, null, 10);

-- 10번 등급 삭제
DELETE FROM MEM_GRADE
WHERE GRADE_CODE = 10;

INSERT INTO MEM_GRADE VALUES(10, '일반회원');
DROP TABLE MEM;

CREATE TABLE MEM(
    MEM_NO NUMBER PRIMARY KEY,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN ('남', '여')),
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50),
    GRADE_ID NUMBER REFERENCES MEM_GRADE ON DELETE CASCADE
);

INSERT INTO MEM
VALUES(1, 'user01', 'pass01', '홍길순', '여', null, null, null);

INSERT INTO MEM
VALUES(2, 'user02', 'pass02', '김말똥', null, null, null, 10);

INSERT INTO MEM
VALUES(3, 'user03', 'pass03', '강개순', null, null, null, 30);

INSERT INTO MEM
VALUES(4, 'user04', 'pass04', '홍길동', null, null, null, 10);

DELETE FROM MEM_GRADE
WHERE GRADE_CODE = 10;

--------------------------------------------------------------------------------

/*
    < DEFAULT 기본값 > ** 제약조건 아님!! **
    컬럼을 선정하지 않고 INSERT시 NULL이 아닌 기본값을 INSERT하고자 할 때 세팅해둘 수 있는 값
*/
DROP TABLE MEMBER;
-- 컬럼명 자료형 DEFAULT 기본값 [제약조건]
CREATE TABLE MEMBER(
    MEM_NO NUMBER PRIMARY KEY,
    MEM_NAME VARCHAR2(20) NOT NULL,
    MEM_AGE NUMBER,
    HOBBY VARCHAR2(20) DEFAULT '없음',
    ENROLL_DATE DATE DEFAULT SYSDATE
);

-- 방법1. 테이블의 모든 컬럼값을 다 제시해서 INSERT하는 방법
--       INSERT INTO 테이블명 VALUES(값, 값, 값, ...); --> 컬럼의 갯수만큼 값 제시
INSERT INTO MEMBER VALUES(1, '강길동', 20, '운동', '22/10/30');
INSERT INTO MEMBER VALUES(2, '홍길순', NULL, NULL, NULL);
INSERT INTO MEMBER VALUES(3, '김말똥', DEFAULT, DEFAULT, DEFAULT);

-- 방법2. 테이블의 특정 컬럼만 지정해서 값을 제시하는 방법
--       선택되지 않은 컬럼에는 기본적으로 NULL이 들어감 (단, DEFAULT값이 부여되어있을 경우 => DEFAULT 값이 들어감)
--       INSERT INTO 테이블명(컬럼명, 컬럼명) VALUES(값, 값); --> 선택한 컬럼의 수에 맞춰 값 제시
INSERT INTO MEMBER(MEM_NO, MEM_NAME) VALUES(4, '강개순');

--------------------------------------------------------------------------------

/*
    ------------------------- BR 계정 -------------------------
    
    < SUBQUERY를 이용한 테이블 생성 >
    테이블 복사 개념
    
    [표현법]
    CREATE TABLE 테이블명
    AS 서브쿼리;
*/
-- EMPLOYEE 테이블을 그대로 복제한 새로운 테이블 생성
CREATE TABLE EMPLOYEE_COPY
AS SELECT * 
     FROM EMPLOYEE;

SELECT * FROM EMPLOYEE_COPY;
--> 컬럼명, 데이터 타입, 데이터 값, 제약조건의 경우 NOT NULL만 복사됨

CREATE TABLE EMPLOYEE_COPY2
AS SELECT EMP_ID, EMP_NAME, SALARY, BONUS
     FROM EMPLOYEE
    WHERE 1 = 0; --> 구조만을 복사하고자 할 때 쓰이는 구문 (데이터값은 필요 없을 때 무조건 거짓인 조건을 제시하여 데이터값은 복제되지 않게함)

SELECT * FROM EMPLOYEE_COPY2;

CREATE TABLE EMPLOYEE_COPY3
AS SELECT EMP_ID, EMP_NAME, SALARY, SALARY * 12 "연봉"
     FROM EMPLOYEE;
--> 서브쿼리의 SELECT절에 산술식 또는 함수식 기술된 경우 반드시 별칭 지정

SELECT * FROM EMPLOYEE_COPY3;

SELECT EMP_NAME, 연봉
FROM EMPLOYEE_COPY3;

--------------------------------------------------------------------------------

/*
    * 테이블을 다 생성한 후에 뒤늦게 제약조건 추가
    
    ALTER TABLE 테이블명 변경할내용;
    
    >> 변경할내용
    - PRIMARY KEY : ADD PRIMARY KEY(컬럼명);
    - FOREIGN KEY : ADD FOREIGN KEY(컬럼명) REFERENCES 참조할테이블[ (참조할컬럼) ] [ 삭제옵션 ] ;
    - UNIQUE : ADD UNIQUE(컬럼명);
    - CHECK : ADD CHECK(컬럼에 대한 조건식);
    - NOT NULL : MODIFY 컬럼명 NOT NULL;
*/
-- EMPLOYEE_COPY 테이블에 PRIMARY KEY 제약조건 추가 (EMP_ID)
ALTER TABLE EMPLOYEE_COPY ADD PRIMARY KEY(EMP_ID);

SELECT * FROM EMPLOYEE;
SELECT * FROM DEPARTMENT;

-- EMPLOYEE 테이블 DEPT_CODE에 외래키 제약조건 추가 (참조할테이블(부모) : DEPARTMENT(DEPT_ID))
ALTER TABLE EMPLOYEE ADD FOREIGN KEY(DEPT_CODE) REFERENCES DEPARTMENT;

-- EMPLOYEE 테이블 JOB_CODE에 외래키 제약조건 추가 (JOB 테이블 참조)
ALTER TABLE EMPLOYEE ADD FOREIGN KEY(JOB_CODE) REFERENCES JOB;

-- DEPARTMENT 테이블 LOCATION_ID에 외래키 제약조건 추가 (LOCATION 테이블 참조)
ALTER TABLE DEPARTMENT ADD FOREIGN KEY(LOCATION_ID) REFERENCES LOCATION;