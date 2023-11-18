import '../Models/Cart.dart';
import '../Models/CartItem.dart';
import '../Models/Customer.dart';
import '../Models/Domain/Product.dart';
import '../Views/CustomerView.dart';
import '../Views/DisplayMessageView.dart';
import '../Views/Helper.dart';
import 'FileController.dart';

class CustomerController {
  String get _errorMessageIncorrectInput =>
      "Entered number is incorrect! Please, try again!";

  String get _errorMessageWasNotEntered =>
      "You must enter the number! Please, try again!";

  String get _errorMessageCartIsEmpty =>
      "Cart is empty! You must add products to cart!";

  String get _errorMessageMoneyNotEnough =>
      "There is not enough money in your account to complete the transaction! Please refill your account and try again!";

  late final Customer customer;
  late final CustomerView customerView;
  late final FileController _fileController;

  Cart cart = new Cart();

  CustomerController(this.customer, this._fileController) {
    customerView = new CustomerView(this);

    SelectActionNumber();
  }

  void SelectActionNumber() {
    customerView.GetActionMenuNumber(cart);
  }

  void ActionHandler(String inputActionNumber) {
    int? res = int.tryParse(inputActionNumber);

    if (res == null) {
      DisplayMessageView.DisplayErrorMessage(_errorMessageWasNotEntered);
    }

    switch (res) {
      case 1:
        _AddProductToCart();
        break;
      case 2:
        if (cart.CartItems.length == 0) {
          DisplayMessageView.DisplayErrorMessage(_errorMessageCartIsEmpty);
          break;
        }
        _BuyProductsInCart();
        break;
      case 3:
        Helper.CloseApplication();
        break;
      default:
        DisplayMessageView.DisplayErrorMessage(_errorMessageIncorrectInput);
        break;
    }
  }

  void _AddProductToCart() {
    Product selectedProduct =
        customerView.SelectProduct(_fileController.GetProducts());

    int quantity = customerView.SelectProductQuantity(selectedProduct);

    CartItem? existCartItem = null;

    if (!cart.CartItems.isEmpty) {
      for (CartItem cartItem in cart.CartItems) {
        if (cartItem.product == selectedProduct) {
          existCartItem = cartItem;
        }
      }
    }

    if (existCartItem != null) {
      existCartItem.quantity += quantity;
    } else {
      cart.CartItems.add(new CartItem(selectedProduct, quantity));
    }

    DisplayMessageView.DisplaySuccessMessage(
        "Products have been successfully added!");
  }

  bool IsNumberInDiapason(String inputActionNumber, int maxValue) {
    int? res = int.tryParse(inputActionNumber);

    if (res == null) {
      DisplayMessageView.DisplayErrorMessage(_errorMessageWasNotEntered);

      return false;
    }

    if (res < 1 || res > maxValue) {
      DisplayMessageView.DisplayErrorMessage(_errorMessageIncorrectInput);

      return false;
    }

    return true;
  }

  void _BuyProductsInCart() {
    double cartTotalPrice = cart.TotalPrice;

    if (cartTotalPrice > customer.accountBalance) {
      DisplayMessageView.DisplayErrorMessage(_errorMessageMoneyNotEnough);
    }

    if (!customerView.OperationConfirmationRequest(cartTotalPrice)) return;

    customer.accountBalance -= cartTotalPrice;

    cart.CartItems = [];

    DisplayMessageView.DisplaySuccessMessage(
        "\$${cartTotalPrice} worth of items have been successfully "
        "purchased and shipped to your address free of charge. Thank you for shopping with us!");
  }
}
