package ch02.sec03.exam01;

public class Polymorphism {
    public static void main(String[] args) {
        Custom custom = new Custom();
        Espresso espresso = new Espresso();
        Americano americano = new Americano();
        IceTeaShotPlus iceteaShotPlus = new IceTeaShotPlus();
        custom.buyCoffee(americano);
        custom.buyCoffee(espresso);
        custom.buyCoffee(iceteaShotPlus);
        System.out.println("커피 구입 후 남은 잔액 >>  " + custom.money);
    }
}

class Custom {
    int money = 300000;

    void buyCoffee(Coffee coffee) {
        if (money < coffee.price) {
            System.out.println("<잔액 부족>");
            return;
        }
        money -= coffee.price;
        System.out.printf("%s를 %d원에 구매하셨습니다. \n", coffee.getClass().getSimpleName(), coffee.price);
    }
}

// 맴버변수
class Coffee {
    int price;
}

class Espresso extends Coffee {
    public Espresso() {
        price = 2500;
    }
}

class Americano extends Coffee {
    public Americano() {
        price = 3000;
    }
}

class IceTeaShotPlus extends Coffee {
    public IceTeaShotPlus() {
        price = 3500;
    }
}
