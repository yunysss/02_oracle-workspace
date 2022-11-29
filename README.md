# Oracle
## 1. SELECT (기본문법)
### 1_1. 주요 용어

![Untitled](https://user-images.githubusercontent.com/115604544/202937750-91140a39-498b-4c4b-9bf4-ab98d45496ec.png)

① 행 (Row), 튜플　　　　② 컬럼 , 도메인　　　③ 기본키 (Primary Key) : 행을 구별해주는 식별자   
④ 외래키 (Foreign Key)　⑤ Null : 비어있음　　⑥ 컬럼값 , 속성값
### 1_2. 데이터타입

![Untitled](https://user-images.githubusercontent.com/115604544/202938053-c0ec82fd-b8b7-4363-ab01-d31a0839bedf.png)

### 1_3. SQL (Structured Query Language)

![제목 없음](https://user-images.githubusercontent.com/115604544/202938075-08150bf7-c074-4b60-a1bf-85bffbaae3a3.jpg)
### 1_4. SELECT문이란?
- 데이터 조회할 때 사용되는 구문
- RESULT SET : SELECT문에 의해 조회된 결과물 (조회된 행들의 집합)
- oracle의 예약어, 테이블명, 컬럼명 대소문자 가리지 않음 (소문자도 정상적으로 실행)
```
SELECT 조회하고자하는 컬럼, 컬럼, ...
FROM 테이블명;
```
### 1_4. 컬럼값을 통한 산술연산
- SELECT절 컬럼명 작성부분에 산술연산식 기술 가능 (=> 해당 컬럼값이 산술연산된 결과로 조회)
- 산술연산 과정 중 NULL이 존재할 경우 산술연산 결과값 마저도 무조건 NULL로 나옴
- DATE 형식끼리도 연산 가능
- DATE - DATE : 결과값은 일 단위
### 1_5. 컬럼별 별칭 지정
```
컬럼명 별칭 / 컬럼명 AS 별칭 / 컬럼명 "별칭" / 컬럼명 AS "별칭"
```
- 조회시 컬럼명 또는 산술식 뒤에 별칭 부여
- AS 여부와 상관 없이 별칭에 띄어쓰기 또는 특수문자가 포함될 경우 반드시 쌍따옴표로 묶어서 표기
### 1_6. 리터럴
- 임의로 지정한 문자열('')
- SELECT절에 리터럴을 제시하면 마치 테이블상에 존재하는 테이블처럼 조회 가능
- 조회된 RESULT SET의 모든 행에 반복적으로 같이 출력
```SQL
SELECT EMP_ID, EMP_NAME, SALARY, '원' AS 단위
FROM EMPLOYEE;
```

![Untitled](https://user-images.githubusercontent.com/115604544/202938654-2925db15-42cc-4af9-8b23-43cec2fe50d8.png)

### 1_7. 연결 연산자 : ||
- 여러 컬럼값들을 마치 하나의 컬럼인 것처럼 연결하거나, 컬럼값과 리터럴을 연결할 수 있음
- JAVA에서 System.out.println("num : " + num); 과 비슷
### 1_8. DISTINCT
- 컬럼에 중복된 값들은 한번씩만 조회하고자 할 때 사용
```
SELECT DISTINCT 칼럼, ...
FROM 테이블명; 
```
- 유의 사항
  - DISTINCT는 SELECT절에 딱 한번만 기술 가능
  - DISTINCT 칼럼명1, 칼럼명2, …와 같이 기술할 경우 (칼럼1, 칼럼2, …) 쌍으로 묶여서 중복 판별
### 1_9. WHERE 절
```
SELECT 조회하고자 하는 컬럼명, 컬럼명, 산술연산 AS 별칭, ...
FROM 테이블명
WHERE 조건식;
```
- 조회하고자하는 테이블로부터 특정 조건에 만족하는 데이터만을 조회하고자 할 때 WHERE절에 조건식 제시
- WHERE 절에서는 SELECT절에 부여한 별칭 사용 불가 (실행순서 : FROM절 => WHERE절 => SELECT절)
- 비교연산자   
  < , >, <=, >=　　　　--> 대소비교   
  =　　　　　　　　　--> 같은지 비교   
  !=, ^=, <>　　　　　--> 같지 않은지 비교   
- 논리연산자
  - 여러개의 조건을 엮어서 제시하고자 할 때 사용   
  AND (~이면서, 그리고)   
  OR  (~이거나, 또는)
- BETWEEN AND
  - 몇 이상 몇 이하인 범위에 대한 조건을 제시할 때 사용되는 연산자
  ```
  비교대상컬럼 BETWEEN 하한값 AND 상한값
  ```
- NOT : 논리부정연산자 (자바에서의 !와 같은 존재) => 컬럼명 앞 또는 BETWEEN 앞에 기입
- DATE 타입끼리도 대소비교 연산 가능
- LIKE
  - 비교하고자하는 컬럼값이 내가 제시한 특정 패턴에 만족될 경우 조회
  ```
  비교대상컬럼 LIKE '특정패턴’
  ```
  - 특정패턴 제시시 '%', '_'를 사용 (와일드카드)
    - '%' : 0글자 이상   
      EX) 비교대상컬럼 LIKE '문자%'   => 비교대상의 컬럼값이 해당 문자로 "시작"될 경우 조회   
      비교대상컬럼 LIKE '%문자'   => 비교대상의 컬럼값이 해당 문자로 "끝"날 경우 조회   
      비교대상컬럼 LIKE '%문자%'  => 비교대상의 컬럼값에 해당 문자가 "포함"되어 있을 경우 조회 (키워드 검색**)   
    - '_' : 1글자   
      EX) 비교대상컬럼 LIKE '_문자'   => 비교대상의 컬럼값이 어떠한 "한 글자" 뒤에 해당 문자가 올 경우 조회   
      비교대상컬럼 LIKE '__문자'  => 비교대상의 컬럼값이 어떠한 "두 글자" 뒤에 해당 문자가 올 경우 조회   
  - 와일드 카드 문자와 패턴의 특수문자가 동일한 경우 다 와일드카드로 인식   
    => 데이터값으로 취급하고자하는 값 앞에 나만의 와일드 카드를 제시하고 ESCAPE OPTION으로 등록
    ```SQL
    SELECT EMP_ID, EMP_NAME, EMAIL
    FROM EMPLOYEE
    WHERE EMAIL LIKE '___$_%' ESCAPE '$';
    ```
  - NOT은 컬럼명 앞 또는 LIKE 앞에 기입 가능
- IS NULL / IS NOT NULL : 컬럼값에 NULL이 있을 경우 NULL값 비교할때 사용되는 연산자
- IN : 비교대상컬럼값이 내가 제시한 목록중에 일치하는 값이 있는지
  ```
  비교대상컬럼 IN ('값1', '값2', '값3', ...)
  ```
- 연산자 우선순위   
  0 ()   
  1 산술연산자   
  2 연결연산자   
  3 비교연산자   
  4 IS NULL / LIKE '특정패턴' / IN   
  5 BETWEEN AND   
  6 NOT(논리연산자)   
  7 AND(논리연산자)   
  8 OR(논리연산자)   
### 1_10. ORDER BY 절
- SELECT문 가장 마지막 줄에 작성되고 마지막에 실행
```
SELECT 조회할칼럼, 컬럼, 산술연산식 [AS] "별칭", …
FROM 조회하고자하는테이블명
WHERE 조건식
ORDER BY 정렬기준의컬럼명|별칭|컬럼순번   [ASC|DESC]  [NULLS FIRST|NULLS LAST]
```
- ASC : 오름차순 정렬 (생략시 기본값)
- DESC : 내림차순 정렬
- NULLS FIRST : 정렬하고자하는 컬럼값에 NULL이 있을 경우 해당 데이터를 앞에 배치 (생략시 DESC일 때의 기본값)
- NULLS LAST : 정렬하고자하는 컬럼값에 NULL이 있을 경우 해당 데이터를 뒤에 배치 (생략시 ASC일 때의 기본값)
- 여러개 제시 가능 (첫번째 기준의 컬럼값이 동일할 경우 두번째 기준의 컬럼가지고 정렬...)
- 산술연산식 가능
- 별칭 사용 가능
- 컬럼 순번 사용 가능
## 2. SELECT (함수)
### 2_1. 함수 FUNCTION
- 전달된 컬럼값을 읽어들여서 함수를 실행한 결과를 반환
- 단일행 함수 : N개의 값을 읽어들여서 N개의 결과값을 반환 (매 행마다 함수 실행 결과 반환)
- 그룹 함수 : N개의 값을 읽어들여서 1개의 결과값을 반환 (그룹을 지어 그룹별로 함수 실행 결과 반환)
- SELECT절 단일행함수랑 그룹함수를 함께 기술하지 못함! => 결과 행의 갯수가 다르기 때문
- 함수식을 기술할 수 있는 위치 : SELECT절, WHERE절, ORDER BY절, GROUP BY절, HAVING절, DML문
### 2_2. 단일행 함수
#### 2_2_1. 문자 처리 함수
```
LENGTH('문자열값' | 컬럼) : 해당 문자열값의 글자수 반환
LENGTHB('문자열값' | 컬럼) : 해당 문자열값의 바이트수 반환
```
- LENGTH / LENGTHB
  - 결과값 NUMBER타입   
  - 한글 한글자당 3BYTE   
  - 영문자, 숫자, 특수문자 한글자당 1BYTE   
```
INSTR(컬럼 | '문자열값', '찾고자하는문자', [ 찾을위치의 시작값, [ 순번 ] ]) 
```
- INSTR : 문자열로부터 특정 문자의 시작위치를 찾아서 반환
  - 결과값 NUMBER타입
  - 찾을위치의 시작값
    - 1 : 앞에서부터 탐색
    - -1 : 뒤에서부터 탐색
  - 찾을위치의시작값 1기본값, 순번 1기본값
  - 찾지 못할 경우 0 반환
```
SUBSTR(STRING, POSITION, [ LENGTH ])
```
- SUBSTR
  - 문자열에서 특정 문자열을 추출해서 반환 (자바에서의 substring()메소드와 유사)
  - 결과값 CHARACTER타입
  - STRING : 문자타입의 컬럼 또는 '문자열'
  - POSITION : 문자열을 추출할 시작위치값 (음수값도 제시가능)
  - LENGTH : 추출할 문자 개수 (생략시 끝까지 의미)
```
LPAD/RPAD(STRING, 최종적으로반환할문자의길이(N), [덧붙이고자하는문자])
```
- LPAD / RPAD
  - 문자열에 덧붙이고자하는 문자를 왼쪽 또는 오른쪽에 덧붙여서 최종 N길이(바이트수)만큼의 문자열 반환
  - 결과값 CHARACTER타입
  - 덧붙이고자 하는 문자 생략시 기본값 공백
```
LTRIM/RTRIM(STRING, [제거하고자하는문자들])
```
- LTRIM / RTRIM
  - 결과값 CHARACTER타입
  - 제거하고자하는문자 생략시 기본값 공백
  - 제거하고자하는 문자들 순서 상관없이 만나면 제거됨
```
TRIM( [ [ LEADING/TRAILING/BOTH ] 제거하고자하는문자들 FROM ] STRING)
```
- TRIM
  - 문자열의 앞/뒤/양쪽에 있는 지정한 문자들을 제거한 나머지 반환
  - LEADING : 앞 ⇒ LTRIM
  - TRAILING : 뒤 ⇒ RTRIM
  - BOTH : 양쪽 ⇒ 생략시 기본값
```
LOWER/UPPER/INITCAP(STRINR)
```
- LOWER / UPPER / INITCAP
  - 결과값 CHARACTER타입
  - LOWER : 다 소문자로 변경
  - UPPER : 다 대문자로 변경
  - INITCAP : 단어 앞글자마다 대문자로 변경
    - 공백 단위로 한 단어로 인식
```
CONCAT(STRING, STRING)
```
- CONCAT
  - 문자열 두 개 전달받아 하나로 합친 결과 반환
  - 결과값 CHARACTER타입
  - 세 개 이상의 문자열은 연결 연산자 이용
```
REPLACE(STRING, STR1, STR2)
```
- REPLACE
  - 결과값 CHARACTER타입
  - 실제 데이터값 변경 X
#### 2_2_2. 숫자 처리 함수
```
ABS(NUMBER)
```
- ABS
  - 숫자의 절대값을 구해주는 함수
  - 결과값 NUMBER타입
 ```
 MOD(NUMBER, NUMBER)   
 ```
- MOD
  - 두 수를 나눈 나머지값을 반환해주는 함수 (오라클에는 % 연산자 없음)
  - 결과값 NUMBER타입
```
ROUND(NUMBER, [ 위치 ])
```
- ROUND
  - 반올림처리 함수
  - 결과값 NUMBER타입
  - 위치 : 어느 위치까지 표시할 것인지 제시    
    EX) 1  2  3  .  4  5  6    
    　-2 -1  0　1  2  3   
  - 위치 생략시 기본값 0
```
CEIL(NUMBER)
```
- CEIL
  - 올림처리 함수 (위치 지정 불가능)
  - 소수점 아래 작은 값이라도 있으면 올림처리 / 0이면 올림X
```
FLOOR(NUMBER)
```
- FLOOR : 소수점 아래 버림처리 함수 (위치 지정 불가능)
```
TRUNC(NUMBER, [ 위치 ])
```
- TRUNC : 위치 지정 가능한 버림처리 함수
#### 2_2_3. 날짜 처리 함수
- SYSDATE : 현재 시스템 날짜 및 시간 반환
- MONTHS_BETWEEN(DATE1, DATE2)
  - 두 날짜 사이의 개월 수 ⇒ 내부적으로 DATE1 - DATE2 후 나누기 30, 31이 진행
  - 결과값 NUMBER타입
  - DATE1에 더 최근 날짜 작성
- ADD_MONTHS(DATE, NUMBER) 
  - 특정 날짜에 해당 숫자만큼의 개월수를 더해서 그 날짜 리턴
  - 결과값 DATE타입
- NEXT_DAY(DATE, 요일(문자 | 숫자) 
  - 특정 날짜 이후에 가까운 해당 요일의 날짜를 반환해주는 함수
  -결과값 DATE타입
  - 한글 설정일 때 요일은 ‘월요일’ 또는 ‘월’로 제시 가능
  - 1:일요일, 2:월요일, 3:화요일, 4:수요일, 5:목요일, 6:금요일, 7:토요일
- LAST_DAY(DATE)
  - 해당 월의 마지막 날짜를 구해서 반환
  - 결과값 DATE타입
- EXTRACT(YEAR | MONTH | DAY FROM DATE)
  - 특정 날짜로부터 년도/월/일 만 추출해서 반환하는 함수
  - 결과값 NUMBER타입
#### 2_2_4. 형변환 함수
```
TO_CHAR(숫자 | 날짜, [ 포맷 ])
```
- TO_CHAR
  - 숫자 타입 또는 날짜 타입의 값을 문자 타입으로 변환시켜주는 함수
  - 결과값 CHARACTER타입
  - 숫자 ⇒ 문자
    - 9 : 갯수만큼 공간 확보, 오른쪽 정렬, 빈칸 공백으로 채움
    - 0 : 갯수만큼 공간 확보, 오른쪽 정렬, 빈칸 0으로 채움
    - L : LOCAL ⇒ 현재 설정된 나라의 화폐단위 (’$’로 표현하고 싶으면 $쓰면 됨)
    - fm : NUMBER타입의 공백을 없앨 때
  - 날짜 ⇒ 문자타입
    - 기본 : ‘YY/MM/DD’
    - AM | PM : 현재 시간의 오전/오후
    - HH : 12시간 형식 시
    - HH24 : 24시간 형식 시
    - MI : 분
    - fm : DATE타입의 0을 없앨 때 (단, fm이 붙은 자리 이후에 모두 적용)
  - 년도 관련 포맷
    - YYYY : 네 자리 년도
    - YY : 두 자리 년도 ⇒ 무조건 현재 세기로 반영
    - RRRR : 두 자리 년도
    - RR : 두 자리 년도 ⇒ 해당 두 자리 년도가 50미만일 경우 현재 세기로 반영, 50이상일 경우 이전 세기로 반영
    - YEAR : 영문 년도
  - 월 관련 포맷
    - MM : 두 자리 월
    - MON : 두 자리 월 + ‘월’
    - MONTH : 두 자리 월 + ‘월’
    - RM : 로마기호 월
  - 일 관련 포맷
    - DDD : 년 (1월 1일) 기준 몇 일 째
    - DD : 월 기준 몇 일 째
    - D : 주 기준 (일요일 시작) 몇 일 째 (1~7, 일~토)
  - 요일 관련 포맷
    - DAY : 요일
    - DY : 요일 약어
  - 포맷 내 정해진 포맷, 특수문자 외의 임의의 문자열 값 쓰고자 할 경우 ""로 묶어서 표현
    ```SQL
    SELECT EMP_NAME, TO_CHAR(HIRE_DATE, 'YYYY"년" MM"월" DD"일" (DY)')
    FROM EMPLOYEE;
    ```
    
    ![Untitled](https://user-images.githubusercontent.com/115604544/202944682-7ef7643d-f9eb-42be-8932-df2f851e6a9f.png)

```
TO_DATE(숫자 | 문자, [ 포맷 ])
```
- TO_DATE
  - 숫자 타입 또는 문자 타입 데이터를 날짜 타입으로 변환시켜주는 함수
  - 결과값 DATE타입
  - 숫자 : 8자리 혹은 6자리 숫자   
           0으로 시작할 경우 0을 떼고 인식하여 오류 발생
   - 문자 : 0으로 시작해도 인식 잘 됨
  - 시간까지 제시시 반드시 포맷 지정
```
TO_NUMBER(문자, [ 포맷 ])
```
- TO_NUMBER
  - 문자타입의 데이터를 숫자타입으로 변환시켜주는 함수
  - Oracle에서 '문자' <-> 숫자 자동형변환   
    ‘,’ 찍혀 있을 경우 자동형변환 X => 에러 발생 => TO_NUMBER로 형변환
#### 2_2_5. NULL 처리 함수
- NVL(컬럼, 해당 컬럼값이 NULL일 경우 반환할 값)
  - 컬럼과 반환할 값의 타입을 맞춰야 함    
- NVL2(컬럼, 반환값1, 반환값2)
  - 컬럼값이 존재할 경우 반환값1 반환
  - 컬럼값이 존재하지 않을 경우 반환값2 반환
- NULLIF(비교대상1, 비교대상2)
  - 두 개의 값이 일치하면 NULL 반환
  - 두 개의 값이 일치하지 않으면 비교대상1 반환
#### 2_2_6. 선택 함수
- DECODE
```
DECODE(비교하고자하는대상컬럼 | 산술연산 | 함수식, 비교값1, 결과값1, 비교값2, 결과값2, ..., 결과값N)
```
- CASE WHEN THEN
```
[표현법1]
CASE WHEN 조건식1 THEN 결과값1
     WHEN 조건식2 THEN 결과값2
     ...
     ELSE 결과값N
END

[표현법2]
CASE 비교대상컬럼 | 산술연산식 | 함수식
     WHEN 비교값1 THEN 결과값1
     WHEN 비교값2 THEN 결과값2
     ...
     ELSE 결과값N
END
```
### 2_3. 그룹 함수
- SUM(NUMBER) : 해당 칼럼 값들의 총 합계를 구해서 반환해주는 함수
- AVG(NUMBER) : 해당 컬럼값들의 평균값을 구해서 반환
- MIN(ANY타입) : 해당 컬럼값들 중에 가장 작은 값 구해서 반환
- MAX(ANY타입) : 해당 컬럼값들 중에 가장 큰 값 구해서 반환
- COUNT(* | 컬럼 | DISTINCT 컬럼 : 행 갯수를 세어서 반환
  - COUNT(*) : 조회될 결과의 모든 행 갯수를 세어서 반환
  - COUNT(컬럼) : 제시한 해당 컬럼값이 NULL이 아닌 것만 행 갯수 세어서 반환
  - COUNT(DISTINCT 컬럼) : 해당 컬럼값을 중복 제거한 후 행 갯수 세어서 반환 (NULL 제외)
## 3. SELECT (GROUP BY & HAVING)
### 3_1. GROUP BY 절
- 그룹기준을 제시할 수 있는 구문 (해당 그룹기준별로 여러 그룹으로 묶을 수 있음)
- 그룹 함수는 단 한 개의 결과 값만 산출하기 때문에 그룹이 여러 개일 경우 오류 발생
- 여러 개의 결과 값을 산출하기 위해 그룹 함수가 적용될 그룹의 기준을 GROUP BY절에 기술하여 사용

![Untitled](https://user-images.githubusercontent.com/115604544/202955617-7f1aae2d-fbe5-4ab4-b42c-09d56e6760af.png)

- GROUP BY 절에 함수식 기술 가능
- GROUP BY 절에 여러 컬럼 기술 가능
### 3_2. HAVING 절
- 그룹에 대한 조건을 제시할 때 사용되는 구문 (주로 그룹함수식을 가지고 조건을 제시)
- WHERE절에는 그룹함수식 못 씀 ⇒ 에러 발생
- WHERE절과 HAVING절 함께 작성 가능
### 3_3. SELECT문 실행 순서     
5:　　　　SELECT　　* | 조회하고자 하는 컬럼 [AS] 별칭 | 산술연산식 [AS] "별칭" | 함수식   
1:　　　　　FROM　　조회하고자 하는 테이블명 별칭, 테이블명 "별칭", ...   
2:　　　　　WHERE　　조건식 (연산자들 가지고 기술)   
3:　　　GROUP BY　　그룹기준으로 삼을 컬럼 | 함수식 | 산술연산식, 칼럼, ...   
4:　　　　HAVING　　조건식 (그룹함수 또는 그룹 기준의 컬럼 가지고 기술)   
6:　　　ORDER BY　　정렬 기준으로 삼을 컬럼|별칭|컬럼순번   [ASC|DESC]  [NULLS FIRST|NULLS LAST]   
### 3_4. 집계 함수
- 그룹별 산출된 결과 값의 중간집계를 계산해주는 함수
- GROUP BY 절에 기술
- 그룹기준의 컬럼이 하나일 때는 CUBE, ROLLUP의 차이 없음 (총 합 구해줌)
- 그룹기준의 칼럼이 두개 이상 일 때
  - ROLLUP(컬럼1, 컬럼2) : 컬럼1을 가지고 다시 중간 집계를 내주는 함수
  - CUBE(컬럼1, 컬럼2) : 컬럼1을 가지고 중간집계 내고, 추가로 컬럼2을 가지고도 중간집계를 냄
### 3_5. 집합 연산자 == SET OPERATION : 여러개의 쿼리문을 하나의 쿼리문으로 만드는 연산자

![Untitled](https://user-images.githubusercontent.com/115604544/202956486-527d3bab-0cdd-4ba6-8000-db6cc182bb04.png)

- UNION　　　: 합집합 (두 쿼리문 수행한 결과값을 더한 후 중복되는 값은 한번만 더해지도록)　| OR
- INTERSECT　: 교집합 (두 쿼리문 수행한 결과값에 중복된 결과값)　| AND
- UNION ALL　: 합집합 + 교집합 (두 쿼리문의 결과값을 무조건 더한 결과값 => 중복된 값이 두 번 표현될 수 있음)
- MINUS　　　: 차집합 (선행 쿼리의 결과값에서 후행 쿼리의 결과값을 뺀 나머지)　| AND NOT
- 집합연산자 사용시 유의사항
  - 각 쿼리의 SELECT절에 작성된 컬럼의 수 일치
  - 각 칼럼 자리마다 동일한 타입으로 기술
  - 선행 쿼리의 컬럼명이 보여짐
  - ORDER BY 절은 마지막에 기술
## 4. SELECT (JOIN)
- JOIN
  - 두 개 이상의 테이블에서 데이터를 조회하고자 할 때 사용되는 구문
  - 조회 결과는 하나의 결과물 (RESULT SET)로 나옴
  - 관계형데이터베이스는 최소한의 데이터로 각각의 테이블에 담고 있음 (중복 최소화)
  - 관계형 데이터베이스에서 SQL문을 이용하여 테이블간 “관계”를 맺는 방법

  ![캡처](https://user-images.githubusercontent.com/115604544/202957790-fe1751e4-753a-45b6-8a4c-ea431ebaa531.JPG)

- 등가조인(EQUAL JOIN) / 내부조인 (INNER JOIN)
  - 연결시키는 컬럼의 값이 "일치하는 행들만" 조인돼서 조회 (== 일치하는 값이 없는 행은 조회에서 제외)
  - 오라클 전용 구문
    - FROM절에 조회하고자하는 테이블들을 나열 (, 구분자)
    - WHERE절에 매칭시킬 컬럼(연결고리)에 대한 조건을 제시함
    - 연결할 두 컬럼명이 같은 경우
      - 테이블명 이용
      - 테이블에 별칭 부여하여 이용
  - ANSI 구문
    - FROM절에 기준이 되는 테이블 하나 기술 후
    - JOIN절에 같이 조회하고자하는 테이블 및 매칭시킬 컬럼에 대한 조건 기술
    - JOIN ON, JOIN USING
    - 연결할 두 컬럼명이 다른 경우 : JOIN ON만 가능
    - 연결할 두 컬럼명이 같은 경우
      - 테이블명 또는 별칭을 이용
      - JOIN USING 구문 사용
- 포괄조인 / 외부 조인 (OUTER JOIN)
  - 두 테이블간의 JOIN시 일치하지 않는 행도 포함시켜서 조회 할 때
  - 반드시 LEFT / RIGHT 지정 (기준이 되는 테이블 지정)
  - LEFT / RIGHT [OUTER] JOIN : 두 테이블 중 왼편 / 오른편에 기술된 테이블을 기준으로 JOIN
    - 오라클 전용 구문에서 기준으로 삼고자하는 테이블의 반대편 테이블의 컬럼 뒤에 (+)
  - FULL [OUTER] JOIN : 두 테이블이 가진 모든 행을 조회 (단, 오라클전용구문 불가)
- 비등가 조인 (NON EQUAL JOIN)
  - 매칭시킬 컬럼에 대한 조건 작성시 '=' 를 사용하지 않음
  - ANSI구문 사용시 JOIN ON으로만 가능
- 자체 조인 (SELF JOIN)
  - 같은 테이블을 여러번 조인하는 경우
- 카테시안곱 (CARTESIAN PRODUCT) / 교차조인 (CROSS JOIN)
  - 모든 테이블의 각 행들이 서로서로 매핑된 데이터 조회됨 (곱집합)   
    => 방대한 데이터 출력 => 과부화의 위험
  - 매칭할 조건을 제시하지 않은 경우 (실수로 발생하는 경우가 많음)
- 다중 JOIN
  - ANSI구문 사용시 다중 JOIN 순서 중요
- 자연조인 (NATURAL JOIN) : 각 테이블마다 동일한 이름의 컬럼이 딱 한개만 존재하고 이를 매칭시켜서 조회하고자 할 때
## 5. SELECT (SUBQUERY)
### 5_1. 서브쿼리란?
- 하나의 SQL문 안에 포함된 또다른 SELECT문
- 메인 SQL문을 보조 역할 하는 쿼리문
### 5_2. 서브쿼리의 구분 : 서브쿼리의 수행 결과값이 몇행 몇열이냐에 따라 분류
- 단일행 [단일열] 서브쿼리 (SINGLE ROW SUBQUERY)
  - 서브쿼리의 조회 결과값이 오로지 1개일 때 (한행 한열)
  - 일반 비교연산자 사용 가능   
    ( = != ^= <> > < >= <= )
- 다중행 [단일열] 서브쿼리 (MULTI ROW SUBQUERY)
  - 서브쿼리의 조회 결과값이 여러행일 때 (여러행 한열)
  - 다중행 서브쿼리 앞에는 일반 비교연산자 사용 X
  - IN 서브쿼리
    - 여러개의 결과값 중에서 한개라도 일치하는 값이 있으면 조회비교대상 IN (값1, 값2, 값3)
    - 비교대상 = 값1 OR 비교대상 = 값2 OR 비교대상 = 값3
    - = ANY 써도 됨
  - \> ANY 서브쿼리
    - 여러개의 결과값 중에서 "한개라도" 클 경우 (여러개의 결과값 중에서 가장 작은값보다 클 경우)
    - 비교대상 > ANY (값1, 값2, 값3)
      비교대상 > 값1 OR 비교대상 > 값2 OR 비교대상 > 값3
  - < ANY 서브쿼리
    - 여러개의 결과값 중에서 "한개라도" 작을 경우 (여러개의 결과값 중에서 가장 큰값보다 작을 경우)
    - 비교대상 < ANY (값1, 값2, 값3)   
      비교대상 < 값1 OR 비교대상 < 값2 OR 비교대상 < 값3
  - \> ALL 서브쿼리
    - 여러개의 "모든" 결과값들 보다 클 경우
    - 비교대상 > ALL (값1, 값2, 값3)   
      비교대상 > 값1 AND 비교대상 > 값2 AND 비교대상 > 값3
  - < ALL 서브쿼리 
    - 여러개의 "모든" 결과값들 보다 작을 경우
    - 비교대상 < ALL (값1, 값2, 값3)   
      비교대상 < 값1 AND 비교대상 < 값2 AND 비교대상 < 값3
- [단일행] 다중열 서브쿼리 : 서브쿼리의 조회 결과값이 한 행이지만 컬럼이 여러개일 때 (한행 여러열)
- 다중행 다중열 서브쿼리 : 서브쿼리의 조회 결과값이 여러행 여러컬럼일 때 (여러행 여러열)
### 5_3. 인라인뷰 (INLINE-VIEW)
- FROM 절에 서브쿼리를 작성
- 서브쿼리를 수행한 결과를 마치 하나의 테이블처럼 사용
- TOP-N 분석
  - 각 부서별 평균급여가 높은 3개의 부서 조회
  ```SQL
  SELECT DEPT_CODE, FLOOR(평균급여)
    FROM (SELECT DEPT_CODE, AVG(SALARY) "평균급여"
           FROM EMPLOYEE
         GROUP BY DEPT_CODE
         ORDER BY 평균급여 DESC)
    WHERE ROWNUM <= 3;
  ```
### 5_4. 순위 매기는 함수 (WINDOW FUNCTION)
- RANK() OVER(정렬기준) : 동일한 순위 이후의 등수를 해당 인원 수 만큼 건너 뛰고 계산   
                          EX) 공동 1위가 3명일 때 그 다음 순위는 4위
- DENSE_RANK() OVER(정렬기준) : 동일한 순위가 있다해도 그 다음 등수를 1씩 증가시킨 순위    
                                EX) 공동 1위가 100명이여도 그 다음 순위는 2위   
- 상위 / 하위 몇 명만 조회 시 => WHERE절에 WINDOW 함수 사용 불가 => 인라인뷰 무조건 써야 함!
### 5_5. 상(호연)관 서브쿼리
- 일반적인 서브쿼리 방식은 서브쿼리가 만들어낸 고정된 결과값을 메인쿼리가 가져다가 사용하는 구조
- 상관 서브쿼리는 반대로 메인쿼리의 테이블값을 가져다가 서브쿼리에서 이용해서 결과를 만듦
- 상관서브쿼리이면서 서브쿼리의 결과값이 매번 1개 => "스칼라”
- 스칼라서브쿼리의 특징
  - 서브쿼리의 수행횟수를 최소화하기 위해 입력값과 출력값을 내부 캐시에 저장해둠
  - 입력값을 캐시에서 찾아보고 거기에 있으면 출력값을 리턴하고 없으면 서브쿼리가 수행됨
## 6. DDL (CREATE)
### 6_1. DDL (DATA DEFINITION LANGUAGE)
- 데이터 정의 언어
- 오라클에서 제공하는 객체를 새로이 만들고(CREATE), 구조를 변경하고(ALTER), 구조 자체를 삭제(DROP)하는 언어
- 실제 데이터 값이 아닌 구조 자체를 정의하는 언어
- 주로 DB관리자, 설계자가 사용함
- 오라클에서의 객체(구조)   
  테이블(TABLE), 뷰(VIEW), 시퀀스(SEQUENCE),   
  인덱스(INDEX), 패키지(PACKAGE), 트리거(TRIGGER),   
  프로시저(PROCEDURE), 함수(FUNCTION), 동의어(SYNONYM), 사용자(USER)   
### 6_2. CREATE 
: 객체를 새로이 생성하는 구문   
#### 6_2_1. 테이블 생성
- 테이블 (TABLE)
  - 행 (ROW)과 열 (COLUMN)로 구성되는 가장 기본적인 데이터베이스 객체
  - 모든 데이터들은 테이블에 저장됨
  ```
  CREATE TABLE 테이블명 (
  컬럼명 자료형(크기),
  컬러명 자료형(크기),
  컬럼명 자료형,
  ...
  );
  ```
- 자료형
  - 문자 (CHAR(바이트크기) | VARCHAR2(바이트크기)) => 반드시 크기지정
    - CHAR : 최대 2000바이트까지 지정 가능 / 고정 길이 (지정한 크기보다 더 적은 값이 들어오면 빈 공간을 공백으로라도 채움) / 고정된 글자수의 데이터만이 담길 경우 사용
    - VARCHAR2 : 최대 4000바이트까지 지정 가능 / 가변 길이 (담긴 값에 따라서 공간의 크기 맞춰짐) / 몇 글자의 데이터가 들어올지 모를 경우 사용
  - 숫자 (NUMBER)
  - 날짜 (DATE)

![캡처](https://user-images.githubusercontent.com/115604544/203276627-d96171e7-6d29-4f3b-bcce-73bbdd3f0b13.JPG)

![캡처2](https://user-images.githubusercontent.com/115604544/203276650-969211a7-0196-4f94-862b-2f8133922c59.JPG)

#### 6_2_2. 컬럼 주석
- 컬럼에 대한 설명
- 잘못 작성했을 경우 수정 후 다시 실행
```   
COMMENT ON COLUMN 테이블명.컬럼명 IS '주석내용';
```

#### 6_2_3. [참고] 데이터 딕셔너리
- 다양한 객체들의 정보를 저장하고 있는 시스템 테이블들
- USER_TABLES : 이 사용자가 가지고 있는 테이블들의 전반적인 구조를 확인할 수 있는 시스템 테이블
- USER_TAB_COLUMNS : 이 사용자가 가지고 있는 테이블들의 모든 컬럼의 구조를 확인할 수 있는 시스템 테이블
### 6_3. 제약조건 (CONSTRAINTS)
- 원하는 데이터값 (유효한 형식의 값)만 유지하기 위해서 특정 컬럼에 부여하는 제약
- 데이터 무결성 보장 목적
- 제약조건 부여시 별도로 제약조건명을 지정해주지 않으면 시스템에서 임의로 제약조건명 부여
- 종류 : NOT NULL, UNIQUE, CHECK(조건), PRIMARY KEY, FOREIGN KEY
- 컬럼레벨방식 / 테이블레벨방식
  - 컬럼레벨방식
    ```
    CREATE TABLE 테이블명(
      컬럼명 자료형 [ CONSTRAINT 제약조건명 ] 제약조건,
      컬럼명 자료형,
      ...
    );
    ```
  - 테이블레벨방식
    ```
    CREATE TABLE 테이블명(
      컬럼명 자료형,
      컬럼명 자료형,
      ...
      [ CONSTRAINT 제약조건명 ] 제약조건(컬럼명)
    );
    ```
#### 6_3_1. NOT NULL 제약조건
- 해당 컬럼에 반드시 값이 존재해야만 할 경우 (즉, 해당 컬럼에 절대 NULL이 들어와서는 안되는 경우)
- 삽입 / 수정시 NULL값을 허용하지 않도록 제한
- 컬럼레벨방식만 가능
#### 6_3_2. UNIQUE 제약조건
- 해당 컬럼에 중복된 값이 들어가서는 안 될 경우
- 컬럼값에 중복값을 제한하는 제약조건
- 삽입 / 수정 시 기존에 있던 데이터값 중 중복값이 있을 경우 오류 발생
#### 6_3_3. CHECK(조건식) 제약조건
- 해당 컬럼에 들어올 수 있는 값에 대한 조건을 제시해둘 수 있음
- 해당 조건에 만족하는 데이터값만 담길 수 있음
- NULL도 가능
#### 6_3_4. PRIMARY KEY (기본키) 제약조건
- 테이블에서 각 행들을 식별하기 위해 사용될 컬럼에 부여하는 제약조건 (식별자역할)   
  EX) 회원번호, 학번, 사번, 부서코드, 직급코드, 주문번호, 예약번호, 운송장번호, ...
- PRIMARY KEY 제약조건을 부여하면 그 칼럼에 자동으로 NOT NULL + UNIQUE 의미
- 유의사항 : 한 테이블당 오로지 한 개만 설정 가능
- 복합키
  - 묶어서 PRIMARY KEY 제약조건 부여
  - 테이블레벨방식으로만 가능
  - 복합키 각 컬럼에는 절대 NULL 허용하지 않음
  - 예시 : 어떤 회원이 어떤 상품을 언제 찜했는지에 대한 데이터를 보관하는 테이블
    ```SQL
    CREATE TABLE TB_LIKE(
        MEM_NO NUMBER,
        PRO_NAME VARCHAR2(10),
        LIKE_DATE DATE,
        PRIMARY KEY(MEM_NO, PRO_NAME)
    );

    INSERT INTO TB_LIKE VALUES(1, 'A', SYSDATE);
    INSERT INTO TB_LIKE VALUES(1, 'B', SYSDATE);
    INSERT INTO TB_LIKE VALUES(1, 'A', SYSDATE); -- 불가
    ```
#### 6_3_5. FOREIGN KEY (외래키) 제약조건
- 다른 테이블에 존재하는 값만 들어와야되는 특정 컬럼에 부여하는 제약조건 => 다른 테이블을 참조
- 외래키 제약조건이 부여된 컬럼에 기본적으로 NULL 허용됨
- 참조할컬럼명 생략시 참조할테이블에 PRIMARY KEY로 지정된 컬럼으로 자동 매칭
- 참조할테이블(부모테이블) -|-----<- 현재테이블(자식테이블)
- 컬럼레벨방식
  ```
  컬럼명 자료형 [ CONSTRAINT 제약조건명 ] REFERENCES 참조할테이블명[ (참조할컬럼명) ] [ 삭제옵션 ]
  ```
- 테이블레벨방식
  ```
  [ CONSTRAINT 제약조건명 ] FOREIGN KEY(컬럼명) REFERENCES 참조할테이블명[ (참조할컬럼명) ] [ 삭제옵션 ]
  ```
- 삭제옵션 
  - 자식테이블 생성 시 외래키 제약조건 부여할 때 지정
  - 부모테이블의 데이터 삭제시 그 데이터를 사용하고 있는 자식테이블의 값을 어떻게 처리할 것인지 지정
  - ON DELETE RESTRICTED (기본값) : 삭제제한옵션, 자식데이터로 쓰이는 부모데이터는 삭제 불가
  - ON DELETE SET NULL : 부모데이터 삭제시 해당 데이터를 쓰고 있는 자식데이터의 값을 NULL로 변경
  - ON DELETE CASCADE : 부모데이터 삭제시 해당 데이터를 쓰고 있는 자식데이터도 같이 삭제
### 6_4. DEFAULT (기본값)
- 컬럼을 선정하지 않고 INSERT시 NULL이 아닌 기본값을 INSERT하고자 할 때 세팅해둘 수 있는 값
```
컬럼명 자료형 DEFAULT 기본값 [ 제약조건 ]
```
```SQL
CREATE TABLE MEMBER(
    MEM_NO NUMBER PRIMARY KEY,
    MEM_NAME VARCHAR2(20) NOT NULL,
    MEM_AGE NUMBER,
    HOBBY VARCHAR2(20) DEFAULT '없음',
    ENROLL_DATE DATE DEFAULT SYSDATE
);

INSERT INTO MEMBER VALUES(1, '강길동', 20, '운동', '22/10/30');
INSERT INTO MEMBER VALUES(2, '홍길순', NULL, NULL, NULL);
INSERT INTO MEMBER VALUES(3, '김말똥', DEFAULT, DEFAULT, DEFAULT);
INSERT INTO MEMBER(MEM_NO, MEM_NAME) VALUES(4, '강개순');
```

![Untitled](https://user-images.githubusercontent.com/115604544/203284499-2ece21cf-2c61-4ae7-ab13-e1c7236746cf.png)

### 6_5. SUBQUERY를 이용한 테이블 생성
```
CREATE TABLE 테이블명
AS 서브쿼리;
```
- 테이블 복사 개념
- 컬럼명, 데이터 타입, 데이터 값, 제약조건의 경우 NOT NULL만 복사됨 (주석, NOT NULL외 제약조건 복사 X)
- 구조만 복사하고자 할 때
  ```SQL
  CREATE TABLE EMPLOYEE_COPY2
  AS SELECT EMP_ID, EMP_NAME, SALARY, BONUS
       FROM EMPLOYEE
      WHERE 1 = 0;
  ```
  => WHERE절에 무조건 거짓인 조건을 제시하여 데이터값은 복제되지 않게 함
- 서브쿼리의 SELECT절에 산술식 또는 함수식 기술된 경우 반드시 별칭 지정
  ```SQL
  CREATE TABLE EMPLOYEE_COPY3
  AS SELECT EMP_ID, EMP_NAME, SALARY, SALARY * 12 "연봉"
       FROM EMPLOYEE;
  ```
### 6_6. ALTER 
- 객체를 변경하는 구문
```
ALTER TABLE 테이블명 변경할내용;
```
- 변경할 내용
  - 컬럼 추가 / 수정 / 삭제
  - 제약조건 추가 / 삭제
  - 컬럼명 / 제약조건명 / 테이블명 
#### 6_6_1. 컬럼
- 컬럼 추가 (ADD)
  ```
  ADD 컬럼명 자료형 [ DEFAULT 기본값 ]
  ```
- 컬럼 수정 (MODIFY)
  - 데이터타입 수정
    ```
    MODIFY 컬럼명 바꾸고자하는데이터타입
    ```
    - 데이터타입을 완전히 다른 타입으로 바꾸고자 할 경우(EX. CHAR → NUM) 이미 담겨 있는 데이터값이 없을 경우에만 가능
    - CHARACTER 타입의 경우 이미 담겨 있는 값의 바이트크기보다 작게 수정 불가
  - DEFAULT값 수정
    ```
    MODIFY 컬럼명 DEFAULT 바꾸고자하는기본값
    ```
  - 다중 변경 가능 (연이어서 작성)
- 컬럼 삭제 (DROP COLUMN)
  ```
  DROP COLUMN 삭제하고자하는컬럼명
  ```
  - 최소 한개의 컬럼은 존재해야함
#### 6_6_2. 제약조건
- 제약조건 추가
  - PRIMARY KEY : ADD PRIMARY KEY(컬럼명)
  - FOREIGN KEY : ADD FOREIGN KEY(컬럼명) REFERENCES 참조할테이블명[ (컬럼명) ] [ 삭제옵션 ]
  - UNIQUE : ADD UNIQUE(컬럼명)
  - CHECK : ADD CHECK(컬럼에대한조건)
  - NOT NULL : MODIFY 컬럼명 NOT NULL | NULL
- 제약조건 삭제
  - DROP CONSTRAINT 제약조건명
  - NOT NULL의 경우 : MODIFY 컬럼명 NULL
- 다중 변경 가능
#### 6_6_3. - 컬럼명 / 제약조건명 / 테이블명 (RENAME)
- 컬럼명 변경 : RENAME COLUMN 기존컬럼명 TO 바꿀컬럼명
- 제약조건명 변경 : RENAME CONSTRAINT 기존제약조건명 TO 바꿀제약조건명
- 테이블명 변경 : RENAME [ 기존테이블명 ] TO 바꿀테이블명
### 6_7. DROP
- 테이블 삭제
  ```
  DROP TABLE 테이블명;
  ```
- 부모테이블 삭제
  - 방법1. 자식 테이블 먼저 삭제한 후 부모테이블 삭제
  - 방법2. 부모테이블 전체 및 자식테이블의 제약조건 같이 삭제
    ```
    DROP TABLE 테이블명 CASCADE CONTRAINT;
    ```
## 7. DML (INSERT, UPDATE, DELETE)
### 7_1. DML(Data Manipulation Language)
- 데이터 조작 언어
- 테이블에 데이터를 삽입(INSERT)하거나, 수정(UPDATE)하거나, 삭제(DELETE)하는 구문
#### 7_2. INSERT
- 테이블에 새로운 행을 추가시키는 구문
- 특정 컬럼을 지정하지 않고 삽입하고자 할 때
  ```
  INSERT INTO 테이블명 VALUES(값, 값, 값, ...);
  ```
  - 컬럼 순번을 지켜서 VALUES에 값 나열 (컬럼 갯수만큼 값 제시)
  - 부족하게 값을 제시했을 경우 => not enough values 오류
  - 값을 더 많이 제시했을 경우 => too many values 오류
- 특정 컬럼을 선택해서 값을 제시하고자 할 때
  ```
  INSERT INTO 테이블명(컬럼명, 컬럼명, 컬럼명) VALUES(값, 값, 값);
  ```
  - 한 행으로 추가 => 선택 안 된 컬럼에는 기본적으로 NULL이 들어감
  - NOT NULL 제약조건이 걸려있는 컬럼은 반드시 선택해서 직접 값 제시   
    단, 기본값(DEFAULT)이 지정되어 있으면 NULL이 아닌 기본값이 들어감
- 서브쿼리를 수행 결과값을 통채로 INSERT하고자 할 때
  ```
  INSERT INTO 테이블명
  (서브쿼리);
  ```
- INSERT시 컬럼값으로 서브쿼리 사용 가능
  ```SQL
  NSERT INTO EMPLOYEE(EMP_ID, EMP_NAME, EMP_NO, JOB_CODE, SALARY)
  VALUES(500, '김말순', '900912-2345676', 'J7', (SELECT MAX(SALARY) FROM EMPLOYEE));
  ```
#### 7_3. INSERT ALL
- 두 개 이상의 테이블에 각각 INSERT 할 때 사용되는 서브쿼리가 동일할 경우
```
INSERT ALL
INTO 테이블명1 VALUES(컬럼명, 컬럼명, 컬럼명, ...)
INTO 테이블명2 VALUES(컬럼명, 컬럼명, 컬럼명, ...)
  서브쿼리;
```
- 조건을 사용해 각 테이블에 INSERT
  ```
  INSERT ALL
    WHEN 조건1 THEN
      INTO 테이블명1 VALUES(컬럼명, 컬럼명, ...)
    WHEN 조건2 THEN
      INTO 테이블명2 VALUES(컬럼명, 컬럼명, ...)
  서브쿼리;
  ```
#### 7_4. UPDATE
- 테이블에 기록되어 있는 기존의 데이터를 수정하는 구문
```
UPDATE 테이블명
SET 컬럼명 = 바꿀값,
    컬럼명 = 바꿀값,
    ...
[ WHERE 조건 ];
```
- 여러개의 컬럼값 동시변경 가능 ( , 로 나열)
- WHERE절 생략하면 전체 모든 행의 데이터가 변경됨
- 서브쿼리 사용 가능
- UPDATE 시에도 해당 컬럼에 대한 제약조건에 위배되어서는 안됨
#### 7_5. DELETE
- 테이블에 기록된 데이터를 삭제하는 구문 
- 한 행 단위로 삭제
```
DELETE FROM 테이블명
[ WHERE 조건 ]
```
=> WHERE절 생략하면 전체 행 다 삭제됨    
- 외래키 제약조건에 의해 해당 데이터를 사용하는 자식데이터가 있을 경우 삭제 불가 => 잠시 제약조건을 비활성화 시킨 후 삭제
  - 비활성화
    ```
    ALTER TABLE 자식테이블명 DISABLE CONSTRAINT 제약조건명 CASCADE;
    ```
  - 활성화
    ```
    ALTER TABLE 자식테이블명 ENABLE CONSTRAINT 제약조건명;
    ```
#### 7_6. TRUNCATE
```
TRUNCATE TABLE 테이블명;
```
- 테이블의 전체행을 삭제할 때 사용되는 구문
- DELETE 보다 수행속도가 더 빠름
- 별도의 조건 제시 불가, ROLLBACK 불가
## 8. DCL (GRANT, REVOKE)
- DCL (DATA CONTROL LANGUAGE) : 데이터 제어 언어
  - 계정에게 시스템권한 또는 객체접근권한을 부여(GRANT)하거나 회수(REVOKE)하는 구문
  - 시스템권한 : DB에 접근하는 권한, 객체들을 생성할 수 있는 권한
  - 객체접근권한 : 특정 객체들을 조작할 수 있는 권한
- 시스템권한 종류
  - CREATE SESSION : 접속할 수 있는 권한
  - CREATE TABLE : 테이블 생성할 수 있는 권한
  - CREATE VIEW : 뷰 생성할 수 있는 권한
  - CREATE SEQUENCE : 시퀀스 생성할 수 있는 권한
  - TABLESPACE 할당 : ALTER USER 사용자명 QUOTA 크기 ON SYSTEM; => 할당해야 테이블 생성 가능
- 객체접근권한 종류
  - SELECT TABLE | VIEW | SEQUENCE
  - INSERT TABLE | VIEW
  - UPDATE TABLE | VIEW
  - DELET TABLE | VIEW
  ```
  GRANT 권한종류 ON 특정객체 TO 계정명;
  ```
  - 다른계정에 접근 시 객체접근권한 부여 후 접근할계정명.테이블명으로 접근
- 권한 회수 (REVOKE)
  ```
  REVOKE 회수할권한 FROM 계정명;
  ```
- 롤 (ROLE) : 특정 권한들을 하나의 집합으로 모아놓은 것
  - CONNECT : 접속할 수 있는 권한 (CREATE SESSION)
  - RESOURCE : 특정 객체를 생성할 수 있는 권한 (CREATE TABEL, CREATE SEQUENCE, ...)
## 9. TCL (TRANSACTION CONTROL LANGUAGE) : 트랜잭션 제어 언어
- 트랜잭션 (TRANSACTION)
  - 데이터베이스의 논리적 연산단위
  - 데이터의 변경사항 (DML)들을 하나로 묶어서 처리할 때 필요한 개념
  - DML문을 한번 수행할 때 트렌잭션이 존재하면 해당 트랜잭션에 같이 묶어서 처리   
    트랜잭션이 존재하지 않으면 새로운 트랜잭션을 만들어서 묶음
- COMMIT : 트랜잭션에 담겨있는 변경 사항들을 실제 DB에 반영시킴 (후에 트랜잭션은 사라짐)
- ROLLBACK : 트랜잭션에 담겨있는 변경 사항들을 삭제(취소)한 후 마지막 COMMIT 시점으로 돌아감
- SAVEPOINT 포인트명 : 현재 시점에 해당 포인트명으로 임시저장점을 정의해둠. ROLLBACK시 전체 취소가 아닌 일부만 취소 가능
- DDL문 (CREATE, ALTER, DROP)을 수행하는 순간 무조건 COMMIT되므로 DDL문 수행 전 변경 사항들이 있다면 정확히 픽스 (COMMIT, ROLLBACK)하고 진행
## 10. OBJECT (VIEW)
### 10_1. VIEW 뷰
- SELECT문 (쿼리문)을 저장해둘 수 있는 객체
- 자주 쓰는 긴 SELECT문을 저장해두면 매번 긴 SELECT문을 다시 기술할 필요 없음
- 임시테이블 같은 존재 (실제 데이터가 담겨있는 건 아님 => 논리적인 가상 테이블)
- [참고] USER_VIEWS : 현재 사용자가 가지고 있는 뷰 객체에 대한 정보 조회할 수 있는 시스템 테이블
### 10_2. VIEW 생성 / 삭제
- VIEW 생성
  ```
  CREATE [ OR REPLACE ] VIEW 뷰명
  AS 저장시키고자하는쿼리문 (== 서브쿼리);
  ```
  - OR REPLACE : 뷰 생성 시 중복된 이름의 뷰가 없으면 새로 뷰 생성 / 중복된 이름의 뷰가 있으면 해당 뷰를 변경(갱신)하는 옵션
  - VIEW 생성 전 관리자 계정에서 CREATE VIEW 권한 부여
    ```SQL
    GRANT CREATE VIEW TO BR;
    ```
- VIEW 삭제
  ```
  DROP VIEW 뷰명;
  ```
### 10_3. VIEW 컬럼에 별칭 부여
- 서브쿼리의 SELECT절에 산술연산식, 함수식을 기술했을 경우 반드시 별칭 지정
- 서브쿼리의 SELECT절 각 필드에 별칭 부여
- 뷰명 뒤에 모든 필드에 대한 별칭 부여
  ```
  CREATE OR REPLACE VIEW 뷰명(별칭1, 별칭2, ..) => 서브쿼리에 제시한 순서대로 전부 기술
  AS SELECT 서브쿼리
  ```
### 10_4. DML명령어로 VIEW 조작
- 생성된 뷰 이용해서 DML (INSERT, UPDATE, DELETE) 가능 
- 뷰 통해서 조작시 실제 데이터가 담겨있는 베이스테이블에 반영됨
- DML로 조작이 불가능한 경우 (가능할 수도 불가능할 수도 있음)
  - 뷰에 정의되어있지 않은 컬럼을 조작하려고 하는 경우
  - 뷰에 정의되어있지 않은 컬럼 중 베이스테이블상에 NOT NULL 제약조건이 걸려 있는 경우
  - 산술연산식 또는 함수식으로 정의되어있는 경우
  - 그룹함수나 GROUP BY 절이 포함되어있는 경우
  - DISTINCT 구문이 포함되어있는 경우
  - JOIN을 이용해서 여러 테이블을 연결시켜놓은 경우
### 10_5. VIEW 옵션
```
CREATE [ OR REPLACE ] [ FORCE | NOFORCE ] VIEW 뷰명
AS 서브쿼리
[ WITH CHECK OPTION ]
[ WITH READ ONLY ]
```
- FORCE / NOFORCE
  - FORCE : 서브쿼리에 기술된 테이블이 존재하지 않아도 뷰 생성 가능
    - 생성은 되지만 해당 테이블을 생성해야만 그때부터 뷰 활용 가능
  - NOFORCE : 서브쿼리에 기술된 테이블이 존재해야만 뷰 생성 가능 (생략시 기본값)
- WITH CHECK OPTION : DML시 서브쿼리에 기술된 조건에 부합하는 값으로만 DML이 가능하도록 함
  - 서브쿼리에 기술된 조건이 맞지 않으면 오류 발생
- WITH READ ONLY : 뷰에 대해 조회만 가능 (DML문 시행 불가)
## 11. OBJECT (SEQUENCE)
### 11_1. SEQUENCE 시퀀스
- 자동으로 숫자 발생시켜주는 역할을 하는 객체
- 정수값을 순차적으로 일정값씩 증가시키면서 생성해줌
- EX) 회원번호, 사원번호, 게시글번호, ...
- [참고] USER_SEQUENCES : 이 사용자가 가지고 있는 시퀀스들의 구조를 보고자할 때의 시스템 테이블
### 11_2. SEQUENCE 객체 생성 / 삭제
- SEQUENCE 생성
  ```
  CREATE SEQUENCE 시퀀스명
  [ START WITH 시작숫자 ]ㅤㅤㅤㅤㅤㅤㅤ처음 발생시킬 시작값 지정 (기본값 1)
  [ INCREMENT BY 숫자 ]ㅤㅤㅤㅤㅤㅤㅤㅤ몇 씩 증가시킬건지 (기본값 1)
  [ MAXVALUE 숫자 ]ㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤ최대값 지정 (기본값 겁나 큼)
  [ MINVALUE 숫자 ]ㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤ최소값 지정 (기본값 1)
  [ CYCLE | NOCYCLE ]ㅤㅤㅤㅤㅤㅤㅤㅤㅤ값 순환 여부 지정 (기본값 NOCYCLE)
  [ NOCACHE | CACHE 바이트크기 ]ㅤㅤㅤ캐시메모리 할당 (기본값 CACHE 20)
  ```
  - 캐시메모리 : 미리 발생될 값들을 생성해서 저장해두는 공간
    - 매번 호출할때마다 새로이 숫자를 생성하는게 아니라 캐시메모리 공간에 미리 생성된 값들을 가져오기 때문에 속도가 빨라짐
    - 접속이 해제되면 캐시메모리에 미리 만들어둔 번호가 날라감
- SEQUENCE 삭제
  ```
  DROP SEQUENCE 시퀀스명;
  ```
### 11_3. SEQUENCE 사용 (숫자 발생)
- 시퀀스명.CURRVAL : 현재 시퀀스의 값 (마지막으로 성공적으로 수행된 NEXTVAL)
- 시퀀스명.NEXTVAL : 일정값을 증가시켜서 새로이 발생된 값
ㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤ현재 시퀀스 값에 INCREMENT BY값 만큼 증가된 값
- NEXTVAL를 수행하지 않으면 CURRVAL을 사용할 수 없음
- 지정한 MAXVALUE값 초과하면 .NEXTVAL 수행  오류 발생
### 11_4. SEQUENCE 변경
```
ALTER SEQUENCE 시퀀스명
[ INCREMENT BY 증가값 ]
[ MAXVALUE 최대값 ]
[ MINVALUE 최소값 ]
[ CYCLE | NOCYCLE ]
[ NOCACHE | CACHE 바이트크기 ]
```
=> START WITH 변경불가능
### 11_5. INSERT문에서 시퀀스 활용
```SQL
CREATE SEQUENCE SEQ_EID
START WITH 300
NOCACHE;

INSERT 
  INTO EMPLOYEE
       (EMP_ID, EMP_NAME, EMP_NO, JOB_CODE, HIRE_DATE)
VALUES
       (SEQ_EID.NEXTVAL, ?, ?, ?, SYSDATE);
```
## 12. PL/SQL
### 12_1. PL/SQL (PROCEDURE LANGUAGE EXTENSION TO SQL)
- 오라클에 내장되어있는 절차적 언어
- SQL문 내에서 변수 활용, 조건처리 (IF), 반복처리 (LOOP, FOR, WHILE) 등 지원하여 SQL의 단점 보완
- 다수의 SQL문을 한번에 실행 가능 (BLOCK 구조)
- 구조
  - [ 선언부 (DECLARE SECTION) ] : DECLARE로 시작, 변수나 상수 선언 및 초기화
  - 실행부 (EXECUTABLE SECTION) : BEGIN로 시작, SQL문 또는 제어문 (조건문, 반복문) 등의 로직 기술
  - [ 예외처리부 (EXCEPTION SECTION) ] : EXCEPTION로 시작, 예외 발생시 해결하기 위한 구문 미리 기술
- 출력을 위해 SET SERVEROUTPUT ON; 한 번 실행해두기
### 12_2. DECLARE 선언부
- 변수 및 상수 선언하는 공간 (선언과 동시에 초기화 가능)
- 일반타입변수, 레퍼런스타입변수, ROW타입변수
- 일반타입변수 선언 및 초기화
  ```
  변수명 [ CONSTANT ] 자료형 [ := 값 ];
  ```
- 레퍼런스타입변수 선언 및 초기화
  ```
  변수명 테이블명.컬럼명%TYPE;
  ```
  => 특정 컬럼의 데이터타입을 참조하여 그 타입으로 지정
- ROW타입변수
  - 테이블의 한 행에 대한 모든 컬럼값을 한꺼번에 담을 수 있는 변수
  ```
  변수명테이블명%ROWTYPE;
  ```
  => 테이블 내 컬럼 하나하나에 접근 (전체 한번에 출력 X)
### 12_3. BEGIN 실행부
- 조건문
  - IF ~ THEN ~ END IF
    ```
    IF 조건식 THEN 실행내용 END IF;
    ```
    => 단일 IF문
  - IF ~ THEN ~ ELSE ~ END IF
    ```
    IF 조건식 THEN 실행내용 ELSE 실행내용 END IF;
    ```
    => IF - ELSE문
  - IF ~ THEN ~ ELSIF ~ ELSE ~ END IF
    ```
    IF 조건식1 THEN 실행내용1 ELSIF 조건식2 THEN 실행내용2 ... [ ELSE 실행내용N ] END IF;
    ```
  - CASE
    ```
    CASE 비교대상자 WHEN 비교값1 THEN 결과값1 WHEN 비교값2 THEN 결과값2 ... [ ELSE 결과값N ] END;
    ```
    => SWITCH문
- 반복문
  - BASIC LOOP문
    ```
    LOOP
      반복적으로 실행할 구문;
      반복문을 빠져나갈 수 있는 구문;
    END LOOP;
    ```
    => 반복문을 빠져나갈 수 있는 구문
      - IF 조건식 THEN EXIT; END IF;
      - EXIT WHEN 조건식;
  - FOR LOOP문
    ```
    FOR 변수 IN [ REVERSE ] 초기값..최종값
    LOOP
      반복적으로 실행할 구문;
    END LOOP;
    ```
    - 변수 DECLARE할 필요 없음
    - REVERSE : 1씩 줄어듦
  - WHILE LOOP문
    ```
    WHILE 반복문이 수행될 조건
    LOOP
      반복적으로 실행할 구문;
    END LOOP;
    ```
### 12_4. 예외처리부 EXCEPTION
- 예외 (EXCEPTION) : 실행 중 발생되는 오류
- 실행부 다음에 작성
```
EXCEPTION
  WHEN 예외명1 THEN 예외처리구문1;
  WHEN 예외명2 THEN 예외처리구문2;
  ...
  WHEN OTHERS THEN 예외처리구문;
```
- 시스템예외 (오라클에서 미리 정의해둔 예외)
  - NO_DATA_FOUND : SELECT한 결과가 한 행도 없을 경우
  - TOO_MANY_ROWS : SELECT한 결과가 여러 행일 경우
  - ZERO_DIVIDE : 0으로 나누기했을 경우
  - DUP_VAL_ON_INDEX : UNIQUE 제약조건에 위배되었을 경우
## 13. OBJECT (TRIGGER)
### 13_1. TRIGGER 트리거
- 내가 지정한 테이블에  INSERT, UPDATE, DELETE 등의 DML문에 의해 변경사항이 생길 때 (즉, 테이블에 이벤트 발생했을 때) 매번 "자동으로 실행시킬 내용"을 미리 정의해둘 수 있는 객체
- 회원 탈퇴시 기존의 회원 테이블에 데이터 DELETE 후 곧바로 탈퇴된 회원들만 따로 보관하는 테이블에 자동으로 INSERT처리
- 회원의 신고횟수가 일정 수를 넘었을 때 묵시적으로 해당 회원을 블랙리스트로 처리
- 입출고에 대한 데이터가 기록(INSERT)될 때마다 해당 상품에 대한 재고 수량을 매번 수정(UPDATE)
### 13_2. TRIGGER 종류
- SQL문의 실행시기에 따른 분류
  - BEFORE TRIGGER : 지정한 테이블에 이벤트가 발생되기 전에 트리거 실행
  - AFTER TRIGGER : 지정한 테이블에 이벤트가 발생된 후에 트리거 실행
- SQL문에 의해 영향을 받는 각 행에 따른 분류
  - STATEMENT TRIGGER (문장트리거) : 이벤트가 발생한 SQL문에 대해 딱 한번만 트리거 실행
  - ROW TRIGGER (행트리거) : 해당 SQL문이 실행될 때마다 매번 트리거 실행 (FOR EACH ROW 옵션 기술)
    - :OLD - BEFORE UPDATE (수정전 데이터), BEFORE DELETE (삭제전 데이터)
    - :NEW - AFTER INSERT (추가된 데이터), AFTER UPDATE (수정후 데이터)
### 13_3. TRIGGER 생성 구문
```
CREATE [ OR REPLACE ] TRIGGER 트리거명
BEFORE|AFTER INSERT|UPDATE|DELETE ON 테이블명
[ FOR EACH ROW ]
[ DECLARE
    변수선언; ]
BEGIN
    실행내용(위에 지정된 이벤트 발생시 묵시적으로(자동으로) 실행할 구문)
[ EXCEPTION
    예외처리구문; ]
END;
/
```
