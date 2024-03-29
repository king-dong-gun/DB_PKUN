package ch02.sec03.exam02.test02;

public class Person {
    public static void main(String[] args) {
        // speak 클래스의 인스턴스를 생성하여 nationality 타입으로 참조
        // 생성자가 호출되면서 "speak(String people, String language) { >> 생성자!!"가 출력
        Nationality nationality = new speak("한국인", "한글");

        // speak 클래스의 인스턴스를 생성하여 nationality2 타입으로 참조
        // 생성자가 호출되면서 "speak(String people, String language) { >> 생성자!!"가 출력
        Nationality nationality2 = new speak("미국인", "영어");

        // speak 클래스의 인스턴스를 생성하여 nationality3 타입으로 참조
        // 생성자가 호출되면서 "speak(String people, String language) { >> 생성자!!"가 출력
        Nationality nationality3 = new speak("일본인", "일본어");

        // printInfo 메서드를 사용하여 국적과 언어를 출력
        printInfo(nationality);
        printInfo(nationality2);
        printInfo(nationality3);
    }

    // Nationality 타입의 객체를 받아서 국적과 언어를 출력하는 메서드
    public static void printInfo(Nationality nationality){
        System.out.print("국적 >> " + nationality.people + ", ");
        System.out.println("언어 >> " + nationality.language);
    }
}

// 국적과 언어를 나타내는 클래스
class Nationality {
    public String people; // 국적을 나타내는 변수
    public String language; // 언어를 나타내는 변수

    // 국적과 언어를 매개변수로 받는 생성자
    // 인스턴스가 생성될 때 호출되며, "nationality(String people, String language) { >> 생성자!!"가 출력
    public Nationality(String people, String language) {
        this.people = people;
        this.language = language;
        System.out.println("nationality(String people, String language) { >> 생성자!!");
    }
}

// Nationality 클래스를 상속받는 speak 클래스
class speak extends Nationality {
    // 국적과 언어를 매개변수로 받는 생성자
    // 인스턴스가 생성될 때 호출되며, "speak(String people, String language) { >> 생성자!!"가 출력
    public speak(String people, String language) {
        super(people, language);
        System.out.println("speak(String people, String language) { >> 생성자!!");
    }
}
