import '../Models/Domain/Product.dart';
import '../Models/Manager.dart';
import '../Views/ErrorView.dart';
import '../Views/Helper.dart';
import '../Views/ManagerView.dart';
import 'FileController.dart';

class ManagerController {
  String get _errorMessageIncorrectInput =>
      "Entered number is incorrect! Please, try again!";
  String get _errorMessageIncorrectPrice =>
      "The entered price must be higher than the wholesale price! Please, try again!";

  late final Manager manager;
  late final ManagerView managerView;
  late final FileController _fileController;

  ManagerController(this.manager, this._fileController) {
    managerView = new ManagerView(this);

    SelectActionNumber();
  }

  void SelectActionNumber() {
      managerView.GetActionMenuNumber();
  }

  void ActionHandler(String inputActionNumber) {
    int? res = int.tryParse(inputActionNumber);

    if ((res == Null) | (res! < 1) | (res > 2)) {
      ErrorView.DisplayErrorMessage(_errorMessageIncorrectInput);
    }

    if (res == 1) {
      ChangeProductPrice();
    }

    if (res == 2) {
      Helper.CloseApplication();
    }
  }

  void ChangeProductPrice() async {
      //Find product by name
      Product product = await FindProductByName();
      
      double prPrice, prWholesalePrice;
      (prPrice, prWholesalePrice) = await GetNewPriceFromUserAsync(product.price, product.wholesalePrice);

      _fileController.ChangeProductPrice(product.name, prPrice, prWholesalePrice);
  }
  
  Future<Product> FindProductByName() async {
      return managerView.GetProductByName(await _fileController.GetProductsAsync());
  }
  
  bool ProductSelectionHandler(String inputActionNumber, int length) {
      int? res = int.tryParse(inputActionNumber);

      if ((res == Null) | (res! < 1) | (res > length + 1)) {
          ErrorView.DisplayErrorMessage(_errorMessageIncorrectInput);
          
          return false;
      }
      
      return true;
  }

  Future<(double, double)> GetNewPriceFromUserAsync(double price, double wholesalePrice) async {
      return managerView.GetNewPrice(price, wholesalePrice);
  }

  bool NewPriceHandler(String inputNewPrice, String inputNewWholesalePrice) {
      double? resPrice = double.tryParse(inputNewPrice);
      double? resWholesalePrice = double.tryParse(inputNewWholesalePrice);

      if ((resPrice == Null || resWholesalePrice == Null) | (resPrice! <= 0.0 || (resWholesalePrice! <= 0.0))) {
          ErrorView.DisplayErrorMessage(_errorMessageIncorrectInput);

          return false;
      }
      
      if ((resPrice as double) <= (resWholesalePrice as double)) {
          ErrorView.DisplayErrorMessage(_errorMessageIncorrectPrice);
          
          return false;
      }

      return true;
  }
}