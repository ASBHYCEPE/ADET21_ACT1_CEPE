import 'dart:io';

class userAccount {
  String userName = "";
  String pin = "";
  String accountType = "";
  int currentBal = 0;

  userAccount(String userName, String pin, int currentBal, String accountType) {
    this.setUserName(userName);
    this.setPin(pin);
    this.setCurrentBal(currentBal);
    this.setAccountType(accountType);
  }

  void setUserName(String userName) => this.userName = userName;
  void setPin(String pin) => this.pin = pin;
  void setCurrentBal(int currentBal) => this.currentBal = currentBal;
  void setAccountType(String accountType) => this.accountType = accountType;

  String getUserName() => this.userName;
  String getPin() => this.pin;
  int getCurrentBal() => this.currentBal;
  String getAccountType() => this.accountType;

  // Fucntion for updatin the user account
  void updateUserAccount(userAccount account) {
    var updatedUserData = account.userName +
        ' ' +
        account.pin +
        ' ' +
        account.currentBal.toString();

    var file = File('dbAccount.txt');
    var sink = file.openWrite();
    sink.write(updatedUserData);
    sink.close();
  }
}
