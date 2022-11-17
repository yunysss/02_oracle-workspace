/*
    < JOIN >
    두 개 이상의 테이블에서 데이터를 조회하고자 할 때 사용되는 구문
    조회 결과는 하나의 결과물(RESULT SET)로 나옴
    
    관계형데이터베이스는 최소한의 데이터로 각각의 테이블에 담고 있음 (중복 최소화)
    
    => 관계형 데이터베이스에서 SQL문을 이용한 테이블간 "관계"를 맺는 방법
    
                        JOIN은 크게 "오라클전용구문"과 "ANSI구문" 존재
                            
                                [ JOIN  용어 정리 ]
            오라클전용구문          |               ANSI구문
    ----------------------------------------------------------------------------
              등가조인               |   내부조인 (INNER JOIN) => JOIN USING/ON              
            (EQUAL JOIN)           |   자연조인 (NATURAL JOIN) => JOIN USING
    ----------------------------------------------------------------------------             
              포괄조인               |     왼쪽 외부조인 (LEFT OUTER JOIN)
           (LEFT OUTER)            |    오른쪽 외부조인 (RIGHT OUTER JOIN)
           (RIGHT OUTER)           |      전체 외부조인 (FULL OUTER JOIN)
    ----------------------------------------------------------------------------             
        자체조인 (SELF JOIN)         |              JOIN ON
      비등가조인 (NON EQUAL JOIN)     |
  ------------------------------------------------------------------------------       
     카테시안 곱 (CARTESIAN PRODUCT)  |          교차조인 (CROSS JOIN)
*/
-- 전 사원들의 사번, 사원명, 부서코드, 부서명을 조회
SELECT EMP_ID, EMP_NAME, DEPT_CODE
FROM EMPLOYEE;

SELECT DEPT_ID, DEPT_TITLE
FROM DEPARTMENT;

-- 전 사원들의 사번, 사원명, 직급코드, 직급명 조회
SELECT EMP_ID, EMP_NAME, JOB_CODE
FROM EMPLOYEE;

SELECT JOB_CODE, JOB_NAME
FROM JOB;

/*
    1. 등가조인(EQUAL JOIN) / 내부조인 (INNER JOIN)
       연결시키는 컬럼의 값이 "일치하는 행들만" 조인돼서 조회 (== 일치하는 값이 없는 행은 조회에서 제외)
*/
-->> 오라클 전용 구문
--   FROM절에 조회하고자하는 테이블들을 나열 (, 구분자)
--   WHERE절에 매칭시킬 컬럼(연결고리)에 대한 조건을 제시함

-- 1) 연결할 두 컬럼명이 다른 경우 (EMPLOYEE:DEPT_CODE / DEPARTMENT:DEPT_ID)
-- 사번, 사원명, 부서코드, 부서명 같이 조회
SELECT EMP_ID, EMP_NAME, DEPT_CODE, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID;
--> 일치하는 값이 없는 행은 조회에서 제외!
-- DEPT_CODE가 NULL인 사원 조회X, 부서들 중 부서코드가 D3, 34, 37 조회X

-- 2) 연결할 두 컬럼명이 같은 경우 (EMPLOYEE:JOB_CODE / JOB:JOB_CODE)
-- 사번, 사원명, 직급코드, 직급명
-- (1) 테이블명을 이용
SELECT EMP_ID, EMP_NAME, EMPLOYEE.JOB_CODE, JOB_NAME
FROM EMPLOYEE, JOB
WHERE EMPLOYEE.JOB_CODE = JOB.JOB_CODE;

-- (2) 테이블에 별칭 부여하여 이용
SELECT EMP_ID, EMP_NAME, E.JOB_CODE, JOB_NAME
FROM EMPLOYEE E, JOB J
WHERE E.JOB_CODE = J.JOB_CODE;

-->> ANSI구문
--   FROM절에 기준이 되는 테이블 하나 기술 후
--   JOIN절에 같이 조회하고자하는 테이블 및 매칭시킬 컬럼에 대한 조건 기술
--   JOIN ON, JOIN USING

