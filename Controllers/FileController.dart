import 'dart:collection';
import 'dart:io';
import 'dart:convert';

import '../Models/Domain/UserData.dart';
import '../Models/Enums/AccountType.dart';
import '../Models/Domain/Product.dart';
import '../Models/UserBase.dart';
import 'AuthenticationController.dart';

class FileController {
    String get _usersFilePath => "users.json";
    String get _productsFilePath => "products.json";

    FileController() {
      InitializeData();
    }

    void InitializeData() async {

      List<UserData> initUsersData = [
        UserData("Customer", "pswrd0", AccountType.Customer),
        UserData("Manager", "pswrd1", AccountType.Manager),
      ];

      List<Product> initProductsData = [
        Product("Bread", 5.0, 4.5, 10000, 500),
        Product("Eggs", 1.0, 0.9, 5000, 100),
        Product("Cheese", 10.0, 9.8, 8000, 300),
        Product("Apples", 0.25, 0.23, 35000, 1000),
        Product("Pasta", 3.0, 2.8, 10000, 100),
        Product("Ice cream", 2.5, 2.3, 3000, 50),
        Product("Snacks", 1.5, 1.4, 50000, 500),
        Product("Yogurt", 6.5, 6.2, 6000, 350),
        Product("Pancakes", 2.0, 1.95, 300, 100),
        Product("Bread rolls", 1.2, 1.15, 400, 100),
      ];

      await WriteUsersInFile(initUsersData);
      await WriteProductsInFile(initProductsData);
    }
    
    //region Users

    Future<List<UserData>> _GetUsersAsync() async {
      File file = File(_usersFilePath);

      try {
        if (!file.existsSync()) {
          throw new Exception("File is not exist");
        }

        final contents = await file.readAsString();

        if (contents.isEmpty) {
          throw new Exception("File is empty");
        }

        final jsonString = await file.readAsString();
        final jsonList = jsonDecode(jsonString) as List;
        return jsonList.map((json) => UserData.fromJson(json)).toList();
      }
      catch (e) {
        throw new Exception("Failed to read or parse the file: $e");
      }
    }

    Future<void> WriteUsersInFile(List<UserData> userList) async {
      final file = File(_usersFilePath);

      if (!await file.exists()) {
        await file.create(recursive: true);
      }

      final userListJson = userList.map((user) => user.toJson()).toList();
      final jsonString = jsonEncode(userListJson);
      await file.writeAsString(jsonString);
    }
    
    //endregion
    
    //region Products

    Future<List<Product>> GetProductsAsync() async {
      File file = File(_productsFilePath);

      try {
        if (!file.existsSync()) {
          throw new Exception("File is not exist");
        }

        final contents = await file.readAsString();

        if (contents.isEmpty) {
          throw new Exception("File is empty");
        }

        final jsonString = await file.readAsString();
        final jsonList = jsonDecode(jsonString) as List;
        return jsonList.map((json) => Product.fromJson(json)).toList();
      }
      catch (e) {
        throw new Exception("Failed to read or parse the file: $e");
      }
    }

    Future<void> WriteProductsInFile(List<Product> productList) async {
      final file = File(_productsFilePath);

      if (!await file.exists()) {
        await file.create(recursive: true);
      }

      final productListJson = productList.map((pr) => pr.toJson()).toList();
      final jsonString = jsonEncode(productListJson);
      await file.writeAsString(jsonString);
    }
    
    //endregion
    
    Future<void> ChangeProductPrice(String productName, double newPrice, double newWholesalePrice) async {
      List<Product> products = await GetProductsAsync();
      
      int indexOfSelectedProduct = products.indexWhere((p) => p.name == productName);
      products[indexOfSelectedProduct].price = newPrice;
      products[indexOfSelectedProduct].wholesalePrice = newWholesalePrice;
      
      await WriteProductsInFile(products);         
    }

    Future<bool> AuthenticationAsync(String username, String password) async {
        List<UserData> users = await _GetUsersAsync();

        UserData? userData = users.firstWhere((u) => (u.name == username) & (u.password == password));
        if(userData == Null) return false;

        AuthenticationController.userData = userData;
        return true;
    }
}