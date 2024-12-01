class CartProductModel {
  String? productId, name, image, price;
  int? quantity;

  CartProductModel({
    this.name,
    this.image,
    this.price,
    this.quantity,
    this.productId,
  });

  CartProductModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    image = json['image'];
    price = json['price'];
    quantity = json['quantity'];
    productId = json['productId'];
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'image': image,
      'price': price,
      'quantity': quantity,
      'productId': productId
    };
  }
}
