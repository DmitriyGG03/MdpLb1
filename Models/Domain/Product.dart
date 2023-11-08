class Product {
  String name;
  double price;
  double wholesalePrice;
  double inStock;
  double wholesaleQuantity;

  Product(this.name, this.price, this.wholesalePrice, this.inStock,
      this.wholesaleQuantity);

  factory Product.fromJson(Map<String, Object?> jsonMap) {
    return Product(
        jsonMap["name"] as String,
        double.parse(jsonMap["price"] as String),
        double.parse(jsonMap["wholesalePrice"] as String),
        double.parse(jsonMap["inStock"] as String),
        double.parse(jsonMap["wholesaleQuantity"] as String));
  }

  Map toJson() => {
        "name": name,
        "price": price.toString(),
        "wholesalePrice": wholesalePrice.toString(),
        "inStock": inStock.toString(),
        "wholesaleQuantity": wholesaleQuantity.toString()
      };
}
