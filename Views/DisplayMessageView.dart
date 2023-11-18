
import 'dart:io';
import 'Helper.dart';

class DisplayMessageView {

  static void DisplayErrorMessage(String error) {
    Helper.DrowEndMessage();
    stdout.writeln("----------ERROR----------");
    
    stdout.writeln("Error: $error.");

    stdout.writeln("---------END-ERROR-------");
  }

  static void DisplaySuccessMessage(String info) {
    Helper.DrowEndMessage();
    stdout.writeln("-----------INFO----------");

    stdout.writeln("Successful operation: $info.");

    stdout.writeln("---------END-INFO--------");
  }
}