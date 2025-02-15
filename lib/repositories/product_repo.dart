import 'dart:convert';
import 'dart:developer';

import 'package:ecommerce_app/login/data/models/user.dart';
import 'package:ecommerce_app/product/data/models/product_details_model.dart';
import 'package:ecommerce_app/shared/result.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
// import '../models/user.dart';
import '../providers/http_client_provider.dart';

class ProductRepository {
  final HttpClient httpClient;

  ProductRepository({required this.httpClient});

  Future<ProductDetailsModel?> getProductDetails(int product) async {
    final response = await httpClient.get('/products/details/$product');

    if (response is Success) {
      final data = jsonDecode(((response as Success).value as http.Response).body);
      return ProductDetailsModel.fromJson(data);
    } else {

      // log("${response.statusCode}");
      throw Exception('Error');
    }
  }
 
 
 
  Future<String?> signup(String name,String email, String password) async {
    final response = await httpClient.post('/auth/register',
     {
      'name':name,
      'email': email, 'password': password});
    

    final result = switch (response) {
     Success(value: final response2) => response2.body , 
     Failure(exception: final exception2) => exception2.toString()
    , 
    _=> null
    };
return result;
    if (response is Success) {
        final data = jsonDecode(((response as Success).value as http.Response).body);

      return data['message'];
    } else {
      log("ERROR");
      throw Exception('Login failed');
    }
  }
}

// Provider for AuthRepository, depending on the HttpClient provider
final productRepositoryProvider = Provider((ref) {
  final httpClient = ref.watch(httpClientProvider);
  return ProductRepository(httpClient: httpClient);
});
