# Day02
## DB 오라클 SQL 학습
### 명령어 학습
- `create table 테이블명` : 테이블 생성
```java
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
```

- `SELECT * FROM` : 테이블 생성 확인
```java
SELECT * FROM emp;
```
- `INSERT INTO TABLE VALUES(칼럼 값 1, 2, 3)` : 테이블 값 집어넣기
```java
INSERT INTO emp VALUES (7369, 'SMITH', 'CLERK', 7902, to_date('17_12_1980', 'dd-mm-yyyy'), 800, NULL, 20);
```

- `COMMIT` : 변경사항 저장

- `SELECT 칼럼1, 칼럼2 From 테이블` : 필요 행만 가져오기
```java
SELECT empno, ename, sal FROM emp;
```
- `SELECT 칼럼1 "변경내용" FROM emp;` : 칼럼1의 내용을 변경
```java
SELECT empno "사원번호", ename"이름",sal"월급", sal*12"연봉" FROM emp;
```

- `SELECT DISTINCT 칼럼명 FROM 테이블` : 중복데이터 제거
```java
SELECT DISTINCT job FROM emp e;
```
- `SELECT 칼럼1||칼럼2 FROM dual` : 칼럼1과 칼럼2 붙여쓰기
```java
SELECT 1||5 FROM dual;
```

- `SELECT 칼럼1 + '칼럼2' FROM dual` : 칼럼1과 칼럼2 더하기
```java
SELECT 1 + '5' FROM dual;
```

- `SELECT * FROM 테이블 ORDER BY 칼럼명` : 테이블의 칼럼명 오름차순 정리
- `SELECT * FROM 테이블 ORDER BY 칼럼명 DESC` : 테이블의 칼럼명 내림차순 정리

- `where` : 조건을 부여
```java
SELECT * FROM emp e WHERE EMPNO = 7839;
```
> EMPNO가 8739인 사람 출력

> 비교연산자
- `=` : 같은값 출력
- `!=`, `^=`, `<>`, `not 컬럼` : ~이 아닌값 출력
- `between 칼럼1 and 칼럼2` : 칼럼1, 칼럼2 사이의 값 출력
- **문자에도 사용가능**

> 조건부
- `where 칼럼 ìn (데이터1, 데이터2)` : 칼럼의 데이터값들을 출력

> 논리연산자
- `and` : 두 조건이 모두 참일 때 전체 조건이 참, 모든 조건이 만족되야 출력
- `or` : 두 조건 중 하나라도 참이면 전체 조건이 참, 하나 이상의 조건이 만족이면 출력
- `not` : 조건을 부정, 주어진 조건이 거짓이면 참이 되고, 주어진 조건이 참이면 거짓 출력

> 문자열 연산자
- `like` : 문자열 패턴을 비교
    - % (퍼센트 기호): 이것은 0개 이상의 문자열을 출력
    - _ (언더스코어): 이것은 정확히 하나의 문자를 출력
- `||`, `CONCAT` : 문자열 결합




