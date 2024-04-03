CREATE TABLE EMP (
                     EMPNO       NUMBER(4) NOT NULL,     -- 사원번호
                     ENAME       VARCHAR2(10),           -- 사원이름 (VARCHAR2(10)으로 수정)
                     JOB         VARCHAR2(9),            -- 업무
                     MGR         NUMBER(4),              -- 사수번호
                     HIREDATE    DATE,                   -- 입사일
                     SAL         NUMBER(7,2),            -- 월급
                     COMM        NUMBER(7,2),            -- 커미션
                     DEPTNO      NUMBER(2)               -- 부서번호
);


SELECT * FROM emp;



INSERT INTO emp VALUES (7499, 'ALLEN', 'SALEMAN', 7698, to_date('20_02_1981', 'dd-mm-yyyy'), 1600, 300, 30);

INSERT INTO emp VALUES (7521, 'WARD', 'SALEMAN', 7698, to_date('22_02_1981', 'dd-mm-yyyy'), 1250, 500, 30);

INSERT INTO emp VALUES (7566, 'JONES', 'MANAGER', 7839, to_date('02_04_1981', 'dd-mm-yyyy'), 2975, NULL, 20);

INSERT INTO emp VALUES (7654, 'MARTIN', 'SALEMAN', 7698, to_date('29_09_1981', 'dd-mm-yyyy'), 1250, 1400, 30);

INSERT INTO emp VALUES (7698, 'BLAKE', 'MANAGER', 7698, to_date('01_05_1981', 'dd-mm-yyyy'), 2850, NULL, 30);

INSERT INTO emp VALUES (7782, 'CLARK', 'MANAGER', 7839, to_date('09_06_1981','dd-mm-yyyy'), 2450, NULL, 10);

INSERT INTO emp VALUES (7788, 'SCOTT', 'ANALYST', 7566, to_date('13_07_1987', 'dd-mm-yyyy'), 3000, NULL, 20);

INSERT INTO emp VALUES (7839, 'KING', 'PRESIDENT', NULL, to_date('17_11_1981', 'dd-mm-yyyy'), 5000, NULL, 10);

INSERT INTO emp VALUES (7844, 'TURNER', 'SALESMAN', 7698, to_date('08_09_1981', 'dd-mm-yyyy'), 1500, NULL, 30);

INSERT INTO emp VALUES (7876, 'ADAMS', 'CLERK', 7788, to_date('13_07_1987', 'dd-mm-yyyy'), 1100, NULL, 20);

INSERT INTO emp VALUES (7900, 'JAMES', 'CLERK', 7698, to_date('13_12_1981', 'dd-mm-yyyy'), 950, NULL, 30);

INSERT INTO emp VALUES (7902, 'FORM', 'ANALYST', 7566, to_date('03_12_1981', 'dd-mm-yyyy'), 3000, NULL, 20);

INSERT INTO emp VALUES (7934, 'MILLER', 'CLERK', 7782, to_date('23_01_1982', 'dd-mm-yyyy'), 1300, NULL, 10);

COMMIT;
SELECT * FROM emp;

CREATE TABLE DEPT (
                      DEPTNO  NUMBER(2),      -- 부서번호
                      DNAME   VARCHAR2(4),    -- 부서명
                      LOC     VARCHAR2(13)    -- 지역
);

SELECT * FROM dept;

INSERT INTO dept VALUES (10, 'ACCOUNTING', 'NEW YORK');

ALTER TABLE dept MODIFY dname varchar2(14);

INSERT INTO dept VALUES (20, 'RESEARCH', 'DALLAS');
INSERT INTO dept VALUES (30, 'SELES', 'CHICAGO');
INSERT INTO dept VALUES (40, 'OPERATIONS', 'BOSTON');

CREATE TABLE bonus (
                       ENAME   VARCHAR2(10),
                       JOB     VARCHAR2(9),
                       SAL     NUMBER,
                       COMM    NUMBER
);

CREATE TABLE salegrade (    --급여정도
                           GRADE   NUMBER,
                           LOSAL   NUMBER,
                           HISAL   NUMBER
);

INSERT INTO salegrade s VALUES (1, 700, 1200);
INSERT INTO salegrade s VALUES (2, 1201, 1400);
INSERT INTO salegrade s VALUES (3, 1401, 2000);
INSERT INTO salegrade s VALUES (4, 2001, 3000);
INSERT INTO salegrade s VALUES (5, 3001, 9999);

SELECT * FROM emp;  -- 전체조회

SELECT empno, ename, sal FROM emp;  --필요 행만 가져오기 (사원번호, 사원이름, 월급)

SELECT ename "이름", sal "월급" FROM emp;   -- ename -> 이름, sal -> 월급 변경


-- 사원번호, 사원이름, 월급, 연봉을 구하고 컬럼명은 사원번호, 사원이름, 월급, 연봉으로 출력

SELECT empno "사원번호", ename"이름",sal"월급", sal*12 "연봉" FROM emp;

SELECT DISTINCT job FROM emp e;     -- 중복데이터 제거

