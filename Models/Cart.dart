import 'dart:collection';

import 'CartItem.dart';
import 'Domain/Product.dart';

class Cart {
  List<CartItem> CartItems = [];
  
  double get TotalPrice => CartItems.fold(0, (sum, item) => sum + item.itemPrice);
}