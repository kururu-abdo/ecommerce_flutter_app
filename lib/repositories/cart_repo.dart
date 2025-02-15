import 'dart:convert';
import 'dart:developer';

import 'package:ecommerce_app/cart/view/data/models/cart.dart';
import 'package:ecommerce_app/categories/data/models/category.dart';
import 'package:ecommerce_app/providers/http_client_provider.dart';
import 'package:ecommerce_app/shared/result.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
class CartRepository {
  final HttpClient httpClient;

  CartRepository({required this.httpClient});


Future<List<CartModel>?> getCart() async {
    final response = await httpClient.get('/cart',
    
    );

    if (response is Success) {
      log((response as Success).value.body);
      Iterable data = jsonDecode(((response as Success).value ).body);
       log(data.length.toString());
      return data.map((json)=>CartModel.fromJson(json)).toList();
    } 
    
   
    else {

      log("List Exception");
      throw Exception('Login failed');
    }
  }

  Future<void> updateQuanity(int product,int quantity)async{
 final response = await httpClient.patch('/cart/update',
 {
'id':product, 
'quantity':quantity
 }
    
    );

    if (response is Success) {
           final data = jsonDecode(((response as Success).value as http.Response).body);

       log(data.toString());
      // return data.map((json)=>Category.fromJson(json)).toList();
    } else {
      log("ERROR");
      throw Exception('Login failed');
    }
  }
  
  
  Future<void> addToCart(int product,int quantity)async{
 final response = await httpClient.post('/cart/add',
 {
'product_id':product, 
'quantity':quantity
 }
    
    );

    if (response is Success) {
      final data = jsonDecode(((response as Success).value as http.Response).body);
       log(data.toString());
      // return data.map((json)=>Category.fromJson(json)).toList();
    } else { 
      log("ERROR");
      throw Exception('Login failed');
    }
  }
  
  
  
  Future<void> delete(int product)async{
final response = await httpClient.delete('/categories/remove',
 {
'id':product, 
 }
    
    );

    if (response is Success) {
      final data = jsonDecode(((response as Success).value as http.Response).body);
       log(data.toString());
      // return data.map((json)=>Category.fromJson(json)).toList();
    } else {
      log("ERROR");
      throw Exception('Login failed');
    }
  }
}

// Provider for AuthRepository, depending on the HttpClient provider
final cartRepositoryProvider = Provider((ref) {
  final httpClient = ref.watch(httpClientProvider);
  return CartRepository(httpClient: httpClient);
});
