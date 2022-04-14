import 'dart:io';
import 'controller.dart';
import 'userAccount.dart';

void main(List<String> args) {
  controller control = new controller();

  var accountDetails = control.readUserAccount().split(' ');

  userAccount account = new userAccount(
      accountDetails.elementAt(0),
      accountDetails.elementAt(1),
      int.parse(accountDetails.elementAt(2)),
      accountDetails.elementAt(3));

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
      transac = actionType(choice);
    }

    switch (transac) {
      case withdraw:
        account.setCurrentBal(transac(account, control));
        break;
      case deposit:
        account.setCurrentBal(transac(account, control));
        break;
      case viewBalance:
        transac(account, control);
        break;
      case changePin:
        transac(account, control);
        break;
    }
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

// Returns the defined function under typeddef atmAction
atmAction actionType(var choice) {
  switch (choice) {
    case 1:
      return withdraw;
    case 2:
      return deposit;
    case 3:
      return viewBalance;
    default:
      return changePin;
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

typedef atmAction(userAccount account, controller control);

deposit(userAccount account, controller control) => control.deposit(account);

withdraw(userAccount account, controller control) => control.withdraw(account);

viewBalance(userAccount account, controller control) =>
    control.viewBalance(account);

changePin(userAccount account, controller control) =>
    control.changePin(account);
