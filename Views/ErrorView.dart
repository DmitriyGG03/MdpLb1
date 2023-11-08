
import 'dart:io';
import 'Helper.dart';

class ErrorView {

  static void DisplayErrorMessage(String message) {
    Helper.ClearConsole();
    
    stdout.write("Error: $message.\n");

    stdout.write("Press any button to exit");
    
  }
}