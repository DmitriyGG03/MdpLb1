class Product {
  late final String _name;
  late double _price;
  late double _wholesalePrice;
  late double _inStock;
  late double _wholesaleQuantity;

  Product(String name, double price, double wholesalePrice, double inStock, double wholesaleQuantity) {
      this._name = name;
      this._price = price;
      this._wholesalePrice = wholesalePrice;
      this._inStock = inStock;
      this._wholesaleQuantity = wholesaleQuantity;
  }

  void ChangePrice(double newPrice) {
    _price = newPrice;
  }

  void ChangeWholesalePrice(double newWholesalePrice) {
      _wholesalePrice = newWholesalePrice;
  }
}