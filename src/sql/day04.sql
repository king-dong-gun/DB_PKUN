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

-- EMP와 SALEGRADE 테이블을 조인하여 SAL이 SALEGRADE의 LOSAL과 HISAL 사이인 행을 선택
SELECT *
FROM EMP E,
     SALEGRADE S
-- EMP의 SAL 컬럼 값이 SALEGRADE의 LOSAL과 HISAL 사이에 있는 조건을 검사
WHERE E.SAL BETWEEN s.LOSAL AND S.HISAL;

-- EMP와 EMP를 조인하여 MGR의 정보를 포함한 결과를 선택
SELECT
    -- 첫 번째 직원(하위 직원)
    E.EMPNO,
    E.ENAME,
    E.MGR,
    -- 두 번째 직원(상위 직원)
    E2.EMPNO,
    E2.ENAME,
    E2.MGR AS MGR_ENAME -- 관리자의 관리자 이름을 MGR_ENAME으로 별칭을 지정
FROM EMP E,
     EMP E2
WHERE E.MGR = E2.EMPNO (+) -- E 테이블의 MGR 컬럼과 E2 테이블의 EMPNO 컬럼을 조인
ORDER BY E.EMPNO;

SELECT E.EMPNO,
       E.ENAME,
       E.JOB,
       E.MGR,
       E.HIREDATE,
       E.SAL,
       E.COMM,
       DEPTNO,
       D.DNAME,
       D.LOC
FROM EMP E
         NATURAL JOIN DEPT D;
-- NATURAL JOIN은 하나의 칼럼으로 나타낸다

/* JOIN ON */
-- INNER JOIN
SELECT *
FROM EMP E
         JOIN DEPT D ON (E.DEPTNO = D.DEPTNO) -- INNER JOIN은 별개의 칼럼으로 나타낸다
WHERE SAL >= 3000;

/* OUTTER JOIN */
SELECT E.EMPNO,
       E.ENAME,
       E.MGR,
       E2.EMPNO AS MGR_DMPNO,
       E2.ENAME AS MGR_ENAME
FROM EMP E
         LEFT OUTER JOIN EMP E2 ON (E.MGR = E2.EMPNO); -- 왼쪽 외부 조인

SELECT E.EMPNO,
       E.ENAME,
       E.MGR,
       E2.EMPNO AS MGR_DMPNO,
       E2.ENAME AS MGR_ENAME
FROM EMP E
         RIGHT OUTER JOIN EMP E2 ON (E.MGR = E2.EMPNO);
-- 왼쪽 외부 조인

/* 서버쿼리 */
SELECT *
FROM EMP;

SELECT ROWNUM, EMP.*
FROM EMP;

SELECT *
FROM (SELECT ROWNUM, EMP.* FROM EMP)
WHERE ROWNUM BETWEEN 1 AND 5;

-- 서브쿼리의 ROWNUM이 아니라 메인의 ROWNUM이기 때문에 6부터 출력 불가
SELECT *
FROM (SELECT ROWNUM, EMP.* FROM EMP)
WHERE ROWNUM BETWEEN 6 AND 10;
-- 수정 >> 출력가능
SELECT *
FROM (SELECT ROWNUM RNUM, EMP.* FROM EMP)
WHERE RNUM BETWEEN 6 AND 10;

-- 급여를 내림차순으로 정렬하고 상위 5명 정보출력
SELECT *
FROM (SELECT ROWNUM RNUM, EMP.*
      FROM EMP
      ORDER BY SAL DESC)
WHERE ROWNUM BETWEEN 1 AND 5;

-- SCOTT보다 급여를 받는 사원 출력
SELECT ENAME, SAL
FROM EMP
WHERE SAL > (SELECT SAL FROM EMP WHERE ENAME = 'SCOTT');

-- 평균월급 이상을 받는 사원
SELECT ENAME, SAL
FROM EMP
WHERE SAL > ((SELECT AVG(SAL) FROM EMP));




