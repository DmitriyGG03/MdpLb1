import 'dart:io';

import '../Models/Customer.dart';
import '../Models/Domain/UserData.dart';
import '../Models/Enums/AccountType.dart';
import '../Models/Manager.dart';
import '../Views/AuthenticationView.dart';
import '../Views/ErrorView.dart';
import 'CustomerController.dart';
import 'FileController.dart';
import 'ManagerController.dart';

class AuthenticationController {
    final String _errorMessage = "Username or password is incorrect! Please, try again!";
    static late final UserData userData;

    late final AuthenticationView authView;
    late final FileController _fileController;

    AuthenticationController(FileController fileController) {
        authView = new AuthenticationView(this);
        _fileController = fileController;

        ExecuteAuthenticationProcedure();
    }

    void ExecuteAuthenticationProcedure() {
        authView.StartAuthorization();

        if(userData.accountType == AccountType.Manager) {
            ManagerController managerController = new ManagerController(new Manager(userData.name));
        }
        else if(userData.accountType == AccountType.Customer) {
            CustomerController customerController = new CustomerController(new Customer(userData.name));
        }
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