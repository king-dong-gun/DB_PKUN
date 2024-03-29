package ch02.sec03.exam05.test02;

class SmartPhone {
    public static void main(String[] args) {
        iPhone iphone = new iPhone();
        Galaxy galaxy = new Galaxy();
        Lg lg = new Lg();
        System.out.println("저 휴대폰은 " + galaxy.getNamefacture() + "의 " + galaxy.name() + " 입니다.");
        System.out.println("저 휴대폰은 " + iphone.getNamefacture() + "의 " + iphone.name() + " 입니다." +
                " >> " + iphone.getOS() + " " + Phone.version + "버전 업그레이드 완료");
        System.out.println("없어진 모델 >> " + lg.getNamefacture() + "의 "+ lg.getOS() + " " + lg.name() + "가 단종 되었습니다.");
    }
}

public interface Phone {
    public static final double version = 13.8;      // 상수 필드  public static final 생략가능

    String getNamefacture();    // 추상 메소드

    String getOS();             // 추상 메소드

    String name();
}

class iPhone implements Phone {

    @Override
    public String getNamefacture() {
        return "Apple";
    }

    @Override
    public String getOS() {
        return "IOS";
    }

    @Override
    public String name() {
        return "iPhone";
    }
}

class Galaxy implements Phone {

    @Override
    public String getNamefacture() {
        return "SamSung";
    }

    @Override
    public String getOS() {
        return "Android";
    }

    @Override
    public String name() {
        return "Galaxy";
    }
}
class Lg implements Phone {

    @Override
    public String getNamefacture() {
        return "LG";
    }

    @Override
    public String getOS() {
        return "Android";
    }

    @Override
    public String name() {
        return "V50";
    }
}
