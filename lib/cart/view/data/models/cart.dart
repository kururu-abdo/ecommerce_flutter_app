class CartModel {
  String? id;
  int? productId;
  String? arName;
  String? enName;
  String? imageUrl;
  double? price;
  int? quantity;

  CartModel(
      {this.id,
      this.productId,
      this.arName,
      this.enName,
      this.imageUrl,
      this.price,
      this.quantity});

  CartModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    arName = json['ar_name'];
    enName = json['en_name'];
    imageUrl = json['image_url'];
    price = json['price'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['product_id'] = productId;
    data['ar_name'] = arName;
    data['en_name'] = enName;
    data['image_url'] = imageUrl;
    data['price'] = price;
    data['quantity'] = quantity;
    return data;
  }
}
