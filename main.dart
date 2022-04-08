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
  bankTransac transac;
  var choice;
  var currentBal = account.getCurrentBal();

  do {
    print("----------------------------");
    print("- Automated Teller Machine -");
    print("----------------------------");
    print("- CHOOSE AN ACTION          ");
    print("----------------------------");
    print("- [1] WITHDRAW  [2]DEPOSIT -");
    print("- [3] VIEW BALANCE         -");
    print("----------------------------");

    choice = getChoice();

    if (choice == 4) {
      break;
    } else {
      transac = bankTransacType(choice);
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
    }

    account.setCurrentBal(currentBal);
    account.updateUserAccount(account);
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
      int.parse(choice) > 4 ||
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
