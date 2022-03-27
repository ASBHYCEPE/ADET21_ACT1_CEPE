import 'dart:io';

class controller {
  //Fucntion for reading the balance text file
  int getCurrentBal() {
    String content = new File('balance.txt').readAsStringSync();
    return int.parse(content);
  }
}
