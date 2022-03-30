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

  // Fucntion for withdrawing operation
  int withdraw(var currentBal) {
    var withdrawAmount;
    var updatedBal;

    do {
      stdout.write("Enter an amount to withdraw [0 to cancel]: ");
      withdrawAmount = stdin.readLineSync();

      if (currentBal == 0) {
        print("You can't withdraw with a remaining balance of 0");
        break;
      } else if (checkInvalidInput(withdrawAmount)) {
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
  int deposit(var currentBal) {
    var depositAmount;
    var updatedBal;

    do {
      stdout.write("Enter an amount to deposit [0 to cancel]: ");
      depositAmount = stdin.readLineSync();

      if (checkInvalidInput(depositAmount)) {
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

  //Function for updating the balance
  int updateBalance(var amount, var currentBal) {
    var updatedBal = amount + currentBal;
    return updatedBal;
  }

  //Function for checking invalid inputs
  bool checkInvalidInput(var amount) {
    if (int.tryParse(amount ?? "") == null) {
      return true;
    } else {
      return false;
    }
  }
}
