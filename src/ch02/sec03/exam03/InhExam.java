package ch02.sec03.exam03;

class Base {
    int num01;

    public Base(int num01) {
        this.num01 = num01;
    }
}

class Drive extends Base {
    int num02;

    // 생성자 정의
    Drive(int num01, int num02) {
        super(num01);
        this.num02 = num02;
    }

    void printField() {
        System.out.printf("num01: %d, num02: %d \n", super.num01, num02); // printf 사용
    }
}

public class InhExam {
    public static void main(String[] args) {
        Drive drive = new Drive(10, 20);
        drive.printField(); // 수정: printField 메서드 호출
    }
}