-- 1) 연결할 두 컬럼명이 다른 경우 (EMPLOYEE:DEPT_CODE / DEPARTMENT:DEPT_ID)
--    JOIN ON만 가능!
SELECT EMP_ID, EMP_NAME, DEPT_CODE, DEPT_TITLE
FROM EMPLOYEE 
/*INNER */JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);

-- 2) 연결할 두 컬럼명이 같은 경우 (EMPLOYEE:JOB_CODE / JOB:JOB_CODE)
-- (1) 테이블명 또는 별칭을 이용
SELECT EMP_ID, EMP_NAME, E.JOB_CODE, JOB_NAME
FROM EMPLOYEE E
JOIN JOB J ON (E.JOB_CODE = J.JOB_CODE);

-- (2) JOIN USING 구문 사용 (두 컬럼명이 일치할 때만 사용 가능!)
SELECT EMP_ID, EMP_NAME, JOB_CODE, JOB_NAME
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE); -- ambiguously 발생X

--- [참고사항] ---
-- * 자연조인 (NATURAL JOIN) : 각 테이블마다 동일한 이름의 컬럼이 딱 한개만 존재하고 이를 매칭시켜서 조회하고자 할 때
SELECT EMP_ID, EMP_NAME, JOB_CODE, JOB_NAME
FROM EMPLOYEE
NATURAL JOIN JOB;

-- 추가적인 조건 제시 가능
-- 대리 직급의 사원들의 사번, 이름, 직급명, 급여 조회
-->> 오라클 전용 구문
SELECT EMP_ID, EMP_NAME, SALARY, JOB_NAME
FROM EMPLOYEE E, JOB J
WHERE E.JOB_CODE = J.JOB_CODE AND JOB_NAME = '대리';

-->> ANSI 구문
SELECT EMP_ID, EMP_NAME, SALARY, JOB_NAME
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
WHERE JOB_NAME = '대리';

-------------------------- 실습문제 -----------------------------
-- 1. 부서가 인사관리부인 사원들의 사번, 이름, 보너스 조회
SELECT EMP_ID, EMP_NAME, BONUS
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID AND DEPT_TITLE = '인사관리부';

SELECT EMP_ID, EMP_NAME, BONUS
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
WHERE DEPT_TITLE = '인사관리부';

SELECT EMP_ID, EMP_NAME, BONUS
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID AND DEPT_TITLE = '인사관리부'); -- ON 뒤에 추가적인 조건 기술 가능

-- 2. DEPARTMENT과 LOCATION을 참고해서 전체 부서들의 부서코드, 부서명, 지역코드, 지역명 조회
SELECT DEPT_ID, DEPT_TITLE, LOCATION_ID, LOCAL_NAME
FROM DEPARTMENT, LOCATION
WHERE LOCATION_ID = LOCAL_CODE;

SELECT DEPT_ID, DEPT_TITLE, LOCATION_ID, LOCAL_NAME
FROM DEPARTMENT
JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE);

-- 3. 보너스를 받는 사원들의 사번, 사원명, 보너스, 부서명 조회
SELECT EMP_ID, EMP_NAME, BONUS, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID AND BONUS IS NOT NULL;

SELECT EMP_ID, EMP_NAME, BONUS, DEPT_TITLE
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
WHERE BONUS IS NOT NULL;

--4. 부서가 총무부가 아닌 사원들의 사원명, 급여 조회
SELECT EMP_NAME, SALARY
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID AND DEPT_TITLE != '총무부';

SELECT EMP_NAME, SALARY
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
WHERE DEPT_TITLE != '총무부';

--------------------------------------------------------------------------------

/*
    2. 포괄조인 / 외부 조인 (OUTER JOIN)
       두 테이블간의 JOIN시 일치하지 않는 행도 포함시켜서 조회 할 때
       단, 반드시 LEFT / RIGHT 지정해야함 (기준이 되는 테이블 지정)
*/
-- INNER JOIN
-- 사원명, 부서명, 급여, 연봉
SELECT EMP_NAME, DEPT_TITLE, SALARY, SALARY*12
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);
-- 부서 배치가 안된 2명의 사원 정보 조회 X
-- 부서에 배정된 사원이 없는 부서 조회 X

