import 'dart:convert';
import 'dart:developer';

import 'package:ecommerce_app/login/data/models/user.dart';
import 'package:ecommerce_app/shared/result.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// import '../models/user.dart';
import '../providers/http_client_provider.dart';
import 'package:http/http.dart' as http;
class AuthRepository {
  final HttpClient httpClient;

  AuthRepository({required this.httpClient});

  Future<User?> login(String email, String password) async {
    final response = await httpClient.post('/auth/login', {'email': email, 'password': password});
  
    if (response  is Success) {
      final data = jsonDecode(((response as Success).value as http.Response).body);
      return User.fromJson(data);
    } else {
      log("ERROR");
      throw Exception('Login failed');
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
final authRepositoryProvider = Provider((ref) {
  final httpClient = ref.watch(httpClientProvider);
  return AuthRepository(httpClient: httpClient);
});
