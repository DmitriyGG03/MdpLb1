class Users {
  Map<String, String> namePassword;

  Users(this.namePassword);

  factory Users.fromJson(Map<String, Object?> jsonMap){
    return Users(jsonMap["namePassword"] as Map<String, String>);
  }

  Map toJson() => { "namePassword": namePassword };
}