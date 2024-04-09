# Day06

## DB 오라클 SQL 학습
### 목차
1. 문제풀이
2. DB 연동하기



#### 1. 문제풀이
```oracle
   -- 1. EMP 테이블에서 입사일 순으로 사원번호, 이름, 업무, 급여, 입사일자, 부서번호 조회
   SELECT EMPNO    AS 사원번호,
   ENAME    AS 사원명,
   JOB      AS 업무,
   SAL      AS 급여,
   DEPTNO   AS 부서번호,
   HIREDATE AS 입사일
   FROM EMP
   ORDER BY HIREDATE;
```
```oracle
-- 2. EMP 테이블에서 부서번호로 정렬한 후 급여가 많은 순으로 사원번호, 이름, 업무, 급여, 부서번호 조회
SELECT EMPNO  AS 사원번호,
ENAME  AS 사원명,
JOB    AS 업무,
SAL    AS 급여,
DEPTNO AS 부서번호
FROM EMP
ORDER BY DEPTNO, SAL DESC;
```
```oracle
-- 3. EMP 테이블에서 모든 SALESMAN의 급여 평균, 최고액, 최저액, 합계를 조회
SELECT AVG(DECODE(JOB, 'SALESMAN', SAL)) AS 급여평균,
MAX(DECODE(JOB, 'SALESMAN', SAL)) AS 최고액,
MIN(DECODE(JOB, 'SALESMAN', SAL)) AS 최저액
FROM EMP;
```
```oracle
-- 4. EMP 테이블에서 각 부서별로 인원수, 급여평균, 최저급여, 최고급여의 합을 구하여 급여의 합이 많은 순을 조회
SELECT DEPTNO          AS 부서번호,
COUNT(DEPTNO)   AS 부서인원수,
SUM(SAL)        AS 급여합,
ROUND(AVG(SAL)) AS 평균급여,
MAX(SAL)        AS 최고액,
MIN(SAL)        AS 최저액
FROM EMP
GROUP BY DEPTNO
ORDER BY SUM(SAL) DESC;
```
#### 2. DB 연동하기
##### 인텔리제이에 JDBC 드라이버 설치
> [Java에서 DB 연결하기 위해 Java와 DataBase를 연결해주는 JDBC 드라이버 설치](https://www.oracle.com/kr/database/technologies/appdev/jdbc.html)
1. Oracle JDBC 드라이버 다운로드
    - 버전별로 지원하는 **oracle**, **JDK** 버전이 다르므로 확인하고 설치
2. 파일 Import
    - **File >> Project Sturcture**
    ![DB연결하기.png](..%2Fimage%2FDB%EC%97%B0%EA%B2%B0%ED%95%98%EA%B8%B0.png)
   - **Libaries >> + >> 다운받은 JDBC드라이버 파일 추가**

##### Oracle 데이터베이스 연결
> EMP 테이블을 조회하는 예제 코드
```java
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class JdbcExample {

    public static void main(String[] args) {
        // JDBC 연결 정보
        String url = "jdbc:oracle:thin:@localhost:1521:xe"; // 데이터베이스 URL
        String user = "사용자명"; // 데이터베이스 사용자 이름
        String password = "비밀번호"; // 데이터베이스 비밀번호

        // JDBC 드라이버 로드
        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
        } catch (ClassNotFoundException e) {
            System.out.println("JDBC 드라이버를 찾을 수 없습니다.");
            e.printStackTrace();
            return;
        }

        // 데이터베이스 연결
        try (Connection connection = DriverManager.getConnection(url, user, password)) {
            System.out.println("데이터베이스에 연결되었습니다.");

            // SQL 쿼리 실행
            String sql = "SELECT * FROM EMP";
            try (Statement statement = connection.createStatement();
                 ResultSet resultSet = statement.executeQuery(sql)) {
                // 쿼리 결과 처리
                while (resultSet.next()) {
                    int empNo = resultSet.getInt("EMPNO");
                    String empName = resultSet.getString("ENAME");
                    String job = resultSet.getString("JOB");
                    int mgr = resultSet.getInt("MGR");
                    java.sql.Date hireDate = resultSet.getDate("HIREDATE");
                    int sal = resultSet.getInt("SAL");
                    int comm = resultSet.getInt("COMM");
                    int deptNo = resultSet.getInt("DEPTNO");
                    
                    System.out.println("사원번호: " + empNo +
                                       ", 사원명: " + empName +
                                       ", 직무: " + job +
                                       ", 상사번호: " + mgr +
                                       ", 입사일: " + hireDate +
                                       ", 급여: " + sal +
                                       ", 커미션: " + comm +
                                       ", 부서번호: " + deptNo);
                }
            } catch (SQLException e) {
                System.out.println("SQL 쿼리를 실행하는 중 오류가 발생했습니다.");
                e.printStackTrace();
            }
        } catch (SQLException e) {
            System.out.println("데이터베이스에 연결하는 중 오류가 발생했습니다.");
            e.printStackTrace();
        }
    }
}

```






