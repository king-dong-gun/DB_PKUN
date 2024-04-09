/* 문제 */
SELECT *
FROM EMP;

-- 1. EMP 테이블에서 부서 인원이 4명보다 많은 부서의 부서번호, 인원수, 급여 합을 출력
-- GROUP BY문
-- 모든 행을 세는 COUNT(*)
SELECT DEPTNO AS 부서번호, COUNT(*) AS 인원수, SUM(SAL) AS 급여합-- 부서 번호(DEPTNO)별로 사원 수와 해당 부서의 전체 급여 합을 출력
FROM EMP
GROUP BY DEPTNO -- 부서 번호(DEPTNO)로 그룹화
HAVING COUNT(*) > 4;
-- 사원 수가 4명 이상인 부서만 필터링


-- 2. EMP 테이블에서 가장 많은 사원이 속해있는 부서번호와 사원수를 출력
-- GROUP BY문, 서브 쿼리
SELECT DEPTNO AS 부서번호, COUNT(*) AS 사원수 -- 부서 번호(DEPTNO)와 해당 부서의 사원 수를 출력
FROM EMP
GROUP BY DEPTNO -- 부서 번호(DEPTNO)로 그룹화
HAVING COUNT(DEPTNO) = -- 각 부서별 사원 수가
       (SELECT MAX(COUNT(*)) -- 모든 부서 중에서 가장 많은 사원 수를
        FROM EMP
        GROUP BY DEPTNO);
-- 부서 번호(DEPTNO)별로 그룹화하여 계산


-- 3. EMP 테이블에서 가장 많은 사원을 갖는 MGR의 사원번호를 출력
-- GROUP BY문, 서브 쿼리
SELECT MGR AS 가장많은사원을갖는MGR사원번호 -- 가장 많이 등장하는 사원의 관리자 번호를 출력
FROM EMP
GROUP BY MGR -- 관리자 번호별로 그룹화
HAVING COUNT(MGR) = -- 그룹화된 각 관리자 번호의 등장 횟수가
       (SELECT MAX(COUNT(*)) -- 모든 그룹 중에서 등장 횟수가 가장 많은 값을
        FROM EMP
        GROUP BY MGR);
-- 관리자 번호별로 그룹화하여 계산


-- 4. EMP 테이블에서 부서번호가 10인 사원수와 부서번호가 30인 사원수를 각각 출력
-- 조건문
SELECT COUNT(DECODE(DEPTNO, 10, 1)) AS 부서번호10, -- 부서번호가 10인 사원 수를 세기 위해 DEPTNO가 10인 경우에 1로 변환 후 COUNT
       COUNT(DECODE(DEPTNO, 30, 1)) AS 부서번호30  -- 부서번호가 30인 사원 수를 세기 위해 DEPTNO가 30인 경우에 1로 변환 후 COUNT
FROM EMP;


----------------------------------------------------------------------------------------------------
/* 1. EMP 테이블에서 사원번호가 7521인 사원의 직업과 같고, 사원번호 7934인 사원의 급여보다 많은 사원의
      사번, 이름, 직업, 급여 출력 */
SELECT EMPNO AS 사원번호,
       ENAME AS 이름,
       JOB   AS 업무,
       SAL   AS 급여
FROM EMP
WHERE JOB = (SELECT JOB FROM EMP WHERE EMPNO = 7521) -- EMPNO가 7521인 사원과 직업이 찾은 사람 찾기
  AND SAL > (SELECT SAL FROM EMP WHERE EMPNO = 7934);
-- EMPNO가 7934인 사원보다 급여가 많은 사람 찾기


-- 2. 직업별로 최소 급여를 받는 사원의 정보를 사원번호, 이름, 업무, 부서명으로 출력
-- 복수형 쿼리
SELECT EMP.EMPNO  AS 사원번호, -- 사원의 사원번호를 부서번호로 출력
       EMP.ENAME  AS 이름,   -- 사원의 이름 출력
       EMP.JOB    AS 업무,   -- 사원의 업무 출력
       DEPT.DNAME AS 부서명   -- 부서의 위치를 부서명으로 출력
FROM EMP
         INNER JOIN DEPT ON EMP.DEPTNO = DEPT.DEPTNO -- EMP 테이블과 DEPT 테이블을 부서번호를 기준으로 조인
WHERE (EMP.JOB, EMP.SAL) IN (SELECT JOB, MIN(SAL) FROM EMP GROUP BY JOB) -- 사원의 업무별 최소 급여를 가지는 사원을 필터링
ORDER BY EMP.JOB DESC;
-- 업무별로 정렬


/* 3. 각 사원별 커미션이 0 또는 NULL이고 부서 위치가 'GO'로 끝나는 사원의 정보를 사원번호, 사원이름, 커미션, 부서번호,
      부서명, 부서위치를 출력 (보너스가 NULL이면 0으로 출력) */
SELECT EMPNO        AS 사원번호,
       ENAME        AS 사원이름,
       EMP.DEPTNO   AS 부서번호,
       MGR          AS 부서위치,
       LOC          AS 부서명,
       DECODE(COMM,
              NULL, 0,
              COMM) AS 커미션 -- COMM이 NULL이면 0으로 출력 아니라면 COMM 그대로 출력
FROM EMP
         INNER JOIN DEPT ON EMP.DEPTNO = DEPT.DEPTNO -- EMP 테이블과 DEPT 테이블을 부서번호를 기준으로 조인
WHERE DEPT.LOC LIKE '%GO'; -- LOC이 GO로 끝나는 문자열 찾기


SELECT *
FROM EMP;

SELECT *
FROM DEPT;

--------------------------------------------------------------------------------------------------

-- 1. EMP 테이블에서 입사일 순으로 사원번호, 이름, 업무, 급여, 입사일자, 부서번호 조회
SELECT EMPNO    AS 사원번호,
       ENAME    AS 사원명,
       JOB      AS 업무,
       SAL      AS 급여,
       DEPTNO   AS 부서번호,
       HIREDATE AS 입사일
FROM EMP
ORDER BY HIREDATE;

-- 2. EMP 테이블에서 부서번호로 정렬한 후 급여가 많은 순으로 사원번호, 이름, 업무, 급여, 부서번호 조회
SELECT EMPNO  AS 사원번호,
       ENAME  AS 사원명,
       JOB    AS 업무,
       SAL    AS 급여,
       DEPTNO AS 부서번호
FROM EMP
ORDER BY DEPTNO, SAL DESC;


-- 3. EMP 테이블에서 모든 SALESMAN의 급여 평균, 최고액, 최저액, 합계를 조회
SELECT AVG(DECODE(JOB, 'SALESMAN', SAL)) AS 급여평균,
       MAX(DECODE(JOB, 'SALESMAN', SAL)) AS 최고액,
       MIN(DECODE(JOB, 'SALESMAN', SAL)) AS 최저액
FROM EMP;


-- 4. EMP 테이블에서 각 부서별로 인원수, 급여평균, 최저급여, 최고급여의 합을 구하여 급여의 합이 많은 순을 조회
         SELECT DEPTNO          AS 부서번호,
       COUNT(DEPTNO)   AS 부서인원수,
       SUM(SAL)        AS 급여합,
       ROUND(AVG(SAL)) AS 평균급여,
       MAX(SAL)        AS 최고액,
       MIN(SAL)        AS 최저액
FROM EMP
GROUP BY DEPTNO
ORDER BY SUM(SAL) DESC;


SELECT *
FROM EMP;

SELECT *
FROM DEPT;



