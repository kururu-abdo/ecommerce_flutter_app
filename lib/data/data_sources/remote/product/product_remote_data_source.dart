import 'dart:convert';
import 'dart:developer';

import 'package:ecommerce_app/core/constants/api.dart';
import 'package:ecommerce_app/core/error/exceptions.dart';
import 'package:ecommerce_app/core/error/failure.dart';
import 'package:ecommerce_app/data/models/product/category_product_response.dart';
import 'package:ecommerce_app/data/models/product/product_details_response.dart';
import 'package:ecommerce_app/utils/Strings.dart';
import 'package:http/http.dart';

abstract class ProductRemoteDataSource {
  Future<CategoryProductResponse> getCategoryProducts(int category);
    Future<ProductDetailsResponse> getProductDetails(int product);

  // Future<AuthenticationResponseModel> signUp(SignUpParams params);
}
class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {

 final Client client;
  ProductRemoteDataSourceImpl({required this.client});


  @override
  Future<CategoryProductResponse> getCategoryProducts(int category)async {
try {
  final response =
        await client.get(Uri.parse('${Strings.BASE_URL}/categories/$category'),
            // headers: {
            //   'Content-Type': 'application/json',
            // },
           );
          
    if (response.statusCode == 200) {
   
  
      return categoryProductRepsoneFromJson(response.body);
    } else if (response.statusCode == 400 || response.statusCode == 401) {
      throw CredentialFailure();
    } else {
      throw ServerException();
    }
} catch (e) {
  rethrow;
}
  }
  
  @override
  Future<ProductDetailsResponse> getProductDetails(int product) async{
   try {
  final response =
        await client.get(Uri.parse('${Strings.BASE_URL}/products/$product'),
            // headers: {
            //   'Content-Type': 'application/json',
            // },
           );
          
    if (response.statusCode == 200) {
   
  
      return productDetailsRepsoneFromJson(response.body);
    } else if (response.statusCode == 400 || response.statusCode == 401) {
      throw CredentialFailure();
    } else {
      throw ServerException();
    }
} catch (e) {
  rethrow;
}
  }
  
}