SELECT DISTINCT job, deptno FROM emp e;

SELECT ALL job, deptno FROM emp e;

SELECT 'ABC' FROM dual;
SELECT 2 + 3 FROM dual;
SELECT 'ABC', 2 + 3 FROM dual;
SELECT 2+3 AS RESULT FROM dual;
SELECT 1+'5' FROM dual;
SELECT 1||'5' FROM dual;

-- 사원명과 업무로 연결(smith, clerk) 표시, 컬럼명은 employee and job 출력

SELECT '( '|| ename || ', ' || job || ')' as "employee and job" from emp;

-- 사원별 연간 총수입을 조회, 별칭은 연간 총 수입으로 출력
SELECT  ename, sal*12 + comm  AS "연간총수입" FROM emp;

SELECT * FROM emp e ORDER BY sal;   -- 오름차순

SELECT * FROM emp e ORDER BY empno;

SELECT * FROM emp ORDER BY sal DESC;    -- 내림차순

/*===================================================================*/
-- 조건을 추가하는 where 절
select * from emp e where EMPNO = 7839;

-- 사원번호 7698인 사원명과 업무, 급여 출력
select ename, job, sal  from emp e where EMPNO = 7698;
-- smith의 사원명, 부서, 월급
select ENAME, JOB, SAL from emp e where ENAME = 'SMITH';
select * from emp e where SAL = 3000;
select * from emp e where SAL != 3000;
select * from emp e where SAL ^= 4000;
-- <> 5000이 아닌 레코드 출력
select * from emp e where SAL <> 5000;
select * from emp e where not SAL = 6000;
-- 첫문자가 M과 같거나 큰 문자열 출력
select * from emp e where ENAME >= 'M';

-- 월급이 2500이상 3000미만의 사원명과 입사일, 월급 출력
select ENAME, HIREDATE, SAL from emp e where 2500 <= SAL and SAL < 3000;

-- 월급이 2000이상 3000이하에 포함되어 있지 않는 사원 출력
select * from EMP e where sal between 2500 and 3000;

-- 81년 5월 1일과 동년 12월 3일 사이에 입사한 사원, 급여, 입사일 출력
select ENAME, SAL, HIREDATE from EMP e where HIREDATE between '1981-05-01' and '1981-12-03';
select ENAME, sal, HIREDATE from EMP e where HIREDATE between to_date('19810501', 'yyyymmdd') and to_date('19811203', 'yyyymmdd');

-- 1987년도에 입사한 사원명, 월급, 입사일 출력
select ENAME, SAL, HIREDATE from EMP e where HIREDATE between to_date('19870101', 'yyyymmdd') and to_date('19871212','yyyymmdd');

-- 직업이 manager, clerk, salesman인 사람 출력
select * from EMP e where job = 'MANAGER' or job = 'CLERK' or job = 'SALESMAN' ;

select * from EMP e where job in ('MANAGER', 'CLERK', 'SALESMAN');

-- 사번이 7566, 7782, 7934인 사원을 제외한 사번, 사원명, 급여 출력
select EMPNO, ENAME, SAL from EMP e where EMPNO not in (7566, 7782, 7934);

-- 부서번호 30에서 근무하고 급여 2000 이하를 받는 81년 5월 1일 이전에 입사한 사원의 사원명, 급여, 부서번호, 입사일 출력
select ENAME, SAL, DEPTNO, HIREDATE from emp e where DEPTNO = 30 and SAL <= 2000 and HIREDATE > '1981-05-01';

-- 부서번호가 10 또는 30인 부서에서 급여가 2000 ~ 5000 사이의 사원의 사원명, 급여, 부서번호 출력
select ENAME, SAL, DEPTNO from EMP e where (DEPTNO = 10 or DEPTNO = 30) and SAL between 2000 and 5000;
select ENAME, SAL, DEPTNO from emp e where DEPTNO IN (10, 30) and SAL between 2000 and 5000;

-- 직업이 MANAGER 또는 SALESMAN 이고 급여가 1600, 2975, 2850이 아닌 사원명, 입사일, 급여, 부서번호 출력
select ENAME, HIREDATE, SAL, DEPTNO from EMP e where JOB in ('MANAGER', 'SALESMAN') and SAL not in (1600, 2975, 2850);

select * from dept d;

/*=====================================================*/
select * from EMP e where ENAME like 'S%';  -- 첫글자가 S인 문자열 출력
select * from emp e where ename like '_L%'; -- 두번째 글자가 L인 문자열 출력

-- 사원 이름중 S가 포함되지 않는 부서번호 20인 사원의 사원명, 부서번호 출력
select ENAME, DEPTNO from EMP e where ENAME not like '%S%' and DEPTNO = 20;

-- 1981년 6월 1일 ~ 12월 31일 입사자 중 부서명이 30인 사원의 부서번호, 사원명, 직업, 입사일 출력(입사일 오름차순 정렬)
select DEPTNO, ENAME, JOB, HIREDATE from EMP e where HIREDATE between '1981-06-01' and '1981-12-31' and DEPTNO = 30;


