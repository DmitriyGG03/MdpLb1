import 'dart:collection';
import 'dart:io';
import 'dart:convert';

import '../Models/Domain/UserData.dart';
import '../Models/Enums/AccountType.dart';
import '../Models/Domain/Product.dart';
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

      WriteUsersInFile(initUsersData);
      WriteProductsInFile(initProductsData);
    }
    
    //region Users

    List<UserData> _GetUsers() {
      File file = File(_usersFilePath);

      try {
        if (!file.existsSync()) {
          throw new Exception("File is not exist");
        }

        final jsonString = file.readAsStringSync();

        if (jsonString.isEmpty) {
          throw new Exception("File is empty");
        }
        
        final jsonList = jsonDecode(jsonString) as List;
        return jsonList.map((json) => UserData.fromJson(json)).toList();
      }
      catch (e) {
        throw new Exception("Failed to read or parse the file: $e");
      }
    }

    void WriteUsersInFile(List<UserData> userList) {
      final file = File(_usersFilePath);
      
      if (!file.existsSync()) {
        file.create(recursive: true);
      }

      final userListJson = userList.map((user) => user.toJson()).toList();
      final jsonString = jsonEncode(userListJson);
      file.writeAsStringSync(jsonString);
    }
    
    //endregion
    
    //region Products

    List<Product> GetProducts()  {
      File file = File(_productsFilePath);

      try {
        if (!file.existsSync()) {
          throw new Exception("File is not exist");
        }

        final jsonString = file.readAsStringSync();

        if (jsonString.isEmpty) {
          throw new Exception("File is empty");
        }
        
        final jsonList = jsonDecode(jsonString) as List;
        return jsonList.map((json) => Product.fromJson(json)).toList();
      }
      catch (e) {
        throw new Exception("Failed to read or parse the file: $e");
      }
    }

    void WriteProductsInFile(List<Product> productList) {
      final file = File(_productsFilePath);

      if (!file.existsSync()) {
        file.create(recursive: true);
      }

      final productListJson = productList.map((pr) => pr.toJson()).toList();
      final jsonString = jsonEncode(productListJson);
      file.writeAsStringSync(jsonString);
    }
    
    //endregion
    
    void ChangeProductPrice(String productName, double newPrice, double newWholesalePrice) {
      List<Product> products = GetProducts();
      
      int indexOfSelectedProduct = products.indexWhere((p) => p.name == productName);
      products[indexOfSelectedProduct].price = newPrice;
      products[indexOfSelectedProduct].wholesalePrice = newWholesalePrice;
      
      WriteProductsInFile(products);         
    }

    bool Authentication(String username, String password) {
        List<UserData> users = _GetUsers();
        UserData? _userData = null;

        for(UserData userData in users) {
          if((userData.name == username) & (userData.password == password)) {
            _userData = userData;
          }            
        }
        
        if(_userData == null) return false;

        AuthenticationController.userData = _userData;
        return true;
    }
}