-- 1) LEFT OUTER JOIN : 두 테이블 중 왼편에 기술된 테이블을 기준으로 JOIN
-->> ANSI
SELECT EMP_NAME, DEPT_TITLE, SALARY, SALARY*12
FROM EMPLOYEE
LEFT /*OUTER */JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);
-- 부서 배치를 받지 않았던 2명의 사원 (하동운, 이오리) 조회됨 (EMPLOYEE 테이블을 기준으로 해서 모든 사원 무조건 나오게끔)

-->> 오라클전용구문
SELECT EMP_NAME, DEPT_TITLE, SALARY, SALARY*12
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID(+); -- 기준으로 삼고자하는 테이블의 반대편 테이블의 컬럼 뒤에 (+)

-- 2) RIGHT [OUTER] JOIN
-->> ANSI
SELECT EMP_NAME, DEPT_TITLE, SALARY, SALARY*12
FROM EMPLOYEE
RIGHT /*OUTER */JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);
-- 부서에 배정된 사원이 없는 세 개의 부서 (D3, D4, D7) 정보도 조회됨

-->> 오라클전용구문
SELECT EMP_NAME, DEPT_TITLE, SALARY, SALARY*12
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE(+) = DEPT_ID;

-- 3) FULL [OUTER] JOIN : 두 테이블이 가진 모든 행을 조회 (단, 오라클전용구문 불가)
SELECT EMP_NAME, DEPT_TITLE, SALARY, SALARY*12
FROM EMPLOYEE
FULL /*OUTER */JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);

SELECT EMP_NAME, DEPT_TITLE, SALARY, SALARY*12
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE(+) = DEPT_ID(+); -- 에러발생

--------------------------------------------------------------------------------

/*
    3. 비등가 조인 (NON EQUAL JOIN)
    매칭시킬 컬럼에 대한 조건 작성시 '=' 를 사용하지 않음
    ANSI구문으로 JOIN ON으로만 가능
*/
SELECT EMP_NAME, SALARY         -- SALARY
FROM EMPLOYEE;

SELECT SAL_LEVEL, MIN_SAL, MAX_SAL  -- MIN_SAL, MAX_SAL
FROM SAL_GRADE;

-- 사원명, 급여, 급여레벨
-->> 오라클 구문
SELECT EMP_NAME, SALARY, SAL_LEVEL
FROM EMPLOYEE, SAL_GRADE
--WHERE SALARY >= MIN_SAL AND SALARY <= MAX_SAL;
WHERE SALARY BETWEEN MIN_SAL AND MAX_SAL;

-->> ANSI
SELECT EMP_NAME, SALARY, SAL_LEVEL
FROM EMPLOYEE
JOIN SAL_GRADE ON SALARY BETWEEN MIN_SAL AND MAX_SAL;

--------------------------------------------------------------------------------

/*
    4. 자체 조인 (SELF JOIN)
    같은 테이블을 여러번 조인하는 경우
*/
SELECT * FROM EMPLOYEE;

-- 전 사원들의 사원번호, 사원명, 사원부서코드     => EMPLOYEE E
--           사수사번, 사수명, 사수부서코드     => EMPLOYEE M
-->> 오라클
SELECT E.EMP_ID "사원번호", E.EMP_NAME "사원명", E.DEPT_CODE "사원부서코드",
        M.EMP_ID "사수사번", M.EMP_NAME "사수명", M.DEPT_CODE "사수부서코드"
FROM EMPLOYEE E, EMPLOYEE M
WHERE E.MANAGER_ID = M.EMP_ID;

