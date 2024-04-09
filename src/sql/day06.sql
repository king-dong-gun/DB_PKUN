-- day05 이어서

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


