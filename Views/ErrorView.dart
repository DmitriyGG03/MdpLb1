import 'dart:io';
import 'Helper.dart';

class ErrorView {

  static void DisplayErrorMessage(String message) {
    stdin.lineMode = false;
    stdin.echoMode = false;

    stdout.write("Error: $message.\n");

    stdout.write("Press any button to exit");
    stdin.listen((event) => exit(0));
  }
}