# Day04

## DB 오라클 SQL 학습

### 목차
1. NULL 관련 함수
2. 조건 변환 함수
3. 그룹 함수 (집계함수)
4. GROUP BY, HAVING절
5. JOIN 함수
6. 서브쿼리
7. 문제풀이

#### 1. NULL 관련 함수
> `NVL("값", "지정값") `: `NULL`인 경우 지정값을 출력하고, `NULL`이 아니면 원래 값을 그대로 출력
> `NVL2("값", "지정값1", "지정값2") // NVL2("값", "NOT NULL", "NULL") `: `NULL`이 아닌 경우 지정값1을  출력하고, `NULL`인 경우 지정값2를 출력

#### 2. 조건 변환 함수
> 'DECODE': 조건을 걸어 원하는 원하는 출력 값을 리턴해주는 함수
    - 프로그래밍에서 `ìf else` 같은 역할
> `CASE`: 여러가지 범주를 지닌 조건 각각에 대응하여 값을 리턴해주는 함수
    - 프로그래밍에서 `switch`과 비슷한 역할

#### 3. 그룹 함수 (집계함수)
1. `SUM`: 합계를 출력
2. `MIN`: 최소값 출력
3. `MAX`: 최대값 출력
4. `COUNT`: 데이터 갯수 집계 -> **`NULL`은 `COUNT`에서 제외된다.**
5. `AVG`: 평균값 출력

#### 4. GROUP BY, HAVING절
1. `GROUP BY`: 데이터를 특정 컬럼 기준으로 그룹화시키는 명령어
    - 각 그룹에 대한 연산결과를 나타내기 위해서 다중 함수가 필요
    - 그룹을 나누고 그 그룹내에서 세부그룹으로 나눌 수 있다
2. `ORDER BY`: 데이터를 특정 컬럼 기준으로 그룹화시키는 명령어
    - 정렬의 역할
    - 여러개 칼럼을 기준으로 정렬가능

```oracle
SELECT DEPTNO, JOB, AVG(SAL)
FROM EMP
WHERE AVG(SAL) >= 2000
GROUP BY DEPTNO, JOB
ORDER BY DEPTNO, JOB;
```
> `WHERE AVG(SAL) >= 2000`에서 `WHERE`절은 집계함수와 사용이 불가능해서 컴파일 오류
> `HAVING`절로 수정 

> 수정 코드
```oracle
SELECT DEPTNO, JOB, AVG(SAL)
FROM EMP
GROUP BY DEPTNO, JOB
HAVING AVG(SAL) >= 2000
ORDER BY DEPTNO, JOB;
```

3. `HAVING`: `GROUP BY`로 집계된 값 중 `WHERE`절 처럼 조건을 추가
    - `Having`절은 `WHERE`절과 비슷하지만 그룹 전체를 나타내는 결과 집합의 행에만 적용
    - `WHERE`절 개별 행에 적용가능

#### 5. JOIN 함수
- 두개 이상의 테이블에서 데이터를 결합하여 새로운 집합을 생성하는 함수
- `JOIN`에도 조건식 적용가능
1. `INNER JOIN` = `EQUI JOIN`: 두개 이상 테이블에서 매치되는 데이터만 추출해 출력
2. `OUTER JOIN`: 두개 이상 테이블에서 모든 데이터를 추출해 출력
    - 조인대상 테이블 중 데이터가 없는 테이블 조인 조건에 **(+)**를 붙힘
    - 외부 조인의 조인 조건이 여러 개일 때 모든 조건에 (+)를 붙힘
    - 한 번에 한 테이블만 외부 조인 가능
3. `EQUI-JOIN`: 등가조인, 조인 조건에 '='를 붙힌 함수 
    - 일치하는 열이 있을 경우만 사용가능
4. `SELF JOIN`: 자기 자신의 테이블과 조인하는 방법

#### 6. 서브쿼리
- SQL 문장 안에서 보조로 사용되는 또 다른 `SELECT`문을 의미
- 최종 결과를 출력하는 것을 메인 쿼리라고 하면, 중간단계, 보조 역할을 하는 것이 서브 쿼리
- 메인 쿼리를 제외하고 나머지는 전부 서브쿼리이며, 여러개 사용이 가능
```oracle
SELECT 열1, 열2, ...
   FROM 테이블명
WHERE 조건 = (SELECT 열 FROM 다른테이블 WHERE 조건);

```

#### 7. 문제풀이
1. EMP 테이블에서 부서 인원이 4명보다 많은 부서의 부서번호, 인원수, 급여 합을 출력
> GROUP BY문, HAVING문
```oracle
-- 모든 행을 세는 COUNT(*)
SELECT DEPTNO, COUNT(*), SUM(SAL)    -- 부서 번호(DEPTNO)별로 사원 수와 해당 부서의 전체 급여 합을 출력
FROM EMP    -- EMP 테이블에서
GROUP BY DEPTNO    -- 부서 번호(DEPTNO)로 그룹화
HAVING COUNT(*) > 4;    -- 사원 수가 4명 이상인 부서만 필터링

```
2. EMP 테이블에서 가장 많은 사원이 속해있는 부서번호와 사원수를 출력
> GROUP BY문, 서브 쿼리
```oracle
SELECT DEPTNO, COUNT(*)    -- 부서 번호(DEPTNO)와 해당 부서의 사원 수를 출력
FROM EMP    -- EMP 테이블에서
GROUP BY DEPTNO    -- 부서 번호(DEPTNO)로 그룹화
HAVING COUNT(DEPTNO) =    -- 각 부서별 사원 수가
       (SELECT MAX(COUNT(*))    -- 모든 부서 중에서 가장 많은 사원 수를
        FROM EMP    -- EMP 테이블에서
        GROUP BY DEPTNO);    -- 부서 번호(DEPTNO)별로 그룹화하여 계산
```
3. EMP 테이블에서 가장 많은 사원을 갖는 MGR의 사원번호를 출력
> GROUP BY문, 서브 쿼리
```oracle
SELECT MGR AS EMPNO    -- 가장 많이 등장하는 사원의 관리자 번호를 출력
FROM EMP
GROUP BY MGR    -- 관리자 번호별로 그룹화
HAVING COUNT(MGR) =    -- 그룹화된 각 관리자 번호의 등장 횟수가
       (SELECT MAX(COUNT(*))    -- 모든 그룹 중에서 등장 횟수가 가장 많은 값을
        FROM EMP    -- EMP 테이블에서
        GROUP BY MGR);    -- 관리자 번호별로 그룹화하여 계산

```
4. EMP 테이블에서 부서번호가 10인 사원수와 부서번호가 30인 사원수를 각각 출력
> DECODE 조건문
```oracle
SELECT COUNT(DECODE(DEPTNO, 10, 1)),    -- 부서번호가 10인 사원 수를 세기 위해 DEPTNO가 10인 경우에 1로 변환 후 COUNT
       COUNT(DECODE(DEPTNO, 30, 1))     -- 부서번호가 30인 사원 수를 세기 위해 DEPTNO가 30인 경우에 1로 변환 후 COUNT
FROM EMP;

```