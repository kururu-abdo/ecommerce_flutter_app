import 'dart:convert';
import 'dart:developer';

import 'package:ecommerce_app/categories/data/models/category.dart';
import 'package:ecommerce_app/providers/http_client_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CartRepository {
  final HttpClient httpClient;

  CartRepository({required this.httpClient});


Future<List<Category>?> getCart() async {
    final response = await httpClient.get('/categories',
    
    );

    if (response.statusCode == 200) {
      Iterable data = jsonDecode(response.body);
       log(data.length.toString());
      return data.map((json)=>Category.fromJson(json)).toList();
    } else {
      log("ERROR");
      throw Exception('Login failed');
    }
  }
}