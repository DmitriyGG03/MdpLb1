import 'dart:io';

class Helper {
  
  static void ClearConsole() {
    if (Platform.isWindows) {
      Process.run('cls', []);
    } else {
      Process.run('clear', []);
    }
  }
  
  static void CloseApplication() {
    exit(0);
  }
}