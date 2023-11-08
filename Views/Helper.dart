import 'dart:io';


class Helper {
  
  static void ClearConsole() {
    if (Platform.isWindows) {
      print(Process.runSync("clear", [], runInShell: true).stdout);
    } else {
      throw new Exception("Not implemented for non-windows platforms!");
    }    
  }
  
  static void CloseApplication() {
    exit(0);
  }
}