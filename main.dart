import 'dart:io';

void main(List<String> args) {
  print("----------------------------");
  print("- Automated Teller Machine -");
  print("----------------------------");
  print("- Current Balance: P 0     -");
  print("----------------------------");
  print("- [1] WITHDRAR  [2]DEPOSIT -");
  print("- [3] EXIT                 -");
  print("----------------------------");

  var choice = getChoice();
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
