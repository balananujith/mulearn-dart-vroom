import 'dart:io';

// Define the Car class
class Car {
  // Properties of the Car class
  String name;
  double price;

  // Constructor to initialize the Car object
  Car(this.name, this.price);

  // Method to change the price of the car
  void changePrice(double newPrice) {
    price = newPrice;
    print('The price of $name has been updated to \$$price.');
  }

  @override
  String toString() {
    return '$name (\$$price)';
  }
}

// Define the Person class
class Person {
  // Properties of the Person class
  String name;
  List<Car> ownedCars;
  double moneyLeft;

  // Constructor to initialize the Person object
  Person(this.name, this.moneyLeft) : ownedCars = [];

  // Method to buy a car
  void buyCar(Car car) {
    if (moneyLeft >= car.price) {
      ownedCars.add(car);
      moneyLeft -= car.price;
      print('$name bought a ${car.name} for \$${car.price}.');
    } else {
      print('$name does not have enough money to buy the ${car.name}.');
    }
  }

  // Method to sell a car
  void sellCar(Car car) {
    if (ownedCars.contains(car)) {
      ownedCars.remove(car);
      moneyLeft += car.price;
      print('$name sold the ${car.name} for \$${car.price}.');
    } else {
      print('$name does not own the ${car.name}.');
    }
  }

  // Method to display owned cars
  void displayOwnedCars() {
    if (ownedCars.isEmpty) {
      print('$name does not own any cars.');
    } else {
      print('$name owns the following cars:');
      for (var car in ownedCars) {
        print(' - ${car.name} (\$${car.price})');
      }
    }
  }

  @override
  String toString() {
    return '$name (\$$moneyLeft)';
  }
}

void main() {
  // Creating initial car objects
  Car car1 = Car('Tesla Model S', 80000);
  Car car2 = Car('Ford Mustang', 55000);
  Car car3 = Car('Chevrolet Camaro', 45000);

  // Creating a person object
  Person person = Person('Alice', 100000);

  // User interaction loop
  while (true) {
    print('\nWelcome to the Car Buying and Selling Platform!');
    print('1. Buy a car');
    print('2. Sell a car');
    print('3. View owned cars');
    print('4. Change car price');
    print('5. Exit');
    stdout.write('Please select an option: ');

    String? choice = stdin.readLineSync();
    if (choice == '1') {
      print('\nAvailable cars to buy:');
      print('1. ${car1}');
      print('2. ${car2}');
      print('3. ${car3}');
      stdout.write('Enter the number of the car you want to buy: ');
      String? carChoice = stdin.readLineSync();
      if (carChoice == '1') {
        person.buyCar(car1);
      } else if (carChoice == '2') {
        person.buyCar(car2);
      } else if (carChoice == '3') {
        person.buyCar(car3);
      } else {
        print('Invalid choice.');
      }
    } else if (choice == '2') {
      print('\nCars owned by ${person.name}:');
      for (int i = 0; i < person.ownedCars.length; i++) {
        print('${i + 1}. ${person.ownedCars[i]}');
      }
      stdout.write('Enter the number of the car you want to sell: ');
      String? carChoice = stdin.readLineSync();
      int index = int.tryParse(carChoice!) ?? -1;
      if (index > 0 && index <= person.ownedCars.length) {
        person.sellCar(person.ownedCars[index - 1]);
      } else {
        print('Invalid choice.');
      }
    } else if (choice == '3') {
      person.displayOwnedCars();
    } else if (choice == '4') {
      print('\nAvailable cars to change price:');
      print('1. ${car1}');
      print('2. ${car2}');
      print('3. ${car3}');
      stdout.write('Enter the number of the car you want to change price: ');
      String? carChoice = stdin.readLineSync();
      stdout.write('Enter the new price: ');
      String? newPriceStr = stdin.readLineSync();
      double? newPrice = double.tryParse(newPriceStr!);
      if (newPrice != null) {
        if (carChoice == '1') {
          car1.changePrice(newPrice);
        } else if (carChoice == '2') {
          car2.changePrice(newPrice);
        } else if (carChoice == '3') {
          car3.changePrice(newPrice);
        } else {
          print('Invalid choice.');
        }
      } else {
        print('Invalid price entered.');
      }
    } else if (choice == '5') {
      print('Thank you for using the Car Buying and Selling Platform!');
      break;
    } else {
      print('Invalid choice.');
    }
  }
}
