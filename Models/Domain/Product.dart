class Product {
  String name;
  double price;
  double wholesalePrice;
  double inStock;
  double wholesaleQuantity;

  Product(this.name, this.price, this.wholesalePrice, this.inStock, this.wholesaleQuantity);

  factory Product.fromJson(Map<String, Object?> jsonMap){
    return Product(jsonMap["name"] as String, 
        jsonMap["price"] as double, 
        jsonMap["wholesalePrice"] as double, 
        jsonMap["inStock"] as double, 
        jsonMap["wholesaleQuantity"] as double);
  }

  Map toJson() => { "name": name, "price": price, "wholesalePrice": wholesalePrice, "inStock": inStock, "wholesaleQuantity": wholesaleQuantity };
}