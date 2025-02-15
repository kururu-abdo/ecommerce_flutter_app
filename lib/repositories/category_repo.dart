import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/categories/data/models/category.dart';
import 'package:ecommerce_app/core/error/failure.dart' as ff;
import 'package:ecommerce_app/providers/http_client_provider.dart';
import 'package:ecommerce_app/shared/result.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
class CategoryRepository {
  final HttpClient httpClient;

  CategoryRepository({required this.httpClient});


Future<List<Category>?> getCategories() async {
    final response = await httpClient.get('/categories',
    );

    if (response is Success) {
           Iterable data = jsonDecode(((response as Success).value as http.Response).body);

       log(data.length.toString());
      return data.map((json)=>Category.fromJson(json)).toList();
    } else {
      log("ERROR");
      throw Exception('Fetch data failed');
    }
  }
 
 
Future<Either<ff.Failure,List<Category>>> getCategories2() async {
    final response = await httpClient.get('/categories',
    );

    if (response is Success) {
           Iterable data = jsonDecode(((response as Success).value as http.Response).body);

       log(data.length.toString());
      return
      Right(   data.map((json)=>Category.fromJson(json)).toList())
    ;
    } else {
      log("ERROR");
      return Left(ff.ExceptionFailure());
    }
  }
 
}

// Provider for AuthRepository, depending on the HttpClient provider
final categoryRepositoryProvider = Provider((ref) {
  final httpClient = ref.watch(httpClientProvider);
  return CategoryRepository(httpClient: httpClient);
});
