/*
    * 서브쿼리 (SUBQUERY)
    - 하나의 SQL문 안에 포함된 또다른 SELECT문
    - 메인 SQL문을 보조 역할 하는 쿼리문
*/

-- 간단 서브쿼리 예시1.
-- 노옹철 사원과 같은 부서에 속한 사원들 조회
-- 1) 먼저 노옹철 사원의 부서코드 조회
SELECT DEPT_CODE
FROM EMPLOYEE
WHERE EMP_NAME = '노옹철'; --> D9

-- 2) 부서코드가 D9인 사원들 조회
SELECT EMP_NAME
FROM EMPLOYEE
WHERE DEPT_CODE = 'D9';

--> 위 2가지 단계를 하나의 쿼리문으로
SELECT EMP_NAME
FROM EMPLOYEE
WHERE DEPT_CODE = (SELECT DEPT_CODE
                     FROM EMPLOYEE
                    WHERE EMP_NAME = '노옹철');

-- 간단 서브쿼리 예시2.
-- 전 사원의 평균급여보다 더 많은 급여를 받는 사원들 조회
-- 1) 전 사원의 평균급여
SELECT AVG(SALARY)
FROM EMPLOYEE; --> 약 3047663원

-- 2) 급여가 3047663원 이상인 사원들 조회
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY >= 3047663;

--> 하나의 쿼리문
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY >= (SELECT AVG(SALARY)
                   FROM EMPLOYEE);

--------------------------------------------------------------------------------

/*
    * 서브쿼리의 구분
    서브쿼리의 수행 결과값이 몇행 몇열이냐에 따라 분류됨
    
    - 단일행 [단일열] 서브쿼리 : 서브쿼리의 조회 결과값이 오로지 1개일 때 (한행 한열)
    - 다중행 [단일열] 서브쿼리 : 서브쿼리의 조회 결과값이 여러행일 때 (여러행 한열)
    - [단일행] 다중열 서브쿼리 : 서브쿼리의 조회 결과값이 한 행이지만 컬럼이 여러개일 때 (한행 여러열)
    - 다중행 다중열 서브쿼리   : 서브쿼리의 조회 결과값이 여러행 여러컬럼일 때
*/

/*
    1. 단일행 서브쿼리 (SINGLE ROW SUBQUERY)
    서브쿼리의 조회 결과값이 오로지 1개일 때
    
    일반 비교연산자 사용 가능
    = != ^= <> > < >= <=
*/
-- 1) 전 직원의 평균급여보다 급여를 더 적게 받는 사원들의 사원명, 직급코드, 급여 조회
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY < (SELECT AVG(SALARY)
                  FROM EMPLOYEE)
ORDER BY SALARY;

-- 2) 최저 급여를 받는 사원의 사번, 이름, 급여, 입사일 조회
SELECT EMP_ID, EMP_NAME, SALARY, HIRE_DATE
FROM EMPLOYEE
WHERE SALARY = (SELECT MIN(SALARY)
                  FROM EMPLOYEE);

-- 3) 노옹철 사원의 급여보다 더 많이 받는 사원들의 사번, 이름, 부서코드, 급여 조회
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > (SELECT SALARY
                  FROM EMPLOYEE
                 WHERE EMP_NAME = '노옹철'); 

-->> 오라클
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT
WHERE SALARY > (SELECT SALARY
                  FROM EMPLOYEE
                 WHERE EMP_NAME = '노옹철')
  AND DEPT_CODE = DEPT_ID;

SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
WHERE SALARY > (SELECT SALARY
                  FROM EMPLOYEE
                 WHERE EMP_NAME = '노옹철'); 

-- 4) 사수가 선동일인 사원들의 사번, 이름, 사수사번 조회
SELECT EMP_ID, EMP_NAME, MANAGER_ID
FROM EMPLOYEE
WHERE MANAGER_ID = (SELECT EMP_ID
                      FROM EMPLOYEE
                     WHERE EMP_NAME = '선동일'); 

