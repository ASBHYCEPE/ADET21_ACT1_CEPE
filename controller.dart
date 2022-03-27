import 'dart:io';

class controller {
  //Fucntion for reading the balance text file
  int getCurrentBal() {
    String content = new File('balance.txt').readAsStringSync();
    return int.parse(content);
  }

  // Fucntion for withdrawing operation
  void withdraw(var currentBal) {
    do {
      stdout.write("Enter an amount to withdraw: ");
      var withdrawAmount = stdin.readLineSync();

      if (currentBal == 0) {
        print("You can't withdraw with a remaining balance of 0");
        break;
      } else if (checkInvalidInput(withdrawAmount)) {
        print("Integers only!");
      } else if (int.parse(withdrawAmount!) < 100) {
        print("100 is the minimum amount that can be withdraw");
      } else if (int.parse(withdrawAmount) > currentBal) {
        print("You have exceeded the allowable amount that can be withdrawn");
      } else {
        break;
      }
    } while (true);
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
