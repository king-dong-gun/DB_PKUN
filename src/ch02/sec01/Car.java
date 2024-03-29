package ch02;

public abstract class Car {
    // 추상 메소드
    public abstract void drive();
    public abstract void stop();

    public void turnOn() {
        System.out.println("시동을 켭니다.");
    }
    public void turnOff() {
        System.out.println("시동을 끕니다.");
    }
    public void run() {
        turnOn();
        drive();
        stop();
        turnOff();
    }
}

class ManualCar extends Car {
    @Override
    public void drive() {
        System.out.println("<운전 시작>");
    }

    @Override
    public void stop() {
        System.out.println("<운전 중지>");
    }
}
class AiCar extends Car {

    @Override
    public void drive() {
        System.out.println("<자율주행 시작>");
    }

    @Override
    public void stop() {
        System.out.println("<자율주행 정지>");
    }
}