-- 5) 전지연 사원과 같은 부서원들의 사번, 사원명, 입사일, 직급명 조회
--    단, 전지연 제외
SELECT EMP_ID, EMP_NAME, HIRE_DATE, JOB_NAME
FROM EMPLOYEE E, JOB J
WHERE E.JOB_CODE = J.JOB_CODE
  AND DEPT_CODE = (SELECT DEPT_CODE
                    FROM EMPLOYEE
                   WHERE EMP_NAME = '전지연') 
  AND EMP_NAME != '전지연';
  
SELECT EMP_ID, EMP_NAME, HIRE_DATE, JOB_NAME
FROM EMPLOYEE 
JOIN JOB USING(JOB_CODE)
WHERE DEPT_CODE = (SELECT DEPT_CODE
                    FROM EMPLOYEE
                   WHERE EMP_NAME = '전지연') 
  AND EMP_NAME != '전지연';  
  
-- 6) 부서별 급여합이 가장 큰 부서의 부서코드, 급여합
-- 6_1) 먼저 부서별 급여합 중에서 가장 큰 값 하나만 조회
SELECT MAX(SUM(SALARY))
FROM EMPLOYEE
GROUP BY DEPT_CODE;

-- 6_2) 부서별 급여합들 중에 급여합이 17660000인 부서 조회
SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING SUM(SALARY) = 17660000;

SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING SUM(SALARY) = (SELECT MAX(SUM(SALARY))
                        FROM EMPLOYEE
                      GROUP BY DEPT_CODE);

--------------------------------------------------------------------------------

/*
    2. 다중행 서브쿼리 (MULTI ROW SUBQUERY)
    서브쿼리를 수행한 결과값이 여러행일 때 (컬럼은 하나)
    
    다중행 서브쿼리 앞에는 일반 비교연산자 사용 X
    
    - IN 서브쿼리 : 여러개의 결과값 중에서 한개라도 일치하는 값이 있으면 조회 
    
        비교대상 IN (값1, 값2, 값3)
        비교대상 = 값1 OR 비교대상 = 값2 OR 비교대상 = 값3
    
    - > ANY 서브쿼리 : 여러개의 결과값 중에서 "한개라도" 클 경우 (여러개의 결과값 중에서 가장 작은값보다 클 경우)
    - < ANY 서브쿼리 : 여러개의 결과값 중에서 "한개라도" 작을 경우 (여러개의 결과값 중에서 가장 큰값보다 작을 경우)
    
        비교대상 > ANY (값1, 값2, 값3)
        비교대상 > 값1 OR 비교대상 > 값2 OR 비교대상 > 값3
    
    - > ALL 서브쿼리 : 여러개의 "모든" 결과값들 보다 클 경우 
    - < ALL 서브쿼리 : 여러개의 "모든" 결과값들 보다 작을 경우
        
        비교대상 > ALL (값1, 값2, 값3)
        비교대상 > 값1 AND 비교대상 > 값2 AND 비교대상 > 값3
*/
-- 1) 유재식 또는 윤은해 사원과 같은 직급인 사원들의 사번, 사원명, 직급코드, 급여
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE JOB_CODE IN (SELECT JOB_CODE
                     FROM EMPLOYEE
                    WHERE EMP_NAME IN ('유재식', '윤은해')); 
-- IN 대신에 = ANY 써도 됨

-- 2) 부서가 D9인 사람들이 사수인 사원들의 사번, 이름, 사수사번 조회
SELECT EMP_ID, EMP_NAME, MANAGER_ID
FROM EMPLOYEE
WHERE MANAGER_ID IN (SELECT EMP_ID
                       FROM EMPLOYEE
                      WHERE DEPT_CODE = 'D9');

-- 사원 => 대리 => 과장 => 차장 => 부장 => ...
-- 3) 대리 직급임에도 불구하고 과장 직급 급여들 중 최소 급여보다 많이 받는 사원 조회 (사번, 이름, 직급, 급여)
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
WHERE JOB_NAME = '대리' 
  AND SALARY > ANY (SELECT SALARY
                      FROM EMPLOYEE 
                      JOIN JOB USING(JOB_CODE)
                     WHERE JOB_NAME = '과장');

