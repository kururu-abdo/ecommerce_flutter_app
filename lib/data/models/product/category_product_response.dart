
import 'dart:convert';
import 'dart:developer';

import 'package:ecommerce_app/features/home/data/models/product.dart';
CategoryProductResponse categoryProductRepsoneFromJson(String str) =>
    CategoryProductResponse.fromJson(json.decode(str));

String categoryProductRepsoneToJson(CategoryProductResponse data) =>
    json.encode(data.toJson());
class CategoryProductResponse {
   List<ProductModel> products;

   CategoryProductResponse({
    required this.products ,
  });

  factory CategoryProductResponse.fromJson(Map<String, dynamic> json) {
   



    Iterable data = json['products'];
 
    return CategoryProductResponse(
        products:
        // List<ProductModel>.from(data)
        
         data.map(
          (item)=> ProductModel.fromJson( item)
        ).toList(),
      );
  }

  Map<String, dynamic> toJson() => {
        "products": products.map((product)=> product.toJson()).toList(),
      };
}
