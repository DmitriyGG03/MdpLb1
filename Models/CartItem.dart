import 'Domain/Product.dart';

class CartItem {
  late Product product;
  late int quantity;
  
  double get itemPrice => 
      quantity >= product.wholesaleQuantity ? 
      product.wholesalePrice * quantity :
      product.price * quantity;
  
  CartItem(this.product, this.quantity);
}