-- 4) 차장직급임에도 불구하고 부장직급인 사원들의 모든 급여보다도 더 많이 받는 사원들의 사번, 사원명, 직급명, 급여
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
WHERE JOB_NAME = '차장'
  AND SALARY > ALL (SELECT SALARY
                      FROM EMPLOYEE
                      JOIN JOB USING(JOB_CODE)
                     WHERE JOB_NAME = '부장'); 

--------------------------------------------------------------------------------

/*
    3. 다중열 서브쿼리
    결과값은 한 행이지만 나열된 컬럼수가 여러개일 경우
*/
-- 1) 하이유 사원과 같은 부서, 같은 직급인 사원들 조회 (사원명, 부서코드, 직급코드, 입사일)
--> 단일행 서브쿼리로
SELECT EMP_NAME, DEPT_CODE, JOB_CODE, HIRE_DATE
FROM EMPLOYEE
WHERE DEPT_CODE = (SELECT DEPT_CODE
                     FROM EMPLOYEE
                    WHERE EMP_NAME = '하이유')
  AND JOB_CODE = (SELECT JOB_CODE
                    FROM EMPLOYEE
                   WHERE EMP_NAME = '하이유'); 

-->> 다중열 서브쿼리
SELECT EMP_NAME, DEPT_CODE, JOB_CODE, HIRE_DATE
FROM EMPLOYEE
WHERE (DEPT_CODE, JOB_CODE) = (SELECT DEPT_CODE, JOB_CODE
                                 FROM EMPLOYEE
                                WHERE EMP_NAME = '하이유');
                                
-- 2) 박나라 사원과 같은 직급, 같은 사수를 가지고 있는 사원들의 사번, 사원명, 직급코드, 사수사번
SELECT EMP_ID, EMP_NAME, JOB_CODE, MANAGER_ID
FROM EMPLOYEE
WHERE (JOB_CODE, MANAGER_ID) = (SELECT JOB_CODE, MANAGER_ID
                                  FROM EMPLOYEE
                                 WHERE EMP_NAME = '박나라'); 

--------------------------------------------------------------------------------

/*
    4. 다중행 다중열 서브쿼리
    서브쿼리 조회 결과값이 여러행 여러열일 경우
*/
-- 1) 각 직급별 최소급여를 받는 사원 조회 (사번, 사원명, 직급코드, 급여)
SELECT JOB_CODE, MIN(SALARY)
FROM EMPLOYEE
GROUP BY JOB_CODE;

SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE JOB_CODE = 'J2' AND SALARY = 1800000
   OR JOB_CODE = 'J7' AND SALARY = 1380000
   OR JOB_CODE = 'J3' AND SALARY = 2800000
   ...;
   
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE JOB_CODE, SALARY = ('J2', 1800000)
   OR JOB_CODE, SALARY = ('J7', 1380000)
   OR JOB_CODE, SALARY = ('J3', 2800000)
   ...;
   
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE (JOB_CODE, SALARY) IN (SELECT JOB_CODE, MIN(SALARY)
                              FROM EMPLOYEE
                            GROUP BY JOB_CODE);  
   
-- 2) 각 부서별 최고급여를 받는 사원들의 사번, 사원명, 부서코드, 급여
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE (NVL(DEPT_CODE, '없음'), SALARY) IN (SELECT NVL(DEPT_CODE, '없음'), MAX(SALARY)
                                FROM EMPLOYEE
                              GROUP BY DEPT_CODE);  

/*
    DEPT_CODE = NULL AND SALARY = 2890000 -- '='으로 비교하는건 존재하는 값만 가능. 따라서 조회에서 제외
 OR DEPT_CODE = 'D1' AND SALARY = 3660000
 OR DEPT_CODE = 'D9' AND SALARY = 8000000
 ...
*/

--------------------------------------------------------------------------------

