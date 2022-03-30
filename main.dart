import 'dart:io';
import 'controller.dart';

void main(List<String> args) {
  controller control = new controller();
  bankTransac transac;

  // Gets the current balance value
  var currentBal = control.getCurrentBal();
  var choice;

  do {
    print("----------------------------");
    print("- Automated Teller Machine -");
    print("----------------------------");
    print("  Current Balance: $currentBal");
    print("----------------------------");
    print("- [1] WITHDRAW  [2]DEPOSIT -");
    print("- [3] EXIT                 -");
    print("----------------------------");

    choice = getChoice();

    if (choice == 3) {
      break;
    } else {
      transac = transacType(choice);
    }

    switch (transac) {
      case withdraw:
        currentBal = transac(currentBal, control);
        break;
      case deposit:
        currentBal = transac(currentBal, control);
        break;
    }
  } while (true);
}

//Function for getting input
int getChoice() {
  var choice;
  do {
    stdout.write("Enter Operation: ");
    choice = stdin.readLineSync();

    if (checkInvalidInput(choice)) {
      print("Not a valid option");
    } else {
      return int.parse(choice);
    }
  } while (true);
}

// Returns the defined function under typeddef bankTransac
bankTransac transacType(var choice) {
  if (choice == 1) {
    return withdraw;
  } else {
    return deposit;
  }
}

//Function for checking invalid inputs
bool checkInvalidInput(var choice) {
  if (int.tryParse(choice ?? "") == null || int.parse(choice) > 3) {
    return true;
  } else {
    return false;
  }
}

typedef bankTransac(var currentBal, controller control);

deposit(var currentBal, controller control) => control.deposit(currentBal);

withdraw(var currentBal, controller control) => control.withdraw(currentBal);
