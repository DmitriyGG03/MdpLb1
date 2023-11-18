import 'dart:io';
import '../Controllers/CustomerController.dart';
import '../Models/Cart.dart';
import '../Models/Domain/Product.dart';
import 'Helper.dart';

class CustomerView {
  late final CustomerController customerController;

  CustomerView(this.customerController);

  //region Select action 

  void GetActionMenuNumber(Cart cart) {

    while(true) {
      Helper.DrowEndMessage();
      
      _DisplayCart(cart);
      _CreateMenu();
      
      String inputActionNumber = stdin.readLineSync() ?? "";

      customerController.ActionHandler(inputActionNumber);
    }
  }

  void _CreateMenu() {
    stdout.writeln("----------Menu----------");
    stdout.writeln("1. Add product to cart");
    stdout.writeln("2. Buy products in the cart"); 
    stdout.writeln("3. Close application");
    stdout.writeln("--------End-Menu--------");
    stdout.writeln();
    stdout.writeln("Enter the action number: ");
  }

  void _DisplayCart(Cart cart) {    
    stdout.writeln("----------Cart----------");
    if (cart.CartItems.length == 0) {
      stdout.writeln("<<<Cart is Empty>>>");
    }
    else {
      int cartNumber = 1;
      
      cart.CartItems.forEach((ci) {
        stdout.writeln("${cartNumber++}. Product name: ${ci.product.name}, quantity: ${ci.quantity}, item price: ${ci.itemPrice}");
      });
    }
    stdout.writeln("--------End-Cart--------");
    stdout.writeln();
  }

  //endregion

  Product SelectProduct(List<Product> products) {
    String inputActionNumber;
    
    do {
      Helper.DrowEndMessage();

      _DisplayProductList(products);

      inputActionNumber = stdin.readLineSync() ?? "";
      
    } while (!customerController.IsNumberInDiapason(inputActionNumber, products.length) );

    return products[int.parse(inputActionNumber) - 1];
  }

  void _DisplayProductList(List<Product> products) {
    stdout.writeln("-------Product list-------");
    for(int i = 0; i < products.length; i++) {

      stdout.writeln("${i + 1}. ${products[i].name}");
    }
    stdout.writeln("---------End-List---------");
    stdout.writeln();
    stdout.writeln("Enter the product number you want to add to cart: ");
  }

  int SelectProductQuantity(Product product) {
    String inputActionNumber;

    do {
      Helper.DrowEndMessage();

      stdout.writeln("Units in stock: ${product.inStock}");
      stdout.writeln("Wholesale quantity: ${product.wholesaleQuantity}");
      stdout.write("Enter the number you want to buy: ");

      inputActionNumber = stdin.readLineSync() ?? "";

    } while (!customerController.IsNumberInDiapason(inputActionNumber, product.inStock) );

    return int.parse(inputActionNumber);
  }

  bool OperationConfirmationRequest(double totalPrice) {
    String inputActionNumber;
    
    do {
      Helper.DrowEndMessage();
      
      stdout.writeln("Are you sure you want to buy all products in cart (total price: ${totalPrice})? (1 - Confirm; 0 - Dismiss)");

      inputActionNumber = stdin.readLineSync() ?? "";
      
    } while (!customerController.IsNumberInDiapason(inputActionNumber, 1));
      
    return int.parse(inputActionNumber) == 0 ? false : true;
  }
}