import 'dart:convert';
import 'dart:developer';

import 'package:ecommerce_app/login/data/models/user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// import '../models/user.dart';
import '../providers/http_client_provider.dart';

class AuthRepository {
  final HttpClient httpClient;

  AuthRepository({required this.httpClient});

  Future<User?> login(String email, String password) async {
    final response = await httpClient.post('/auth/login', {'email': email, 'password': password});

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
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

    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = jsonDecode(response.body);
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
