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