/*
    5. 인라인뷰 (INLINE-VIEW)
    FROM 절에 서브쿼리를 작성
    
    서브쿼리를 수행한 결과를 마치 하나의 테이블처럼 사용
*/
-- 사번, 이름, 보너스포함연봉(별칭부여), 부서코드 조회 => 보너스포함연봉이 절대 NULL 안나오게
-- 단, 보너스포함연봉이 3000만원 이상인 사원들만 조회
SELECT EMP_ID, EMP_NAME, (SALARY + SALARY*NVL(BONUS, 0))*12 "연봉", DEPT_CODE
FROM EMPLOYEE
WHERE (SALARY + SALARY*NVL(BONUS, 0))*12 >= 30000000; 
--> WHERE절에 SELECT의 별칭 사용 불가

SELECT *
  FROM (SELECT EMP_ID, EMP_NAME, (SALARY + SALARY*NVL(BONUS, 0))*12 "연봉", DEPT_CODE
          FROM EMPLOYEE)
 WHERE 연봉 >= 30000000;

-->> 인라인뷰를 주로 사용하는 경우 ** => TOP-N 분석

-- 사원들 중 급여가 가장 높은 상위 5명만 조회
-- * ROWNUM : 오라클에서 제공해주는 컬럼, 조회된 순서대로 1부터 순번을 부여해주는 컬럼
SELECT EMP_NAME, SALARY, ROWNUM
FROM EMPLOYEE
WHERE ROWNUM <= 5
ORDER BY SALARY DESC;
-- 정렬이 되기도 전에 이미 5명이 추려지고 나서 정렬

--> ORDER BY절이 다 수행된 결과를 가지고 ROWNUM이 5이하인 걸 추려야 함
SELECT ROWNUM, E.*
FROM (SELECT EMP_NAME, SALARY, DEPT_CODE
        FROM EMPLOYEE
      ORDER BY SALARY DESC) E
WHERE ROWNUM <= 5;

-- 가장 최근에 입사한 사원 5명만 조회 (사원명, 급여, 입사일)
SELECT ROWNUM, EMP_NAME, SALARY, HIRE_DATE
FROM(SELECT *
       FROM EMPLOYEE
     ORDER BY HIRE_DATE DESC)
WHERE ROWNUM <= 5;         

-- 각 부서별 평균급여가 높은 3개의 부서 조회
SELECT DEPT_CODE, FLOOR(평균급여)
  FROM(SELECT DEPT_CODE, AVG(SALARY) "평균급여"
         FROM EMPLOYEE
       GROUP BY DEPT_CODE
       ORDER BY 평균급여 DESC)
WHERE ROWNUM <= 3;

--------------------------------------------------------------------------------

/*
    * 순위 매기는 함수 (WINDOW FUNCTION)
    
    - RANK() OVER(정렬기준) : 동일한 순위 이후의 등수를 해당 인원 수 만큼 건너 뛰고 계산
                            EX) 공동 1위가 3명일 때 그 다음 순위는 4위    
    - DENSE_RANK() OVER(정렬기준) : 동일한 순위가 있다해도 그 다음 등수를 1씩 증가시킨 순위
                                  EX) 공동 1위가 100명이여도 그 다음 순위는 2위
*/
-- 급여가 높은 순서대로 순위를 매겨서 조회
SELECT EMP_NAME, SALARY, RANK() OVER(ORDER BY SALARY DESC) "순위"
FROM EMPLOYEE;
-- 공동 19위 2명, 그 다음 순위 21위

SELECT EMP_NAME, SALARY, DENSE_RANK() OVER(ORDER BY SALARY DESC) "순위"
FROM EMPLOYEE;
-- 공동 19위 2명, 그 다음 순위 20위

--> 상위 5명만 조회
SELECT EMP_NAME, SALARY, RANK() OVER(ORDER BY SALARY DESC) "순위"
FROM EMPLOYEE
WHERE RANK() OVER(ORDER BY SALARY DESC) <= 5; -- 오류 (WHERE절에 WINDOW 함수 사용 불가)

