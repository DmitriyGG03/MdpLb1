import 'dart:io';


class Helper {
  
  static void DrowEndMessage() {
    stdout.write("\n");
    
    for (int i = 0; i < 20; i++) {
      stdout.write("-=");
    }
    
    stdout.write("\n\n");    
  }
  
  static void CloseApplication() {
    exit(0);
  }
}