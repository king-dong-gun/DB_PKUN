# Day01
## DB 오라클 SQL 학습
### 시작전 오라클 설치 (for Mac Os)
1. Docker를 통해 Oracle Database 21c 설치하기
> Oracle은 MacOS를 정식 지원하지 않으므로 Mac에서 Oracle Database를 설치하기 위해서는 별도의 절차가 필요하다.
2. Colima 설치
> Colima는 무거운 Docker Desktop을 대신해 간단한 CLI 환경에서 도커 컨테이너들을 실행할 수 있는 오픈 소스 소프트웨어이다.
3. brew 를 활용!! brew가 없다면 [Mac 에 brew 설치하기](https://brew.sh/ko/)를 참고해서 먼저 설치,. brew가 설치되었다면, 터미널에 다음과 같이 명령을 입력한다.
```java
brew install colima
```
4. Docker 설치
5. > Docker DeskTop을 직접 설치한게 아니라면 터미널에 다음과 같이 명령을 입력한다.
```java
brew install docker
```
6. Colima 실행
> Colima와 Docker를 모두 설치했다면, colima를 x86_64 환경으로 띄워 준다. 터미널에 다음과 같이 입력한다.
> start 과정에서 다소 시간이 소요됨, 잠시 기다린 후 done 명령이 뜨면 완료
```java
colima start --memory 4 --arch x86_64
```
5. docker 컨테이너 실행하기
> 가상 환경이 준비되었으니, `docker run` 명령을 통해 docker 컨테이너를 실행하고 이 환경에 오라클 서버를 띄운다.
```java
docker run \
 --restart unless-stopped \
 --name oracle2 \
 -e ORACLE_PASSWORD=pass \
 -p 1521:1521 \
 -d \
 gvenzl/oracle-xe
```
6. 명령에 성공하면 해쉬 문자열을 반환하며 다음 명령을 입력 후 확인.
```java
docker ps
```
```java
docker logs -f (컨테이너명)
```
> `docker logs`로 로그를 확인했을 때 조금 기다린 뒤 “DATABASE IS READY TO USE!”가 뜨면 성공!!!

### 실행순서
1. `colima start --memory 4 --arch x86_64`
2. `docker ps` -> 컨테이너 띄어져 있는지 확인
3. `docker start oracle2` -> 컨테이너 띄우기
4. `docker ps` -> oracle2 가 띄어져있는지 확인

### 종료순서
1. `docker ps` -> 컨테이너 띄어져있는거 확인
2. `docker stop oracle2` -> 컨테이너 종료
3. `docker ps` -> 종료됐는지 확인
4. `colima stop` -> colima 종료

### SQL Plus
- `docker exec -it oracle2 sqlplus`
    - sql plus 나가는법 : `quit;`

### 데이터 베이스 언어
#### DDL(Data Definition Language)
> 데이터 정의어란? 데이터베이스를 정의하는 언어
> 데이터를 생성, 수정, 삭제하는 등의 데이터의 전체의 골격을 결정하는 역할을 하는 언어
- `create` : 데이터베이스, 테이블등을 생성
- `alter` : 테이블을 수정
- `drop` : 데이터베이스, 테이블을 삭제
- `truncate` : 테이블을 초기화

#### DML(Data Manipulation Language)
> 데이터 조작어란? 정의된 데이터베이스에 입력된 레코드를 조회하거나 수정하거나 삭제하는 등의 역할을 하는 언어
- `select` : 데이터 조회
- `insert` : 데이터 삽입
- `update` : 데이터 수정
- `delete` : 데이터 삭제

#### DCL(Data Control Language)
> 데이터베이스에 접근하거나 객체에 권한을 주는등의 역할을 하는 언어
- `grant` : 특정 데이터베이스 사용자에게 특정 작업에 대한 수행 권한을 부여
- `revoke` : 특정 데이터베이스 사용자에게 특정 작업에 대한 수행 권한을 박탈, 회수
- `commit` : 트랜잭션의 작업을 저장
- `rollback` : 트랜잭션의 작업을 취소, 원래대로 복구