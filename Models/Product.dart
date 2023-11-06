class Model {
  late String _name;
  late double _price;
  late double _wholesalePrice;
  late double _inStock;
  late double _wholesaleQuantity;

  Model(String name, double price, double wholesalePrice, double inStock, double wholesaleQuantity) {
      this._name = name;
      this._price = price;
      this._wholesalePrice = wholesalePrice;
      this._inStock = inStock;
      this._wholesaleQuantity = wholesaleQuantity;
  }

  void ChangePrice(double) {

  }

  void ChangeWholesalePrice() {

  }
}