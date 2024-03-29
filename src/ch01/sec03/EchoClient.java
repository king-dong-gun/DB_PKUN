package review;

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.InputStreamReader;
import java.net.Socket;

public class EchoClient {
    public static void main(String[] args) {
        try {
            // Socket 생성과 동시에 localhost의 8082 포트로 연결 요청;
            Socket socket = new Socket("192.168.0.15", 8082);
            System.out.println("[클라이언트] 연결 성공");

            /*---------------------------------------------------------------------
            // 데이터 보내기
            String snedMessage = "나는 자바가 좋아!";
            OutputStream os = socket.getOutputStream();
            byte[] bytes = sendMessage.getBytes("UTF-8");
            os.write(bytes);
            os.flush();
            System.out.println("[클라이언트] 데이터 보냄: " + sendMessage);

            // 데이터 받기
            InputStream is = socket.getInputStream();
            bytes = new byte[1024];
            int readByteCount = is.read(bytes);
            String receiveMessage = new String(bytes, 0, readByte(Count, "UTF-8");
            System.out.println("[클라이언트] 데이터 받음: " + receiveMessage);
             ---------------------------------------------------------------------*/

            // 데이터 보내기
            DataOutputStream dos = new DataOutputStream(socket.getOutputStream());

            // 사용자 입력을 받기 위한 BufferedReader 생성
            BufferedReader userInput = new BufferedReader(new InputStreamReader(System.in));

            String sendMessage;
            // 사용자가 "q"를 입력할 때까지 반복해서 메시지를 보냄
            while (true) {
                System.out.print("메시지를 입력하세요 ('q' 입력시 종료): ");
                sendMessage = userInput.readLine(); // 사용자 입력 받기

                // 입력된 메시지를 서버로 전송
                dos.writeUTF(sendMessage);
                dos.flush();
                System.out.println("[클라이언트] 데이터 보냄: " + sendMessage);

                // 사용자가 "q"를 입력하면 루프를 종료하고 클라이언트를 종료함
                if (sendMessage.equalsIgnoreCase("q")) {
                    System.out.println("사용자가 종료 요청을 보냈습니다.");
                    break;
                }
            }

            // 소켓 및 스트림 닫기
            dos.close();
            userInput.close();
            socket.close();
            System.out.println("[클라이언트] 연결 종료");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
