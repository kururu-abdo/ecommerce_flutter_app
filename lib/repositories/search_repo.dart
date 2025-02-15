import 'dart:async';

import 'package:ecommerce_app/providers/http_client_provider.dart';

class Product {
  final String id;
  final String name;
  final double price;

  Product({required this.id, required this.name, required this.price});
}

class SearchService {
  static Future<List<String>> getSuggestions(String query) async {
    await Future.delayed(Duration(milliseconds: 500)); // Simulate network delay
    return [
      'Laptop',
      'Phone',
      'Tablet',
      'Headphones',
      'Camera',
    ].where((suggestion) => suggestion.toLowerCase().contains(query.toLowerCase())).toList();
  }

  static Future<List<Product>> searchProducts(String query) async {
    await Future.delayed(Duration(milliseconds: 500)); // Simulate network delay
    return [
      Product(id: '1', name: 'Laptop', price: 1200.0),
      Product(id: '2', name: 'Phone', price: 800.0),
      Product(id: '3', name: 'Tablet', price: 600.0),
    ].where((product) => product.name.toLowerCase().contains(query.toLowerCase())).toList();
  }
}
class SearchRepository  {
  final HttpClient? httpClient;
  SearchRepository(this.httpClient);


  
}