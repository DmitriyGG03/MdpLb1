class Product {
  String name;
  double price;
  double wholesalePrice;
  int inStock;
  double wholesaleQuantity;

  Product(this.name, this.price, this.wholesalePrice, this.inStock,
      this.wholesaleQuantity);

  factory Product.fromJson(Map<String, Object?> jsonMap) {
    return Product(
        jsonMap["name"] as String,
        double.parse(jsonMap["price"] as String),
        double.parse(jsonMap["wholesalePrice"] as String),
        int.parse(jsonMap["inStock"] as String),
        double.parse(jsonMap["wholesaleQuantity"] as String));
  }

  Map toJson() => {
        "name": name,
        "price": price.toString(),
        "wholesalePrice": wholesalePrice.toString(),
        "inStock": inStock.toString(),
        "wholesaleQuantity": wholesaleQuantity.toString()
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Product &&
              runtimeType == other.runtimeType &&
              name == other.name &&
              price == other.price &&
              wholesalePrice == other.wholesalePrice &&
              inStock == other.inStock &&
              wholesaleQuantity == other.wholesaleQuantity;
}
