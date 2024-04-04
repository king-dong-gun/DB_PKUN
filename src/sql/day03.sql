-- day02 이어서
-- 사원 이름중에 a와 e가 있는 사원을 출력하시오
SELECT *
FROM EMP
WHERE ENAME LIKE '%A%'
  AND ENAME LIKE '%E';

-- NULL은 비교연산자를 사용할 수 없다.
SELECT *
FROM EMP
WHERE COMM = NULL;

SELECT ENAME, SAL, SAL * 12 + COMM, COMM
FROM EMP e;

-- NULL인 열을 찾는다.
SELECT *
FROM EMP e
WHERE COMM IS NULL;

-- 사수가 있는 사원을 출력하시오
SELECT *
FROM EMP e
WHERE MGR IS NOT NULL;

-- 수당에서 0을 제외한 사원을 출력하시오
SELECT *
FROM EMP e
WHERE COMM IS NOT NULL
  AND COMM != 0;

-- 사원명을 모두 대문자로 변경
SELECT ENAME, UPPER(ENAME)
FROM EMP e;
-- 사원명을 모두 소문자로 변경
SELECT ENAME, LOWER(ENAME)
FROM EMP e;

-- 문자열의 첫글자만 대문자, 나머지는 소문자로 변경
SELECT ENAME, INITCAP(ENAME)
FROM EMP e;

SELECT EMPNO, ENAME, SAL, DEPTNO
FROM EMP e
WHERE DEPTNO = 10

UNION
-- 집합 연산자
SELECT EMPNO, ENAME, SAL, DEPTNO
FROM EMP e
WHERE DEPTNO = 20;
-- 합집합
SELECT EMPNO, ENAME, SAL, DEPTNO
FROM EMP e
WHERE DEPTNO = 10
UNION
-- 집합 연산자
SELECT SAL, JOB, DEPTNO, SAL
FROM EMP e
WHERE DEPTNO = 20;
-- 차집합
SELECT EMPNO, ENAME, SAL, DEPTNO
FROM EMP e
MINUS
-- 집합 연산자
SELECT EMPNO, ENAME, SAL, DEPTNO
FROM EMP e2
WHERE DEPTNO = 10;

-- 교집합
SELECT EMPNO, ENAME, SAL, DEPTNO
FROM EMP e
INTERSECT
-- 집합 연산자
SELECT EMPNO, ENAME, SAL, DEPTNO
FROM EMP e2
WHERE DEPTNO = 10;

-- 사원명 문자열 길이 확인
SELECT ENAME, LENGTH(ENAME)
FROM EMP;
-- 사원명 문자열이 5글자 이상인 사원 출력
SELECT ENAME, LENGTH(ENAME)
FROM EMP
WHERE LENGTH(ENAME) >= 5;

-- length(): 문자길이,  lengthb(): 문자 바이트 크기
SELECT LENGTH('오라클'), LENGTHB('오라클')
FROM dual;

-- 문자열 일부를 추출 substr 함수
SELECT JOB, SUBSTR(JOB, 1, 2), SUBSTR(JOB, 3, 2), SUBSTR(JOB, 5)
FROM EMP;

-- substr 함수를 사용해서 모든 사원의 이름을 세번째부터 출력하시오
SELECT ENAME, SUBSTR(ENAME, 3)
FROM EMP;

-- 특정문자 위치를 찾는 instr 함수
SELECT INSTR('HELLO, ORACLE!', 'L')       AS instr1, -- 전체 문자열에서 L 찾기
       INSTR('HELLO, ORACLE!', 'L', 5)    AS instr2, -- 5번째 문자부터 L 찾기
       INSTR('HELLO, ORACLE!', 'L', 2, 2) AS instr3  -- 2번째 문자부터 2번째로 있는 L 찾기
FROM dual;

-- 사원명에 S를 가진 사원 출력
SELECT *
FROM EMP
WHERE INSTR(ENAME, 'S') > 0;
-- LIKE() 연산자보다 조금 더 세밀한 검색 가능
/*===================================*/
SELECT *
FROM EMP
WHERE ENAME LIKE ('%S%');

/* 문자변환 REPLACE 함수 */
SELECT '010-1234-5678'
           AS replace1,
       REPLACE('010-1234-5678', '-', ' ') -- '-'문자열을 공백처리
           AS replace2,
       REPLACE('010-1234-5678', '-') -- '-'문자열 삭제
           AS replace3
FROM dual;

/* 빈공간을 메우는 LPAD, RPAD 함수 */
SELECT 'Oracle',
       LPAD('Oracle', 10, '#') AS lpad1,
       RPAD('Oracle', 10, '*') AS rpad1,
       LPAD('Oracle', 10)      AS lpad2,
       RPAD('Oracle', 10)      AS rpad2
FROM dual;

-- 주민번호, 전화번호 끝에 7자리, 4자리를 '*'로 출력하시오
SELECT RPAD('970619-', 14, '*')   AS residenNum,
       RPAD('010-2129-', 13, '*') AS phoneNum
FROM dual;

/* 특정문자를 지우는 TRIM, LTRIM, RTRIM 함수 */
SELECT '[' || TRIM('__Oracle__') || ']'               AS trim,
       '[' || TRIM(LEADING FROM '__Orcale__') || ']'  AS trim_LEADING,
       '[' || TRIM(TRAILING FROM '__Orcale__') || ']' AS trim_TRAILING,
       '[' || TRIM(BOTH FROM '__Orcale__') || ']'     AS trim_BOTH
FROM dual;

