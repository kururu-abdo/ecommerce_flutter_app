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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product_id'] = this.productId;
    data['ar_name'] = this.arName;
    data['en_name'] = this.enName;
    data['image_url'] = this.imageUrl;
    data['price'] = this.price;
    data['quantity'] = this.quantity;
    return data;
  }
}
