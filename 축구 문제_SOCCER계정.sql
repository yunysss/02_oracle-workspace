--1. PLAYER 테이블에서 K02, K05 팀에 해당하는 선수들의 이름과 포지션, 등번호, 키를 조회하시오.
SELECT PLAYER_NAME "이름", POSITION "포지션", BACK_NO "등번호", HEIGHT "키"
FROM PLAYER
WHERE TEAM_ID IN ('K02', 'K05');

--2. PLAYER 테이블에서 국적이 명시된 선수들의 이름과 국적을 조회하시오.
SELECT PLAYER_NAME "이름", NATION "국적"
FROM PLAYER
WHERE NATION IS NOT NULL;

--3. PLAYER 테이블에서 팀ID가 K02이거나 K07인 선수들의 이름과 포지션, 등번호, 팀ID, 키를 조회하시오.
SELECT POSITION "포지션", BACK_NO "등번호", TEAM_ID "팀ID", HEIGHT "키"
FROM PLAYER
WHERE TEAM_ID IN ('K02', 'K07');

--4. TEAM 테이블에서 각 팀의 우편번호 두 개를 '-' 구분자로 합하여 팀ID와 우편번호 조합을 조회하시오.
SELECT TEAM_ID "팀ID", ZIP_CODE1 || '-' || ZIP_CODE2 "우편번호"
FROM TEAM;

--5. PLAYER 테이블에서 모든 선수들의 인원 수와 신장 크기가 등록된 선수의 수, 최대 신장과 최소 신장, 평균 신장의 정보를 조회하시오.
SELECT COUNT(*), COUNT(HEIGHT), MAX(HEIGHT), MIN(HEIGHT), AVG(HEIGHT) 
FROM PLAYER;

--6. PLAYER 테이블을 활용하여 각 팀 별 인원수를 조회하는 SQL을 작성하되 정렬은 인원 수 기준으로 내림차순 정렬하여 조회 하시오.
SELECT TEAM_ID "팀ID", COUNT(*) "인원수"
FROM PLAYER
GROUP BY TEAM_ID
ORDER BY 2 DESC;

--7. PLAYER와 TEAM 테이블을 활용하여 각 선수들의 이름과 소속팀명을 조회 하시오.
SELECT PLAYER_NAME "선수이름", TEAM_NAME "소속팀명"
FROM PLAYER P, TEAM T
WHERE P.TEAM_ID = T.TEAM_ID;

SELECT PLAYER_NAME "선수이름", TEAM_NAME "소속팀명"
FROM PLAYER
JOIN TEAM USING(TEAM_ID);

--8. PLAYER, TEAM, STADIUM 테이블을 활용하여 각 선수들의 정보 중 선수명, 포지션, 출신지, 팀명, 홈경기장 명을 조회하시오.
SELECT PLAYER_NAME "선수명", POSITION "포지션", NATION "출신지", TEAM_NAME "팀명", STADIUM_NAME "홈경기장 명"
FROM PLAYER P, TEAM T, STADIUM S
WHERE P.TEAM_ID = T.TEAM_ID
  AND T.STADIUM_ID = S.STADIUM_ID;

SELECT PLAYER_NAME "선수명", POSITION "포지션", NATION "출신지", TEAM_NAME "팀명", STADIUM_NAME "홈경기장 명"
FROM PLAYER
JOIN TEAM USING(TEAM_ID)
JOIN STADIUM USING(STADIUM_ID);

-- 9. TEAM, STADIUM 테이블을 활용하여 각 팀의 이름과 경기장ID, 경기장명을 조회하되 경기장ID가 존재하는 팀만 조회 하고 결과는 경기장 명이 오름차순 정렬이 되도록 조회하시오.
SELECT TEAM_NAME "팀 이름", T.STADIUM_ID "경기장ID", STADIUM_NAME "경기장명"
FROM TEAM T, STADIUM S
WHERE T.STADIUM_ID = S.STADIUM_ID
ORDER BY 3;

SELECT TEAM_NAME "팀 이름", STADIUM_ID "경기장ID", STADIUM_NAME "경기장명"
FROM TEAM
JOIN STADIUM USING(STADIUM_ID)
ORDER BY 3;

--10. PLAYER 테이블을 활용하여 신장 크기가 모든 선수의 신장 길이의 평균 이상인 선수들의 선수명, 포지션, 등번호를 선수이름 기준 오름차순으로 조회하시오.
SELECT PLAYER_NAME "선수명", POSITION "포지션", BACK_NO "등번호"
FROM PLAYER
WHERE HEIGHT >= (SELECT AVG(HEIGHT)
                   FROM PLAYER)
ORDER BY 1;                   

--11. 선수 중 '정현수'라는 동명이인이 속한 팀의 한글 명칭과 영문 명칭, 소속 지역을 조회하시오.
SELECT TEAM_NAME "한글 명칭", E_TEAM_NAME "영문 명칭", REGION_NAME "소속 지역"
FROM TEAM
WHERE TEAM_NAME IN (SELECT TEAM_NAME
                      FROM PLAYER P, TEAM T
                     WHERE P.TEAM_ID = T.TEAM_ID
                       AND PLAYER_NAME = '정현수'
                    GROUP BY TEAM_NAME);

--12. 선수의 이름과 포지션, 등번호, 팀ID, 팀명을 조회하는 뷰(V_TEAM_PLAYER)를 하나 생성한 뒤 생성한 뷰를 활용하여 '황'씨성을 가진 선수들의 정보를 조회하시오.   (VIEW 수업 후에 풀 것)

--13. 울산 현대 팀에 '박주호' 선수가 새로 영입되었다. 
--해당 선수의 정보 중 포지션은 DF이며 1987년 3월 16일생, 신장과 몸무게가 각각 176cm, 75kg으로 나간다고 했을 때, 
--박주호 선수의 선수ID를 기존 선수들 중 가장 큰 숫자를 지닌 선수에서 숫자를 하나 증가시켜 추가할 수 있는 쿼리를 작성하시오. (난이도 있음!) (INSERT 수업 후에 풀 것)

--14. SCHEDULE에 기록된 정보들 중 HOME팀과 AWAY팀의 합산 점수가 가장 높은 경기의 날짜와 경기장 명, HOME팀 명과 AWAY팀 명, 그리고 각 팀이 기록한 골의 점수를 조회하시오. 
SELECT SCHE_DATE "경기날짜", T1.TEAM_NAME "HOME팀 명", S.HOME_SCORE "HOME팀 점수", T2.TEAM_NAME "AWAY팀 명", S.AWAY_SCORE "AWAY팀 점수"
FROM SCHEDULE S, TEAM T1, TEAM T2
WHERE S.HOMETEAM_ID = T1.TEAM_ID
  AND S.AWAYTEAM_ID = T2.TEAM_ID
  AND HOME_SCORE + AWAY_SCORE = (SELECT MAX(HOME_SCORE + AWAY_SCORE)
                                   FROM SCHEDULE);

SELECT SCHE_DATE "경기날짜", T1.TEAM_NAME "HOME팀 명", S.HOME_SCORE "HOME팀 점수", T2.TEAM_NAME "AWAY팀 명", S.AWAY_SCORE "AWAY팀 점수"
FROM SCHEDULE S
JOIN TEAM T1 ON (S.HOMETEAM_ID = T1.TEAM_ID)
JOIN TEAM T2 ON (S.AWAYTEAM_ID = T2.TEAM_ID)
WHERE HOME_SCORE + AWAY_SCORE = (SELECT MAX(HOME_SCORE + AWAY_SCORE)
                                   FROM SCHEDULE);