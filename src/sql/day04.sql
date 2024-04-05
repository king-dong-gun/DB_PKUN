-- day03 이어서

/* NULL처리 */
SELECT *
FROM EMP;

SELECT COMM * 1.1
FROM EMP;

-- NULL을 0으로 교체
SELECT NVL(COMM, 0)
FROM EMP;

SELECT NVL(COMM, 0) * 1.1
FROM EMP;

SELECT NVL2(COMM, COMM * 1.1, 0)
FROM EMP;

-- 조건에 따라서 값을 선택하는 DECODE 함수
SELECT EMPNO,
       ENAME,
       JOB,
       SAL,
       DECODE(JOB, -- 해당열
              'MANAGER', SAL * 1.1, -- 'MANAGER'에 적용되는 값
              'SALESMAN', SAL * 1.05, -- 'SALESMAN'에 적용되는 값
              'ALALYST', SAL, --  'ALALYST'에 적용되는 값
              SAL * 1.03) AS UPSAL -- 그 외 나머지
FROM EMP;

-- 조건에 따라서 값을 선택하는 CASE 함수
SELECT EMPNO,
       ENAME,
       JOB,
       SAL,
       CASE JOB
           WHEN 'MANAGER' THEN SAL * 1.1
           WHEN 'SALESMAN' THEN SAL * 1.5
           WHEN 'ALALYST' THEN SAL
           ELSE SAL * 1.3
           END AS UPSAL
FROM EMP;

/* 행 제한 */

SELECT *
FROM EMP
WHERE ROWNUM <= 5;

SELECT *
FROM (SELECT EMP.*, ROWNUM AS rnum
      FROM EMP
      WHERE ROWNUM <= 10)
WHERE rnum > 5;

/* 다중함수 */
SELECT *
FROM EMP;

SELECT COUNT(ENAME)
FROM EMP;

-- NULL값은 카운트에서 제외된다
SELECT COUNT(COMM)
FROM EMP;

SELECT COUNT(DEPTNO)
FROM EMP
WHERE DEPTNO = 30;

SELECT SUM(COMM)
FROM EMP;

SELECT SUM(DISTINCT SAL), -- 중복 제거
       SUM(ALL SAL),      -- 중복 포함 전체
       SUM(SAL)           -- 중복포함 전체
FROM EMP;

------------------------------------------------
-- 데이터 갯수 집계
SELECT COUNT(SAL),         -- 중복 포함 전체
       COUNT(ALL SAL),     -- 중복 포함 전체
       COUNT(DISTINCT SAL) -- 중복 제거
FROM EMP;

------------------------------------------------
-- 최대, 최소값
SELECT MAX(SAL),
       MIN(SAL)
FROM EMP
WHERE DEPTNO = 10;

-- 20번 부서에서 신입과 최고참의 입사일 조회
SELECT MAX(HIREDATE),
       MIN(HIREDATE)
FROM EMP
WHERE DEPTNO = 20;

-- 30번 부서의 월급 평균 조회
SELECT AVG(SAL)
FROM emp
WHERE DEPTNO = 30;

/* GROUP BY */
SELECT AVG(SAL)
FROM EMP
WHERE DEPTNO = 10;

SELECT AVG(SAL), '10' AS DEPTINO
FROM EMP
WHERE DEPTNO = 10;
-------------------------------------
SELECT AVG(SAL)
FROM EMP
WHERE DEPTNO = 20;

SELECT AVG(SAL), '20' AS DEPTINO
FROM EMP
WHERE DEPTNO = 20;
-------------------------------------
SELECT AVG(SAL)
FROM EMP
WHERE DEPTNO = 30;

SELECT AVG(SAL), '30' AS DEPTINO
FROM EMP
WHERE DEPTNO = 30;

-- 합집합을 사용해 한번에 출력
SELECT AVG(SAL), '10' AS DEPTINO
FROM EMP
WHERE DEPTNO = 10
UNION
SELECT AVG(SAL), '20' AS DEPTINO
FROM EMP
WHERE DEPTNO = 20
UNION
SELECT AVG(SAL), '30' AS DEPTINO
FROM EMP
WHERE DEPTNO = 30;

-- GROUP BY를 이용해 출력
SELECT AVG(SAL), DEPTNO
FROM EMP
GROUP BY DEPTNO;

SELECT DEPTNO, JOB, AVG(SAL)
FROM EMP
GROUP BY DEPTNO, JOB
ORDER BY DEPTNO, JOB;

/* SELECT *         // 실행순서: 4
   FROM ~~          // 실행순서: 1
   WHERE ~~         // 실행순서: 2
   GROUP BY ~~      // 실행순서: 3
   ORDER BY ~~      // 실행순서: 5
 */

SELECT DEPTNO, JOB, AVG(SAL)
FROM EMP
-- WHERE AVG(SAL) >= 2000      -- WHERE절에서는 집계함수 사용 불가능
GROUP BY DEPTNO, JOB
HAVING AVG(SAL) >= 2000
ORDER BY DEPTNO, JOB;

SELECT DEPTNO, JOB, AVG(SAL)
FROM EMP
WHERE SAL >= 2000 -- 단독으로 가능, 집계는 안됨(-> HAVING 사용가능)
GROUP BY DEPTNO, JOB
HAVING AVG(SAL) >= 2000
ORDER BY DEPTNO, JOB;

/* JOIN 함수 */
SELECT *
FROM DEPT;

SELECT *
FROM EMP;

SELECT *
FROM EMP,
     DEPT;

-- WHERE절에서 열이름 비교하는 조건식으로 조인
-- 등가조인 (Equi-join) -> 일치하는 열이 있는 경우
SELECT E.EMPNO, E.ENAME, D.DEPTNO, D.DNAME
FROM EMP E,
     DEPT D
WHERE E.DEPTNO = D.DEPTNO
ORDER BY D.DEPTNO, E.DEPTNO;

-- JOIN에 조건식 추가 가능
SELECT E.EMPNO, E.ENAME, D.DEPTNO, D.DNAME
FROM EMP E,
     DEPT D
WHERE E.DEPTNO = D.DEPTNO
AND SAL >= 3000;

-- INNER JOIN
SELECT *
FROM EMP E
         INNER JOIN DEPT D ON D.DEPTNO = E.DEPTNO;


