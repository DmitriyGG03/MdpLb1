import '../Enums/AccountType.dart';

class UserData {
  String name;
  String password;
  AccountType accountType;

  UserData(this.name, this.password, this.accountType);

  factory UserData.fromJson(Map<String, Object?> jsonMap) {
    return UserData(
      jsonMap["name"] as String,
      jsonMap["password"] as String,
      JsonAccountTypeSerializeHelper.DeserializeAccountType(
          jsonMap["accountType"] as String),
    );
  }

  Map toJson() => {
        "name": name,
        "password": password,
        "accountType":
            JsonAccountTypeSerializeHelper.SerializeAccountType(accountType)
      };
}
