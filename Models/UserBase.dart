import 'Domain/Product.dart';

abstract class UserBase {
  late String _username;

  UserBase(String username) {
    this._username = username;
  }
}