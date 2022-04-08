import 'dart:io';
import 'controller.dart';
import 'userAccount.dart';

void main(List<String> args) {
  controller control = new controller();

  var accountDetails = control.readUserAccount().split(' ');

  userAccount account = new userAccount(accountDetails.elementAt(0),
      accountDetails.elementAt(1), int.parse(accountDetails.elementAt(2)));

  //User Account login
  loginSection(control, account);

  //Bank Transaction part
  transacSection(control, account);
}

void loginSection(controller control, userAccount account) {
  print("---------------");
  print("-ACCOUNT LOGIN-");
  print("---------------");

  do {
    stdout.write("USERNAME: ");
    var userName = stdin.readLineSync();
    stdout.write("PIN: ");
    var pin = stdin.readLineSync();

    if (control.checkLogin(userName, pin, account)) {
      return;
    } else {
      print("Wrong Credentials!");
    }
  } while (true);
}

void transacSection(controller control, userAccount account) {
  var transac;
  var choice;
  var currentBal = account.getCurrentBal();

  do {
    print("----------------------------");
    print("- Automated Teller Machine -");
    print("----------------------------");
    print("- CHOOSE AN ACTION          ");
    print("----------------------------");
    print("- [1] WITHDRAW             -");
    print("- [2] DEPOSIT              -");
    print("- [3] VIEW BALANCE         -");
    print("- [4] CHANGE PIN           -");
    print("- [5] EXIT                 -");
    print("----------------------------");

    choice = getChoice();

    if (choice == 5) {
      break;
    } else {
      if (choice > 4) {
        transac = bankTransacType(choice);
      } else {
        transac = changePin;
      }
    }

    switch (transac) {
      case withdraw:
        currentBal = transac(currentBal, control);
        break;
      case deposit:
        currentBal = transac(currentBal, control);
        break;
      case viewBalance:
        transac(currentBal, control);
        break;
      case changePin:
        transac(control, account);
        break;
    }

    account.setCurrentBal(currentBal);
  } while (true);
  account.updateUserAccount(account);
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
bankTransac bankTransacType(var choice) {
  if (choice == 1) {
    return withdraw;
  } else if (choice == 2) {
    return deposit;
  } else {
    return viewBalance;
  }
}

//Function for checking invalid inputs
bool checkInvalidInput(var choice) {
  if (int.tryParse(choice ?? "") == null ||
      int.parse(choice) > 5 ||
      int.parse(choice) <= 0) {
    return true;
  } else {
    return false;
  }
}

typedef bankTransac(var currentBal, controller control);

deposit(var currentBal, controller control) => control.deposit(currentBal);

withdraw(var currentBal, controller control) => control.withdraw(currentBal);

viewBalance(var currentBal, controller control) =>
    control.viewBalance(currentBal);

typedef accountAction(controller control, userAccount account);

changePin(controller control, userAccount account) =>
    control.changePin(account);
