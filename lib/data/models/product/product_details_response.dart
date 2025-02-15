
import 'dart:convert';
import 'dart:developer';

import 'package:ecommerce_app/features/home/data/models/product.dart';
import 'package:ecommerce_app/product/data/models/product_details_model.dart';
ProductDetailsResponse productDetailsRepsoneFromJson(String str) =>
    ProductDetailsResponse.fromJson(json.decode(str));

String productDetailsRepsoneToJson(ProductDetailsResponse data) =>
    json.encode(data.toJson());
class ProductDetailsResponse {
   ProductDetailsModel product;

   ProductDetailsResponse({
    required this.product ,
  });

  factory ProductDetailsResponse.fromJson(Map<String, dynamic> json) {
   



    Iterable data = json['products'];
 
    return ProductDetailsResponse(
        product:
        // List<ProductModel>.from(data)
        
         json['product']
      );
  }

  Map<String, dynamic> toJson() => {
        "products": product.toJson(),
      };
}