/* 반올림 함수 ROUND */
SELECT ROUND(1234.5678),     -- 소수점 이하를 반올림하지 않고 가장 가까운 정수로 반올림
       ROUND(1234.5678, 0),  -- 두 번째 매개변수가 0이기 때문에 소수점 이하를 반올림할 자릿수 없음
       ROUND(1234.5678, 1),  -- 소수점 첫 번째 자릿수에서 반올림
       ROUND(1234.5678, -1), -- 자연수 첫째 자리 반내림
       ROUND(1234.5678, -2)  -- 자연수 둘째 자리 반내림
FROM dual;

/* 버림하는 함수 TRUNC */
SELECT TRUNC(1234.5678),
       TRUNC(1234.5678, 0),
       TRUNC(1234.5678, 1),
       TRUNC(1234.5678, -1)
FROM dual;

/* 나머지를 구하는 함수 MOD */
SELECT MOD(15, 2),
       MOD(10, 2),
       MOD(1, 2)
FROM dual;

-- 각 사원별 시급을 계산하여 부서번호, 사원이름, 시급을 출력
-- 1. 한달 근무일 20일, 하루 근무시간 8시간.
-- 2. 부서별로 오름차순 정렬
-- 3. 시급은 소수 2자리까지
-- 4. 시급이 높은순으로 출력
SELECT DEPTNO, ENAME, ROUND(SAL / (20 * 8), 2) AS HOURSAL
FROM EMP
ORDER BY HOURSAL DESC, DEPTNO, ENAME;

/* 날짜 함수 */
SELECT SYSDATE     AS now,
       SYSDATE - 1 AS yesterday,
       SYSDATE + 1 AS tomorrow
FROM dual;

-- 3달 뒤 출력
SELECT SYSDATE, ADD_MONTHS(SYSDATE, 3)
FROM dual;

-- 입사 10주년이 되는 사원번호, 사원명, 입사일, 10주년 날짜 출력
SELECT EMPNO, ENAME, HIREDATE, ADD_MONTHS(HIREDATE, 120)
FROM EMP;

-- 두 날짜간의 개월 차
SELECT EMPNO,
       ENAME,
       HIREDATE,
       SYSDATE,
       MONTHS_BETWEEN(HIREDATE, SYSDATE)        AS MONTHS1,
       MONTHS_BETWEEN(SYSDATE, HIREDATE)        AS MONTHS2,
       TRUNC(MONTHS_BETWEEN(SYSDATE, HIREDATE)) AS MONTHS2
FROM EMP;

-- 요일, 마지막 날짜
SELECT SYSDATE,
       NEXT_DAY(SYSDATE, '월요일'), -- 현재 날짜에서 그 다음 월요일 찾기
       LAST_DAY(SYSDATE)         -- 해당 달의 마지막 날
FROM dual;

-- 년월의 반올림, 반내림
SELECT SYSDATE,
       TO_CHAR(SYSDATE, 'CC')   AS FORMAT_CC,  -- 날짜를 CC(세기) 형식으로 변환
       TO_CHAR(SYSDATE, 'YYYY') AS FORMAT_YYYY -- 날짜를 YYYY(년도) 형식으로 변환
FROM dual;

/* 형변환 함수 */

-- 'SCOTT'사원의 사원번호에 500 더하기
-- 암묵적 형변환
SELECT EMPNO, ENAME, EMPNO + '500'
FROM EMP
WHERE ENAME = 'SCOTT';
-- 'SCOTT'사원의 사원번호에 500 더하기

-- 암묵적 형변환이 되지 않아 명시적 형변환을 사용해야한다.
-- 그러므로 밑의 코드는 컴파일이 되지않음
/* SELECT 'ABCD' + EMPNO, EMPNO
FROM EMP
WHERE ENAME = 'SCOTT'; */

-- 이렇게 명시적 형변환을 해야한다
SELECT 'ABCD' || TO_CHAR(EMPNO), EMPNO
FROM EMP
WHERE ENAME = 'SCOTT';

-- 날짜 함수 문자변환
SELECT TO_CHAR(SYSDATE, 'YYYY/MM/DD HH24:MI:SS')
           AS 현재날짜시간
FROM dual;

SELECT SYSDATE,
       TO_CHAR(SYSDATE, 'MM')    AS MM,
       TO_CHAR(SYSDATE, 'MON')   AS MON,
       TO_CHAR(SYSDATE, 'MONTH') AS MONTH,
       TO_CHAR(SYSDATE, 'DD')    AS DD,
       TO_CHAR(SYSDATE, 'DY')    AS DY,
       TO_CHAR(SYSDATE, 'DAY')   AS DAY
FROM dual;

-- NLS_DATE_LANGUAGE 로 날짜 글자도 변경 가능
SELECT SYSDATE,
       TO_CHAR(SYSDATE, 'MM')                                  AS MM,
       TO_CHAR(SYSDATE, 'MON', 'NLS_DATE_LANGUAGE = KOREAN')   AS MON_K,
       TO_CHAR(SYSDATE, 'MON', 'NLS_DATE_LANGUAGE = JAPANESE') AS MON_J,
       TO_CHAR(SYSDATE, 'MON', 'NLS_DATE_LANGUAGE = ENGLISH')  AS MON_E,
FROM dual;

SELECT SYSDATE,
       TO_CHAR(SYSDATE, 'HH24:MI:SS')    AS HH24MISS,
       TO_CHAR(SYSDATE, 'HH12:MI:SS AM') AS HH12MISS_AM,
       TO_CHAR(SYSDATE, 'HH:MI:SS PM')   AS HHMISS_PM
FROM dual;

SELECT TO_DATE('2017-05-29', 'YYYY-MM-DD') AS TODATE1,
       TO_DATE('20190217', 'YYYY-MM-DD')   AS TODATE2
FROM dual;

-- 1981년 12월 01일 이후에 입사한 사원정보를 출력하시오
SELECT EMPNO, ENAME, HIREDATE
FROM EMP
WHERE TO_DATE (HIREDATE) > '19811201';
