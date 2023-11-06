import 'dart:io';
import '../Controllers/AuthenticationController.dart';
import 'ErrorView.dart';
import 'Helper.dart';

class AuthenticationView {
    late final AuthenticationController _controller;

    AuthenticationView(AuthenticationController controller) {
      this._controller = controller;
    }

    StartAuthorization() {
      String inputUsername;
      String inputPassword;

      do {
        Helper.clearConsole();

        stdout.write("Enter your username (Enter \"exit\" to close app): ");
        inputUsername = stdin.readLineSync() ?? "";

        stdout.write("Enter password: ");
        inputPassword = stdin.readLineSync() ?? "";

      } while(!_controller.Authorize(inputUsername, inputPassword));
    }

}