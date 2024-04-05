# Day03

## DB 오라클 SQL 학습

### NULL

- 값이 없음, 별도 지정하지 않으면 자동으로 `NULL`
- `NOT NULL` 구문으로 명시해야 `NULL`을 허용하지 않는다.

### 제약조건

1. `NOT NULL` : 반드시 값이 들어 있어야하는 칼럼에는 `NOT NULL` 조건을 사용해서 만든다.
2. `UNIQUE` : 해당 칼럼에 들어가야하는 값이 유일해야 한다는 의미 즉, 중복값을 허용하지 않는다.

### 집합 연산자

1. `UNION` : 합집합, 공통 칼럼 값 출력
2. `MINUS` : 차집합, 첫번째 칼럼에서 두번째 칼럼을 뺀 값 출력
3. `INTERSECT` : 교집합, 양쪽 칼럼 모두 포함된 값 출력

### 문자열 함수

- `SUBSTR` : SUBSTR(칼럼, 문자열 시작점, 출력 갯수)

```oracle
SELECT JOB, SUBSTR(JOB, 1, 2), SUBSTR(JOB, 3, 2), SUBSTR(JOB, 5)
FROM EMP e;
```

> 출력결과: JOB: SALEMAN, substr(JOB,1, 2) >> SA, substr(JOB, 3, 2) >> LE, substr(JOB, 5) >> MAN

- `INSTR` : INSTR('문자열', 시작점, 문자열n번째)

```oracle
SELECT INSTR('HELLO, ORACLE!', 'L')       AS instr1, -- 전체 문자열에서 L 찾기
       INSTR('HELLO, ORACLE!', 'L', 5)    AS instr2, -- 5번째 문자부터 L 찾기
       INSTR('HELLO, ORACLE!', 'L', 2, 2) AS instr3  -- 2번째 문자부터 2번째로 있는 L 찾기
FROM dual;
```



- `REPLACE`:  문자열 내에서 특정 문자 또는 패턴을 다른 문자 또는 패턴으로 대체하는 데 사용

```oracle
SELECT '010-1234-5678'
           AS replace1,
       REPLACE('010-1234-5678', '-', ' ')
FROM dual;
```

> 출력결과 : 010 1234 5678

- `LPAD`, `RPAD`: 지정된 길이에 도달할 때까지 지정된 문자로 문자열을 채우는 데 사용
    - LPAD('문자열', 문자열 총 갯수, '채울 문자') AS 칼럼
    - RPAD('문자열', 문자열 총 갯수, '채울 문자') AS 칼럼

### 숫자 함수

> `ROUND`: 반올림, 반내림 함수

- SELECT ROUND(반올림 할 수, 소수점 자리 선택)

- `TRUNC`: 버림 함수
    - SELECT TRUNC(숫자, 버릴 소수점 자리 선택)

- `TRIM`: 양쪽의 공백을 제거하는 기본적인 함수
  - `LTRIM`: 왼쪽 공백이나 반복되는 문자열 제거
  - `RTRIM`: 오른쪽 공백이나 반복되는 문자열 제거

### 날짜 함수

- `SYSDATE`: 현재 시간을 계산
    - `ADD_MONTHS`(기준 날짜, 계산할 날짜)
    - `MONTHS_BETWEEN`(기준 날짜, 계산할 날짜)
    - 날짜도 반올림, 반내림 가능!! -> MAC OS에서는 도커를 사용해서 시간이 보이지 않음
- `NLS_DATE_LANGUAGE = 언어`: 언어 번경
#### 날짜 함수 종류
1. CC: 세기
2. YYYY: 년도
3. YY: 년도(2)
4. MM: 월
5. MON: 월(약어)
6. MONTH: 월(전체)
7. DD: 일
8. DDD: 일(365일)
9. DY: 요일(약어)
10. DAY: 요일(풀어)
11. W: 주
12. HH24: 24시간
13. HH/HH12: 12시간
14. M1: 분
15. SS:초
16. AM/PM, A.M/P.M: 오전, 오후 

### 암묵적 형변환
#### 컴파일이 자동으로 변환

### 명시적 형변환
#### 사용자가 강제적으로 변환
1. `TO_CHAR`: 숫자 또는 날짜 데이터를 문자 데이터로 변환
2. `TO_NUMBER`: 문자 또는 날짜 데이터를 숫자 데이터로 변환
3. `TO_DATE`: 문자 또는 숫자 데이터를 날짜 데이터로 변환