-->> ANSI
SELECT E.EMP_ID "사원번호", E.EMP_NAME "사원명", E.DEPT_CODE "사원부서코드", ED.DEPT_TITLE "사원부서명",
        M.EMP_ID "사수사번", M.EMP_NAME "사수명", M.DEPT_CODE "사수부서코드", MD.DEPT_TITLE "사수부서명"
FROM EMPLOYEE E
LEFT JOIN EMPLOYEE M ON (E.MANAGER_ID = M.EMP_ID)
LEFT JOIN DEPARTMENT ED ON (E.DEPT_CODE = ED.DEPT_ID) -- EMPLOYEE E와 EMPLOYEE M 조인한 것이 LEFT
LEFT JOIN DEPARTMENT MD ON (M.DEPT_CODE = MD.DEPT_ID); -- EMPLOYEE E, EMPLOYEE M, DEPARTMENT ED 조인한 것이 LEFT

--------------------------------------------------------------------------------

/*
    5. 카테시안곱 (CARTESIAN PRODUCT) / 교차조인 (CROSS JOIN)
    모든 테이블의 각 행들이 서로서로 매핑된 데이터 조회됨 (곱집합)
    
    => 방대한 데이터 출력 => 과부화의 위험
*/
-->> 오라클
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT; -- 23 * 9 => 207행

-->> ANSI
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE
CROSS JOIN DEPARTMENT;

--------------------------------------------------------------------------------

-- * 다중 JOIN
-- 사번, 사원명, 부서명, 직급명 조회
SELECT * FROM EMPLOYEE;     -- DEPT_CODE    JOB_CODE
SELECT * FROM DEPARTMENT;   -- DEPT_ID 
SELECT * FROM JOB;          --              JOB_CODE

-->> 오라클
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME
FROM EMPLOYEE E, DEPARTMENT, JOB J 
WHERE DEPT_CODE = DEPT_ID(+) 
  AND E.JOB_CODE = J.JOB_CODE;

-->> ANSI
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME
FROM EMPLOYEE
LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
JOIN JOB USING(JOB_CODE);
--> JOIN 순서 제약 없는 경우

-- 사번, 사원명, 부서명, 지역명
SELECT * FROM EMPLOYEE;     -- DEPT_CODE
SELECT * FROM DEPARTMENT;   -- DEPT_ID      LOCATION_ID
SELECT * FROM LOCATION;     --              LOCAL_CODE

-->> 오라클
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, LOCAL_NAME
FROM EMPLOYEE, DEPARTMENT, LOCATION
WHERE DEPT_CODE = DEPT_ID(+)
  AND LOCATION_ID = LOCAL_CODE(+);
  
-->> ANSI
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, LOCAL_NAME
FROM EMPLOYEE
LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
LEFT JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE);
--> ANSI구문은 다중JOIN 순서 중요

-- 전 사원들의 사번, 사원명, 부서명, 직급명, 지역명, 국가명, 급여등급 조회 (모든 테이블 다 조인)
SELECT EMP_ID
     , EMP_NAME
     , DEPT_TITLE
     , JOB_NAME
     , LOCAL_NAME
     , NATIONAL_NAME
     , SAL_LEVEL
  FROM EMPLOYEE E
     , DEPARTMENT D
     , JOB J
     , LOCATION L
     , NATIONAL N
     , SAL_GRADE S
 WHERE DEPT_CODE = DEPT_ID(+)
   AND E.JOB_CODE = J.JOB_CODE
   AND LOCATION_ID = LOCAL_CODE(+)
   AND L.NATIONAL_CODE = N.NATIONAL_CODE(+)
   AND SALARY BETWEEN MIN_SAL AND MAX_SAL;  

SELECT EMP_ID
     , EMP_NAME
     , DEPT_TITLE
     , JOB_NAME
     , LOCAL_NAME
     , NATIONAL_NAME
     , SAL_LEVEL
  FROM EMPLOYEE
LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
JOIN JOB USING(JOB_CODE)
LEFT JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
LEFT JOIN NATIONAL USING(NATIONAL_CODE)
JOIN SAL_GRADE ON (SALARY BETWEEN MIN_SAL AND MAX_SAL);









