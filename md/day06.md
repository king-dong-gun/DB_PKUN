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

> empSelectAll() 메소드
```java
package jdbc;

import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class JdbcModel {
    // Statement 객체 사용
    // 1. EMP 테이블 전체 회원정보 조회

    public void empSelectAll() {

        // 객체사용후 close하기위해 지역변수로 선언
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;
        try {
            // 오라클 드라이버를 사용하겠다는 의미
            Class.forName("oracle.jdbc.driver.OracleDriver");
            // 자신의 주소값에 scott 라는 아이디와 tiger 의 비밀번호로 접속함
            conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "adam", "1234");

            stmt = conn.createStatement();
            // EMP 테이블 전체조회하기위한 쿼리문
            String query = "SELECT * FROM EMP";

            //select문이기때문에 executeQuery으로사용
            rs = stmt.executeQuery(query);
            System.out.println("==================DB 연결 성공==================");
            while (rs.next()) {
                int empNo = rs.getInt("EMPNO");
                String empName = rs.getString("ENAME");
                String job = rs.getString("JOB");
                int mgr = rs.getInt("MGR");
                // Date import 대상은 util 패키지가아닌 sql 패키지 해야함
                Date hireDate = rs.getDate("HIREDATE");
                int sal = rs.getInt("SAL");
                int comm = rs.getInt("COMM");
                int deptNo = rs.getInt("DEPTNO");

                // 출력
                System.out.println(empNo + ", " + empName + ", " + job + ", " + mgr + ", " + hireDate + ", " + sal + ", " + comm
                        + ", " + deptNo);
            }
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            // 항상 사용후 무조건 닫아주자!
            try {
                rs.close();
                stmt.close();
                conn.close();
                System.out.println("==================DB 연결 종료==================");
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}

```
> 메인메소드
```java
package jdbc;

public class TestMain {
    public static void main(String[] args) {
        JdbcModel model = new JdbcModel();
        // 회원정보 전체 출력
        model.empSelectAll();
    }
}
```
![DB연결성공](https://github.com/king-dong-gun/PKUN_DB/assets/160683545/360a6d11-9590-4c7c-8392-dccea40c0378)






