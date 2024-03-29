package review;

import java.io.DataInputStream;
import java.io.IOException;
import java.net.Socket;
import java.net.UnknownHostException;

public class Client01 {
    public static void main(String[] args) {
        try {
            // 서버에 연결
            Socket socket = new Socket("localhost", 8080);
            System.out.println("[client] 연결 성공");
            // 서버로부터 메세지 수신
            DataInputStream dis = new DataInputStream(socket.getInputStream());
            String receive = dis.readUTF();
            System.out.printf("receive message >> %s\n", receive);

            // 소켓 닫기
            socket.close();
            System.out.println("[client] 연결 종료");
        } catch (UnknownHostException e) {
            // 호스트를 찾을 수 없는 경우 예외처리
            e.printStackTrace();
            // 입출력 예외처리
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
