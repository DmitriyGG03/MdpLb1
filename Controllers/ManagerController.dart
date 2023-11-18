import '../Models/Domain/Product.dart';
import '../Models/Manager.dart';
import '../Views/DisplayMessageView.dart';
import '../Views/Helper.dart';
import '../Views/ManagerView.dart';
import 'FileController.dart';

class ManagerController {
  String get _errorMessageIncorrectInput =>
      "Entered number is incorrect! Please, try again!";

  String get _errorMessageWasNotEntered =>
      "You must enter the number! Please, try again!";

  String get _errorMessageIncorrectPrice =>
      "The entered price must be higher than the wholesale price! Please, try again!";

  late final Manager manager;
  late final ManagerView managerView;
  late final FileController _fileController;

  ManagerController(this.manager, this._fileController) : super() {
    managerView = new ManagerView(this);

    SelectActionNumber();
  }

  void SelectActionNumber() {
    managerView.GetActionMenuNumber();
  }

  void ActionHandler(String inputActionNumber) {
    int? res = int.tryParse(inputActionNumber);

    if ((res == Null) | (res! < 1) | (res > 2)) {
      DisplayMessageView.DisplayErrorMessage(_errorMessageIncorrectInput);
    }

    if (res == 1) {
      ChangeProductPrice();
    }

    if (res == 2) {
      Helper.CloseApplication();
    }
  }

  void ChangeProductPrice() {
    //Find product by name
    Product product = FindProductByName();

    double prPrice, prWholesalePrice;
    (prPrice, prWholesalePrice) =
        GetNewPriceFromUser(product.price, product.wholesalePrice);

    _fileController.ChangeProductPrice(product.name, prPrice, prWholesalePrice);
  }

  Product FindProductByName() {
    return managerView.GetProductByName(_fileController.GetProducts());
  }

  bool ProductSelectionHandler(String inputActionNumber, int length) {
    int? res = int.tryParse(inputActionNumber);

    if (res == null) {
      DisplayMessageView.DisplayErrorMessage(_errorMessageWasNotEntered);

      return false;
    }

    if (res < 1 || res > length + 1) {      
      DisplayMessageView.DisplayErrorMessage(_errorMessageIncorrectInput);

      return false;
    }

    return true;
  }

  (double, double) GetNewPriceFromUser(double price, double wholesalePrice) {
    return managerView.GetNewPrice(price, wholesalePrice);
  }

  bool NewPriceHandler(String inputNewPrice, String inputNewWholesalePrice) {
    double? resPrice = double.tryParse(inputNewPrice);
    double? resWholesalePrice = double.tryParse(inputNewWholesalePrice);

    if (resPrice == null || resWholesalePrice == null) {
      DisplayMessageView.DisplayErrorMessage(_errorMessageWasNotEntered);

      return false;
    }
    
    if(resPrice <= 0.0 || resWholesalePrice <= 0.0) {
      DisplayMessageView.DisplayErrorMessage(_errorMessageIncorrectInput);

      return false;
    }      

    if (resPrice <= resWholesalePrice) {
      DisplayMessageView.DisplayErrorMessage(_errorMessageIncorrectPrice);

      return false;
    }

    return true;
  }
}