-->> 인라인뷰를 사용할 수 밖에 없음
SELECT *
FROM(SELECT EMP_NAME, SALARY, RANK() OVER(ORDER BY SALARY DESC) "순위"
       FROM EMPLOYEE)
WHERE 순위 <= 5; 

--------------------------------------------------------------------------------

/*
    6. 상(호연)관 서브쿼리
       일반적인 서브쿼리 방식은 서브쿼리가 만들어낸 고정된 결과값을 메인쿼리가 가져다가 사용하는 구조이나
       상관 서브쿼리는 반대로 메인쿼리의 테이블값을 가져다가 서브쿼리에서 이용해서 결과를 만듦
*/
-- 1) 본인의 직급별 평균급보다 더 많이 받는 직원의 이름, 직급코드, 급여 조회
SELECT E.EMP_NAME, E.JOB_CODE, E.SALARY
FROM EMPLOYEE E
WHERE SALARY > 해당사원직급(E.JOB_CODE)의평균급여;

SELECT E.EMP_NAME, E.JOB_CODE, E.SALARY
FROM EMPLOYEE E
WHERE SALARY > (SELECT AVG(SALARY)
                  FROM EMPLOYEE
                 WHERE JOB_CODE = E.JOB_CODE);
-- 서브쿼리안의 E.JOB_CODE 자리에는 메인쿼리의 값이 매번 대체

-- 2) 보너스가 본인 부서의 평균보너스보다 많은 사원들의 이름, 부서코드, 급여, 보너스 조회
SELECT EMP_NAME, E.DEPT_CODE, SALARY, BONUS
FROM EMPLOYEE E
WHERE BONUS > (SELECT AVG(BONUS)
                 FROM EMPLOYEE
                WHERE DEPT_CODE = E.DEPT_CODE); 

-- 상관서브쿼리이면서 서브쿼리의 결과값이 매번 1개 => "스칼라"

-- 3) 전 사원의 사번, 이름, 사수사번, 사수명 조회
SELECT E.EMP_ID, E.EMP_NAME, E.MANAGER_ID, M.EMP_NAME
FROM EMPLOYEE E
LEFT JOIN EMPLOYEE M ON(E.MANAGER_ID = M.EMP_ID);

-- 서브쿼리 이용
SELECT EMP_ID, EMP_NAME,
       EMPLOYEE로부터EMP_ID가E.MANAGER_ID와일치하는사원명
FROM EMPLOYEE E;

SELECT EMP_ID, EMP_NAME,
       NVL((
        SELECT EMP_NAME
          FROM EMPLOYEE
         WHERE EMP_ID = E.MANAGER_ID
       ), '없음') "사수명"
FROM EMPLOYEE E;

-- 스칼라서브쿼리의 특징 : 서브쿼리의 수행횟수를 최소화하기 위해 입력값과 출력값을 내부 캐시에 저장해둠
--                     입력값을 캐시에서 찾아보고 거기에 있으면 출력값을 리턴하고 없으면 서브쿼리가 수행되도록

-- 4) 전 사원의 사번, 이름, 직급코드, 직급명 조회
SELECT EMP_ID, EMP_NAME, JOB_CODE, JOB_NAME
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE);

SELECT EMP_ID, EMP_NAME, JOB_CODE,
       (
        SELECT JOB_NAME
          FROM JOB
         WHERE JOB_CODE = E.JOB_CODE
         ) "직급명"
FROM EMPLOYEE E;

-- 부서명 알아내기
SELECT EMP_ID, EMP_NAME, 
       (
        SELECT DEPT_TITLE
          FROM DEPARTMENT
         WHERE DEPT_ID = DEPT_CODE
       ) "부서명"
FROM EMPLOYEE;       

-- 5) 전 사원의 사번, 이름, 부서코드, 해당부서의부서원수
SELECT EMP_ID, EMP_NAME, DEPT_CODE,
       (
           SELECT COUNT(*)
             FROM EMPLOYEE
            WHERE NVL(DEPT_CODE, 'X') = NVL(E.DEPT_CODE, 'X') 
       ) "부서원수"
FROM EMPLOYEE E;