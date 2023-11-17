
import 'dart:io';
import 'Helper.dart';

class ErrorView {

  static void DisplayErrorMessage(String error) {
    Helper.DrowEndMessage();
    stdout.writeln("----------ERROR----------");
    
    stdout.writeln("Error: $error.");

    stdout.writeln("---------END-ERROR-------");
  }
}