import 'dart:convert';

import 'package:ecommerce_app/categories/data/models/category.dart';


CategoryListResponseModel categoryListResponseModelFromJson(String str) =>
    CategoryListResponseModel.fromJson(json.decode(str));

String categoryListResponseModelToJson(CategoryListResponseModel data) =>
    json.encode(data.toJson());

class CategoryListResponseModel {
  final List<Category> categories;

  const CategoryListResponseModel({
    required this.categories,
  });

  factory CategoryListResponseModel.fromJson(Map<String, dynamic> json) {
     Iterable
  data = json['categories'];
   return   CategoryListResponseModel(
        categories: data.map((category)=> Category.fromJson(category)).toList()
      );
}
  Map<String, dynamic> toJson() => {
        "categories": categories.map((categoryObject)=> categoryObject).toList(),
      };
}
