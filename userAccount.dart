class userAccount {
  String userName = "";
  String pin = "";
  int currentBal = 0;

  userAccount(String userName, String pin, int currentBal) {
    this.setUserName(userName);
    this.setPin(pin);
    this.setCurrentBal(currentBal);
  }

  void setUserName(String userName) => this.userName = userName;
  void setPin(String pin) => this.pin = pin;
  void setCurrentBal(int currentBal) => this.currentBal = currentBal;

  String getUserName() => this.userName;
  String getPin() => this.pin;
  int getCurrentBal() => this.currentBal;
}
