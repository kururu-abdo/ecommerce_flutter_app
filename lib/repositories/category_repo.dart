import 'dart:convert';
import 'dart:developer';

import 'package:ecommerce_app/categories/data/models/category.dart';
import 'package:ecommerce_app/providers/http_client_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CategoryRepository {
  final HttpClient httpClient;

  CategoryRepository({required this.httpClient});


Future<List<Category>?> getCategories() async {
    final response = await httpClient.get('/categories',
    );

    if (response.statusCode == 200) {
      Iterable data = jsonDecode(response.body);
       log(data.length.toString());
      return data.map((json)=>Category.fromJson(json)).toList();
    } else {
      log("ERROR");
      throw Exception('Fetch data failed');
    }
  }
 
 
}

// Provider for AuthRepository, depending on the HttpClient provider
final categoryRepositoryProvider = Provider((ref) {
  final httpClient = ref.watch(httpClientProvider);
  return CategoryRepository(httpClient: httpClient);
});
