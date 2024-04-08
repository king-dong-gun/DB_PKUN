# Day05

## DB 오라클 SQL 학습
### 목차
1. 데이터 수정
2. 트랜잭션
3. 뷰
4. 데이터 사전
5. DDL
6. 제약조건
7. 문제풀이

#### 1. 데이터 수정
1. `UPDATE`문
- 테이블의 데이터를 수정할 때 사용한다.
```oracle
UPDATE 테이블명
SET 열1 = 값1,
    열2 = 값2, ...
    WHERE 조건;
```
2. `DELETE`문
- 테이블의 DATA를 삭제할 때 사용한다.
```oracle
DELETE 테이블명
WHERE 조건;
```

3. `DROP`문
- 테이블을 삭제할 때 사용한다.
```oracle
DROP TABLE 테이블명;
```

#### `TRANSACTION`
1. `COMMIT`



   ![트랜젹선 커밋](https://github.com/king-dong-gun/PKUN_DB/assets/160683545/5a1067e6-af63-4ce5-80dd-13f9847150ab)



- 모든 작업을 정상적으로 처리하겠다고 확정하는 명령어.
- 변경된 내용을 모두 영구저장한다.
- `COMMIT`을 수행하면 하나의 트렌잭션 과정을 종료하게 된다.
- `TRANSACTION` (`INSERT`, `UPDATE`, `DELETE`) 작업내용을 실제 DB에 저장한다.

2. `ROLLBACK`:


![트랜잭션 롤백](https://github.com/king-dong-gun/PKUN_DB/assets/160683545/abf28d3f-7d91-4051-9753-b47f7541c39d)




- 트랜잭션으로 인한 하나의 묶음 처리가 시작되기 이전의 상태로 되돌린다.
- 작업 중 문제가 발생했을 때, 트랜잭션의 처리 과정에서 발생한 변경사항을 취소하고, 트랜잭션 과정을 종료한다.
- 이전 `COMMT`한 곳까지 되돌린다.
- `TRANSACTION` (`INSERT`, `UPDATE`, `DELETE`) 작업내용을 취소한다.

#### 2. `VIEW`
1. `VIEW`를 사용하는 이유
- DB에 존재하는 하나의 가상 테이블이다. 
- 실제 데이터를 가지고 있지 않지만, 실제 테이블처럼 행, 열을 가진다.
- 직접 테이블에 접근하는 것이 아니라, 사용자가 필요로 하는 부분만 가져와 사용할 수 있는 데이터 집합이다.

2. 장점
- 원하는 부분만 가져와서 사용할 수 있다.
- 복잡한 쿼리를 단순화해서 사용 가능하다.
- 데이터 보안이 용이하다.

3. 단점
- 인덱스를 구성할 수 없다.
- 한번 정의된 `VIEW`는 수정할 수 없다.

```oracle
CREATE VIEW 뷰이름 AS
SELECT 열1, 열2, ...
FROM 테이블1
JOIN 테이블2 ON 조인조건
WHERE 조건;
```
> `VIEW`는 원본 데이터와 같은 테이블명을 가질 수 없다.
> `VIEW`를 삭제해도 원천데이터는 삭제되지 않는다.

#### 3. 데이터 사전
##### 종류
1. `DBA`: DB에 포함하는 모든 객체에 대한 자세한 정보 
2. `ALL_`: 자신이 생성한 객체와 다른 사용자가 만든 객체중에 자신이 볼 수 있는 정보
3. `USER_`: 현재 접속자가 생성한 모든 객체의 정보 

#### 4. 시퀀스
> 데이터베이스에서 일련번호를 자동으로 생성하기 위해서 사용되는 객체. 주로 고유한 식별자(primary key)값이 필요한 칼럼에 사용된다.

```oracle
CREATE SEQUENCE sequence_name           -- 시퀀스 이름저장
    START WITH start_value              -- 시퀀스의 시작값 설정
    INCREMENT BY increment_value        -- 시퀀스의 증가값 설정
    MINVALUE min_value                  -- 시퀀스의 최대값 설정
    MAXVALUE max_value                  -- 시퀀스의 최소값 설정
    CYCLE | NOCYCLE;                    -- CYCLE로 설정하면 다시 시작값부터 반복
                                        -- NOCYCLE로 설정하면 최대값에서 멈춤
```

##### 시퀀스 사용
- 시퀀스를 사용하여 컬럼에 일련번호를 자동으로 생성하려면 `NEXTVAL` 또는 `CURRVAL`함수를 사용한다.
- `NEXTVAL`: 시퀀스의 다음 값을 반환한다.
- `CURRVAL`: 시퀀스의 현재 값을 반환한다.
> 시퀀스를 생성하고 사용함으로써 일련번호를 자동으로 생성할 수 있다.
> 고유한 식별자 값의 충돌을 방지하고, 데이터의 일관성과 정확성을 유지할 수 있다.

#### 5. DDL(Data Definition Language)
- `CREATE`: 객체를 생성하는 명령어.
- `ALTER`: 객체의 구조를 변경하는 명령어. 객체에 따라 세부적인 명령어나 문법이 상이.
- `RENAME`: 객체의 이름을 변경하는 명령어.
- `TRUNCATE`: 테이블의 데이터를 제거하는 데 사용하는 명령어. DELETE와 다르게 DDL이기 때문에 ROLLBACK이 되지 않으므로 사용에 주의.
- `DROP`: 객체를 제거할 때 사용하는 명령어화

#### 6. 제약조건
> 컬럼에 어떠한 조건을 거는 것, 해당 컬럼에 조건을 걸면 해당 칼럼 또는 테이블 이용시 제약조건을 잘 지켜야한다. 
1. `NOT NULL`: `NULL`을 허용하지 않는다. 즉, 필수적으로 입력되야 하는 칼럼에 설정한다.
```oracle
CREATE TABLE 테이블명(
    칼럼명 데이터형식 NOT NULL
);
```
2. `UNIQUE`: 중복된 값을 허용하지 않는다. 즉, 유일한 데이터를 가진다.(`NULL`은 허용)
```oracle
   CREATE TABLE 테이블명(
   칼럼명 데이터형식 UNIQUE 
   );
```

3. `CHECK`: 입력할 수 있는 값의 범위를 설정해 주는 제약조건이다.
   - 입력값이 조건과 맞지 않으면 오류가 발생한다.
   - 입력값의 범위를 지정할 수 있다.
```oracle
CONSTRAINT 제약조건 CHECK(칼럼명 IN(지정값));
```
4. PRIMARY KEY(기본키)
  - 테이블 당 하나만 가질수 있는 키로 데이터 중복이 불가하다.
  - **NULL**, **빈문자열**이 올수 없다.
```oracle
CREATE TABLE 테이블명(
     컬럼명 데이터형식 PRIMARY KEY
);
```
5. FOREIGN KEY(외래키)
   - 외부의 테이블을 참조 시키고 싶을 때 해당 키를 컬럼에 지정해서 외부 테이블의 컬럼과 연동 가능하다.
   - 부모 테이블(참조해야 하는 테이블)의 컬럼은 `PRIMARY KEY` 또는 `UNIQUE`로 지정되어야 한다.
   - 부모 테이블에 없는 값은 자식 테이블에 추가할 수 없다. 부모 테이블에 있는 값만 자식 테이블이 가질 수 있다.
```oracle

CREATE TABLE 테이블명(
     컬럼명 데이터형식,
     CONSTRAINT 외래키명 FOREIGN KEY (적용 컬럼명)
     REFERENCES 참조테이블명 (참조테이블 내 참조할 컬럼명)
     ON DELETE CASCADE(선택 사항)
);
```

#### 7. 문제풀이
1. EMP 테이블에서 사원번호가 7521인 사원의 직업과 같고, 사원번호 7934인 사원의 급여보다 많은 사원의
   사번, 이름, 직업, 급여 출력 
```oracle
SELECT EMPNO AS 부서번호,
       ENAME AS 이름,
       JOB   AS 업무,
       SAL   AS 급여
FROM EMP
WHERE JOB = (SELECT JOB FROM EMP WHERE EMPNO = 7521) -- EMPNO가 7521인 사원과 직업이 찾은 사람 찾기
  AND SAL > (SELECT SAL FROM EMP WHERE EMPNO = 7934); -- EMPNO가 7934인 사원보다 급여가 많은 사람 찾기
```
2. 직업별로 최소 급여를 받는 사원의 정보를 사원번호, 이름, 업무, 부서명으로 출력
```oracle
-- 복수형 쿼리
SELECT EMP.EMPNO AS 부서번호,    -- 사원의 사원번호를 부서번호로 출력
EMP.ENAME AS 이름,        -- 사원의 이름 출력
EMP.JOB   AS 업무,        -- 사원의 업무 출력
DEPT.LOC  AS 부서명       -- 부서의 위치를 부서명으로 출력
FROM EMP
INNER JOIN DEPT ON EMP.DEPTNO = DEPT.DEPTNO    -- EMP 테이블과 DEPT 테이블을 부서번호를 기준으로 조인
WHERE (EMP.JOB, EMP.SAL) IN (SELECT JOB, MIN(SAL) FROM EMP GROUP BY JOB)    -- 사원의 업무별 최소 급여를 가지는 사원을 필터링
ORDER BY EMP.JOB;    -- 업무별로 정렬
```
3. 각 사원별 커미션이 0 또는 NULL이고 부서 위치가 'GO'로 끝나는 사원의 정보를 사원번호, 사원이름, 커미션, 부서번호,
   부서명, 부서위치를 출력 (보너스가 NULL이면 0으로 출력) 
```oracle
SELECT EMPNO        AS 사원번호,
       ENAME        AS 사원이름,
       EMP.DEPTNO   AS 부서번호,
       MGR          AS 부서위치,
       LOC          AS 부서명,
       DECODE(COMM,
              NULL, 0,
              COMM) AS 커미션 -- COMM이 NULL이면 0으로 출력 아니라면 COMM 그대로 출력
FROM EMP
         INNER JOIN DEPT ON EMP.DEPTNO = DEPT.DEPTNO -- EMP 테이블과 DEPT 테이블을 부서번호를 기준으로 조인
WHERE DEPT.LOC LIKE '%GO';  -- LOC이 GO로 끝나는 문자열 찾기
```



