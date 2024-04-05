/* 문제 */
SELECT *
FROM EMP;

-- 1. EMP 테이블에서 부서 인원이 4명보다 많은 부서의 부서번호, 인원수, 급여 합을 출력
-- GROUP BY문
-- 모든 행을 세는 COUNT(*)
SELECT DEPTNO, COUNT(*), SUM(SAL)
FROM EMP
GROUP BY DEPTNO
HAVING COUNT(*) > 4;

-- 2. EMP 테이블에서 가장 많은 사원이 속해있는 부서번호와 사원수를 출력
-- GROUP BY문, 서브 쿼리
SELECT DEPTNO, COUNT(*)
FROM EMP
GROUP BY DEPTNO
HAVING COUNT(DEPTNO) =
       (SELECT MAX(COUNT(*))
        FROM EMP
        GROUP BY DEPTNO);


-- 3. EMP 테이블에서 가장 많은 사원을 갖는 MGR의 사원번호를 출력
-- GROUP BY문, 서브 쿼리
SELECT MGR EMPNO
FROM EMP
GROUP BY MGR
HAVING COUNT(MGR) =
       (SELECT MAX(COUNT(*))
        FROM EMP
        GROUP BY MGR);

-- 4. EMP 테이블에서 부서번호가 10인 사원수와 부서번호가 30인 사원수를 각각 출력
-- 조건문
SELECT COUNT(DECODE(DEPTNO, 10, 1)),
       COUNT(DECODE(DEPTNO, 30, 1))
FROM EMP


