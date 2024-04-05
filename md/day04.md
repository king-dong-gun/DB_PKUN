# Day04

## DB 오라클 SQL 학습

### NULL 관련 함수
> `NVL("값", "지정값") `: `NULL`인 경우 지정값을 출력하고, `NULL`이 아니면 원래 값을 그대로 출력
> `NVL2("값", "지정값1", "지정값2") // NVL2("값", "NOT NULL", "NULL") `: `NULL`이 아닌 경우 지정값1을  출력하고, `NULL`인 경우 지정값2를 출력

### 조건 변환 함수
> 'DECODE': 조건을 걸어 원하는 원하는 출력 값을 리턴해주는 함수
    - 프로그래밍에서 `ìf else` 같은 역할
> `CASE`: 여러가지 범주를 지닌 조건 각각에 대응하여 값을 리턴해주는 함수
    - 프로그래밍에서 `switch`과 비슷한 역할

### 다중 함수 (집계함수)
1. `SUM`: 합계를 출력
2. `MIN`: 최소값 출력
3. `MAX`: 최대값 출력
4. `COUNT`: 데이터 갯수 집계 -> **`NULL`은 `COUNT`에서 제외된다.**
5. `AVG`: 평균값 출력

### GROUP BY, HAVING절
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
> `WHERE AVG(SAL) >= 2000`에서 `WHERE절은 집계함수와 사용이 불가능해서 컴파일 오류
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

## JOIN 함수
- 두개 이상의 테이블에서 데이터를 결합하여 새로운 집합을 생성하는 함수
- `JOIN`에도 조건식 적용가능
1. `INNER JOIN`: 두개 이상 테이블에서 매치되는 데이터만 추출해 출력
```oracle
SELECT *
FROM 테이블 A
INNER JOIN 테이블 B ON 테이블A.칼럼명 = 테이블B.칼럼명;
```
2. `OUTER JOIN`: 두개 이상 테이블에서 모든 데이터를 추출해 출력

3. `EQUI-JOIN`: 등가조인, 조인 조건에 '='를 붙힌 함수 
    - 일치하는 열이 있을 경우만 사용가능