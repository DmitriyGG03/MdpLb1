import 'UserBase.dart';

class Customer extends UserBase {

  double accountBalance = 1 * 10e10; //Infinitive money, can be change later
  
  Customer(String name) : super(name);
}