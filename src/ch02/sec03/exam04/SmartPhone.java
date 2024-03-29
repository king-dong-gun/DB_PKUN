package ch02.sec03.exam04;

class Phone {
    public String model;
    public String color;

    public Phone(String model, String color) {
        this.model = model;
        this.color = color;
        System.out.println("Phone(String model, String color) { >> 생성자 실행");
    }
}

public class SmartPhone extends Phone {
    public SmartPhone(String model, String color) {
        super(model, color);
        System.out.println("SmartPhone(String model, String color) { >> 생성자 실행");
    }


    public static void main(String[] args) {
        SmartPhone smartPhone = new SmartPhone("갤럭시", "은색");

        System.out.println("모델 > " + smartPhone.model);
        System.out.println("색상 > " + smartPhone.color);
    }
}


