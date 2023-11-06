import 'dart:collection';
import 'dart:io';
import 'dart:convert';

import '../Models/Domain/UserData.dart';
import '../Models/Enums/AccountType.dart';
import '../Models/User.dart';
import 'AuthenticationController.dart';

class FileController {
    String get _filePath => "users.json";

    FileController() {
      InitializeData();
    }

    void InitializeData() async {

      List<UserData> initData = [
        UserData("Customer", "pswrd0", AccountType.Customer),
        UserData("Manager", "pswrd1", AccountType.Manager),
      ];

      await WriteUsersInFile(initData);
    }

    Future<List<UserData>> _GetUsersAsync() async {
      File file = File(_filePath);

      try {
        if (!file.existsSync()) {
          throw new Exception("File is not exist");
        }

        final contents = await file.readAsString();

        if (contents.isEmpty) {
          throw new Exception("File is empty");
        }

        final jsonString = await file.readAsString();
        final jsonList = jsonDecode(jsonString) as List;
        return jsonList.map((json) => UserData.fromJson(json)).toList();
      }
      catch (e) {
        throw new Exception("Failed to read or parse the file: $e");
      }
    }

    Future<void> WriteUsersInFile(List<UserData> userList) async {
      final file = File(_filePath);

      if (!await file.exists()) {
        await file.create(recursive: true);
      }

      final userListJson = userList.map((user) => user.toJson()).toList();
      final jsonString = jsonEncode(userListJson);
      await file.writeAsString(jsonString);
    }

    Future<bool> AuthenticationAsync(String username, String password) async {
        List<UserData> users = await _GetUsersAsync();

        UserData? userData = users.firstWhere((u) => (u.name == username) & (u.password == password));
        if(userData == Null) return false;

        AuthenticationController.userData = userData;
        return true;
    }
}