package ch02.sec03.exam05.test01;

public interface RemoteControl {
    String turnOn = "전원을 켭니다.";
    String turnOff = "전원을 끕니다.";


    public class Phone {
        public static void main(String[] args) {
            System.out.println("전원 상태 >> " + RemoteControl.turnOn);
            System.out.println("전원 상태 >> " + RemoteControl.turnOff);
        }
    }
}
