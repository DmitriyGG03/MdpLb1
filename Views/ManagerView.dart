import 'dart:io';
import '../Controllers/ManagerController.dart';
import '../Models/Domain/Product.dart';
import 'Helper.dart';

class ManagerView {
  late final ManagerController managerController;
  
  ManagerView(this.managerController);
  
  //region Select action 
  
  void GetActionMenuNumber() {    
    
    while(true) {   

      _CreateMenu();
      String inputActionNumber = stdin.readLineSync() ?? "";

      managerController.ActionHandler(inputActionNumber);
    }
  }
  
  void _CreateMenu() {
    stdout.writeln("----------Menu----------");
    stdout.writeln("1. Change product price");
    stdout.writeln("2. Close application");
    stdout.writeln("--------End-Menu--------");
    stdout.writeln();
    stdout.writeln("Enter the action number: ");
  }
  
  //endregion
  
  //region Select product

  Product GetProductByName(List<Product> products) {
    String inputActionNumber;
    
    do {
      Helper.ClearConsole();
      
      _DisplayProductList(products);

      inputActionNumber = stdin.readLineSync() ?? "";      
      
    } while (!managerController.ProductSelectionHandler(inputActionNumber, products.length));
        
    return products[int.parse(inputActionNumber) - 1];    
  }
  
  void _DisplayProductList(List<Product> products) {
    stdout.writeln("-------Product list-------");
    for(int i = 0; i < products.length; i++) {

      stdout.writeln("${i + 1}. ${products[i].name}");
    }
    stdout.writeln("---------End-List---------");
    stdout.writeln();
    stdout.writeln("Enter the product number: ");
  }
  
  //endregion
  
  //region Select new prices
  
  (double, double) GetNewPrice(double price, double wholesalePrice) {
    String inputNewPrice;
    String inputNewWholesalePrice;
    
    do {
      Helper.ClearConsole();

      stdout.writeln("Old price: $price");
      stdout.write("New price: ");

      inputNewPrice = stdin.readLineSync() ?? "";

      stdout.writeln("Old wholesale price: $price");
      stdout.write("New wholesale price: ");

      inputNewWholesalePrice = stdin.readLineSync() ?? "";

    } while (!managerController.NewPriceHandler(inputNewPrice, inputNewWholesalePrice));

    return (double.parse(inputNewPrice), double.parse(inputNewWholesalePrice));
  }
  
  //endregion
}