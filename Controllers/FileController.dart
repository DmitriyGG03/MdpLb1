import 'dart:collection';
import 'dart:io';
import 'dart:convert';

import '../Models/Domain/Users.dart';

class FileController {
    String get _filePath => "users.json";

    Future<Users> _GetUsersAsync() async {
      File file = File(_filePath);

      try {
        final contents = await file.readAsString();

        if (contents.isEmpty) {
          throw Exception("File is empty");
        }

        final decoded = json.decode(contents);
        return Users.fromJson(decoded);
      }
      catch (e) {
        throw Exception("Failed to read or parse the file: $e");
      }
    }

    Future<bool> AuthenticationAsync(String username, String password) async {
        Users users = await _GetUsersAsync();

        return users.namePassword.containsKey(username) & (users.namePassword[username] == password);
    }
}