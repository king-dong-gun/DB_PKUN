package ch02.sec03.exam02.test01;

public class Phone {
    // 맴버변수 >> 필드, 속성 (모든 메소드에 접근 가능)
    String company;
    String model;
    String color;

    // 생성자 >> 객체생성, 초기화 (디폴트 생성자)

    Phone() {
        this("LG", "V50", "White");
    }
    Phone(String company, String model, String color) {
        this.company = company;
        this.model = model;
        this.color = color;
    }

    // 맴버함수
    void PhonePrint() {
        System.out.printf("나의 핸드폰은 %s의 %s, %s색상 입니다.\n", company, model, color);
    }
    public static void main(String[] args) {
        // Apple 출력
        Phone iPhone = new Phone("Apple", "iPhone", "SpaceGray");
        iPhone.PhonePrint();

        // SamSung 출력
        Phone galuxy = new Phone("SamSung", "Galuxy", "Black");
        galuxy.PhonePrint();

        // LG 출력
        Phone phone = new Phone();
        phone.PhonePrint();
    }
}
