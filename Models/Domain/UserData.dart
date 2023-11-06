import '../Enums/AccountType.dart';

class UserData {
  String name;
  String password;
  AccountType accountType;

  UserData(this.name, this.password, this.accountType);

  factory UserData.fromJson(Map<String, Object?> jsonMap){
    return UserData(jsonMap["name"] as String, jsonMap["password"] as String, jsonMap["accountType"] as AccountType);
  }

  Map toJson() => { "name": name, "password": password, "accountType": accountType };
}