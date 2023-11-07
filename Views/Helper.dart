import 'dart:io';

class Helper {
  
  static void clearConsole() {
    if (Platform.isWindows) {
      Process.run('cls', []);
    } else {
      Process.run('clear', []);
    }
  }
}