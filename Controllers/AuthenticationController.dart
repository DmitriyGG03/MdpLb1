import 'dart:io';

import '../Views/AuthenticationView.dart';
import '../Views/ErrorView.dart';
import 'FileController.dart';

class AuthenticationController {
    final String _errorMessage = "Username or password is incorrect! Please, try again!";

    late final AuthenticationView authView;
    late final FileController _fileController;

    AuthenticationController(FileController fileController) {
        authView = new AuthenticationView(this);
        _fileController = fileController;

        ExecuteAuthenticationProcedure();
    }

    void ExecuteAuthenticationProcedure() {
        authView.StartAuthorization();

        //TODO: Think about designating the rights and functionality of the client and manager accounts
    }
    
    bool Authorize(String username, String password) {
        if (username == "exit") exit(0);

        Future.sync(() async {

            if (username.isEmpty | password.isEmpty | !await _fileController.AuthenticationAsync(username, password)) {
                ErrorView.DisplayErrorMessage(_errorMessage);

                return false;
            }

        });

        return true;
    }
}