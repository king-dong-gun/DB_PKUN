package review;

import java.io.DataOutputStream;
import java.io.IOException;
import java.net.ServerSocket;
import java.net.Socket;
import java.util.Scanner;

public class Server01 {
    public static void main(String[] args) {    // 메인 메소드 시작
        // 서버 시작 메세지 출력
        System.out.println("--------------------------------------------");
        System.out.println("서버를 종료하시려면 Q(q) 또는 Enter 키를 입력하세요");
        System.out.println("--------------------------------------------");

        startServer();  // 서버 시작

        // 사용자 입력 처리
        Scanner sc = new Scanner(System.in);    // sc >> 참조변수, 객체의 주소를 저장
        String inPut;

        while (true) {
            // toLowerCase() >> 문자열을 소문자로 변환한 새로운 문자열을 반환
            inPut = sc.nextLine();
            System.out.println("입력받은 단어 >> " + inPut);

            if (inPut.toLowerCase().equals("q")) {
                break;
            }
        }
        System.out.println("프로그램을 종료합니다.");
        sc.close();

        stopServer();
    }

    static ServerSocket serverSocket = null;    // 프로그램 인터페이스 (클라이언트 요청수락, 통신)

    // 서버 시작 메소드
    static void startServer() {         // 정적 맴버 (클래스 맴버)로 만든다
        Thread thread = new Thread() {  // 익명객체 (1.익명자식객체-상속, 2.익명구현객체-인터페이스)
            @Override
            public void run() { // 스레드가 실행할 작업을 정의
                try {
                    serverSocket = new ServerSocket(8080);  // 8080 포트번호를 사용하는 서버소켓 생성
                    System.out.println("ServerSocket 생성");

                    // 클라이언트 요청 수락
                    Socket clientSocket = serverSocket.accept();
                    System.out.println("ClientSocket 생성");

                    // 클라이언트에 메세지 전송
                    DataOutputStream dos = new DataOutputStream(clientSocket.getOutputStream());
                    dos.writeUTF("First my Server!!!");
                    dos.flush();

                    // 클라이언트 소켓 닫기
                    clientSocket.close();
                    System.out.println("ClientSocket 종료");
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        };
        thread.start(); // 스레드 시작
    }

    // 서버 종료 메소드
    static void stopServer() {
        try {
            // 서버 소켓 닫기
            serverSocket.close();
            System.out.println("ServerSocket 종료");
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}

