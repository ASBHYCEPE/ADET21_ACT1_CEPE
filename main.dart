import 'dart:io';
import 'controller.dart';

void main(List<String> args) {
  controller control = new controller();

  // Gets the current balance value
  var currentBal = control.getCurrentBal();
  var choice;

  print("----------------------------");
  print("- Automated Teller Machine -");
  print("----------------------------");
  print("  Current Balance: $currentBal");
  print("----------------------------");
  print("- [1] WITHDRAW  [2]DEPOSIT -");
  print("- [3] EXIT                 -");
  print("----------------------------");

  do {
    choice = getChoice();
    switch (choice) {
      case 1:
        control.withdraw(currentBal);
        break;
      case 2:
        break;
    }
  } while (choice != 3);
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
      return int.parse(choice); //converts value into integer
    }
  } while (true);
}

//Function for checking invalid inputs
bool checkInvalidInput(var choice) {
  if (int.tryParse(choice ?? "") == null || int.parse(choice) > 3) {
    return true;
  } else {
    return false;
  }
}
