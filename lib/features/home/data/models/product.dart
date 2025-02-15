import 'dart:developer';

class ProductModel {
  String? id;
  String? arName;
  String? enName;
  double? price;
  String? desc;
  String? imageUrl;
  int? inventory;
  bool? isFavourite;

  ProductModel(
      {this.id,
      this.arName,
      this.enName,
      this.price,
      this.desc,
      this.imageUrl,
      this.inventory,
      this.isFavourite});

  ProductModel.fromJson(Map<String, dynamic> json) {
  

    id = json['id'];
    arName = json['ar_name'];
    enName = json['en_name'];
    price = json['price'];
    desc = json['desc'];
       

    imageUrl = json['image_url'];
     
    inventory = json['inventory'];
    
    isFavourite = json['is_favourite'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['ar_name'] = arName;
    data['en_name'] = enName;
    data['price'] = price;
    data['desc'] = desc;
    data['image_url'] = imageUrl;
    data['inventory'] = inventory;
    data['is_favourite'] = isFavourite;
    return data;
  }
}
