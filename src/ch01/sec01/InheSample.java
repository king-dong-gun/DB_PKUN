package review;

public class InheSample {
    public static void main(String[] args) {
        // Dog 객체 생성
        Dog dog = new Dog("최재영");
        dog.sleep();

        // dogHouse 객체 생성
        DogHouse doghouse = new DogHouse("재영");
        doghouse.sleep();
        doghouse.sleep(12);

        Dog dog1 = new Dog("호날두");  // 업케스팅
        DogHouse dogHouse = new DogHouse("메시"); // 업케스팅


        doghouse.numPrint(); // numPrint() 메소드 호출
    }
}

class Animal {
    String name;    // 맴버 변수 == 인스턴스 변수
    int num = 10;

    void setName(String name) { // 맴버 함수
        this.name = name;
    }
}

class Dog extends Animal { // Animal 클래스 상속
    int num = 20;

    Dog(String name) {  // 생성자
        this.setName(name);
        System.out.println("Animal 생성자");
    }

    void sleep() {
        System.out.println(this.name + " 잘자노 ㅋㅋ");
    }
}

class DogHouse extends Animal { // Animal 클래스 상속
    int num = 30;

    DogHouse(String name) {    // 생성자
        this.setName(name);
        System.out.println("DogHouse 생성자");
    }

    void sleep() {  // 메소드 재정의
        System.out.println(this.name + " 쿨쿨 잘자노 ㅋㅋ");
    }

    void sleep(int hour) { // 오버로딩된 메소드
        System.out.println(this.name + " 쿨쿨 zzz~ " + hour + "시에 잘자노 ㅋㅋ");
    }

    void numPrint() { // num 변수 출력 메소드
        System.out.printf("Animal >> %d Dog >> %d House >> %d\n", super.num, this.num, num);
    }
}

