import 'dart:io';
import 'userAccount.dart';

class controller {
  //Fucntion for reading the balance text file
  String readUserAccount() {
    String content = new File('dbAccount.txt').readAsStringSync();
    return content;
  }

  //Checks login credentials
  bool checkLogin(var userName, var pin, userAccount account) {
    if (userName == account.getUserName() && pin == account.getPin()) {
      return true;
    } else {
      return false;
    }
  }

  //Function for changing pin
  void changePin(userAccount account) {
    String currentPin = account.getPin();

    do {
      print("----------------");
      print("- PIN CHANGING -");
      print("----------------");

      stdout.write("Enter your current pin: ");
      String? getCurrentPin = stdin.readLineSync();

      stdout.write("Enter your new pin: ");
      String? newPin = stdin.readLineSync();

      if (newPin == currentPin) {
        print("You cannot use your current pin as your new pin");
      } else if (newPin!.contains(new RegExp(r'[A-Za-z]'))) {
        print("You must enter a 6 digit pin");
      } else if (newPin.length > 6 || newPin.length < 6) {
        print("You must enter a 6 digit pin");
      } else if (getCurrentPin != currentPin) {
        print("Please ensure you entered your current pin correctly");
      } else {
        account.setPin(newPin);
        return;
      }
    } while (true);
  }

  //Function for viewing account balance
  void viewBalance(userAccount account) {
    var currentBal = account.getCurrentBal();
    print("Your current balance is $currentBal");
  }

  // Fucntion for withdrawing operation
  int withdraw(userAccount account) {
    var currentBal = account.getCurrentBal();
    var withdrawAmount;
    var updatedBal;

    do {
      stdout.write("Enter an amount to withdraw [0 to cancel]: ");
      withdrawAmount = stdin.readLineSync();

      if (currentBal == 0) {
        print("You can't withdraw with a remaining balance of 0");
        break;
      } else if (int.tryParse(withdrawAmount ?? "") == null) {
        print("Integers only!");
      } else if (int.parse(withdrawAmount) == 0) {
        print("You have cancelled your transaction");
        return currentBal;
      } else if (int.parse(withdrawAmount!) < 100) {
        print("100 is the minimum amount that can be withdraw");
      } else if (int.parse(withdrawAmount) > currentBal) {
        print("You have exceeded the allowable amount that can be withdrawn");
      } else {
        updatedBal = updateBalance(int.parse(withdrawAmount) * -1, currentBal);
        break;
      }
    } while (true);

    return updatedBal;
  }

  // Function for deposit operation
  int deposit(userAccount account) {
    var currentBal = account.getCurrentBal();
    var depositAmount;
    var updatedBal;

    do {
      stdout.write("Enter an amount to deposit [0 to cancel]: ");
      depositAmount = stdin.readLineSync();

      if (int.tryParse(depositAmount ?? "") == null) {
        print("Integers only!");
      } else if (int.parse(depositAmount) < 0) {
        print("Not a valid input!");
      } else if (int.parse(depositAmount) == 0) {
        print("You have cancelled your transaction");
        return currentBal;
      } else {
        updatedBal = updateBalance(int.parse(depositAmount), currentBal);
        break;
      }
    } while (true);

    return updatedBal;
  }

  void chooseAccountType(userAccount account) {
    bool isContinue = false;

    do {
      print("-----------------------");
      print("-    ACCOUNT TYPES    -");
      print("-----------------------");
      print(" [1] SAVINGS [2] CURRENT ");
      print("-----------------------");
      stdout.write("Enter account type: ");
      var choice = stdin.readLineSync();

      if (isInvalidChoice(choice, 2)) {
        print("Not a valid option!");
      } else if (int.parse(choice!) == 1) {
        isContinue = isExistingAccount(account, "savings");
      } else {
        isContinue = isExistingAccount(account, "current");
      }
    } while (!isContinue);
  }

  bool isExistingAccount(userAccount account, var accountType) {
    if (account.getAccountType() == accountType) {
      return true;
    } else {
      print("Account does not exist");
      return false;
    }
  }

  //Function for updating the balance
  int updateBalance(var amount, var currentBal) {
    var updatedBal = amount + currentBal;
    return updatedBal;
  }

  //Function for checking invalid inputs
  bool isInvalidChoice(var choice, var range) {
    if (int.tryParse(choice ?? "") == null ||
        int.parse(choice) > range ||
        int.parse(choice) <= 0) {
      return true;
    } else {
      return false;
    }
  }
}
