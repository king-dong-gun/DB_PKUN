# DB 오라클 SQL 학습
## Day01
### 시작전 오라클 설치
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
