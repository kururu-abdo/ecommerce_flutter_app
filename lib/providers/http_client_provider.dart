import 'dart:convert';

import 'package:ecommerce_app/providers/user_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

class HttpClient {
  final String baseUrl;
  final http.Client client;
  final String? authToken;
  HttpClient( {required this.baseUrl, http.Client? client ,this.authToken,})
      : client = client ?? http.Client();

  Uri uri(String path) => Uri.parse('$baseUrl$path');
Map<String, String>? headers ={'Content-Type': 'application/json'};
  Future<http.Response> get(String path) async {
    final url = uri(path);
if(authToken!=null){
      headers!['Authorization'] = 'Bearer $authToken';
    }
    return client.get(url, headers: headers);
  }

  Future<http.Response> post(String path, Map<String, dynamic>? body) async {
    final url = uri(path);
    if(authToken!=null){
      headers!['Authorization'] = 'Bearer $authToken';
    }
    return client.post(
      url,
      headers: headers,
      body: body != null ? jsonEncode(body) : null,
    );
  }
}

// Provider for HttpClient
final httpClientProvider = Provider((ref) {
   final tokenProvider = ref.read(userProvider.notifier);
//  tokenProvider.getAuthToken();
  return HttpClient(baseUrl: 'http://192.168.43.183:8080', authToken: tokenProvider.getAuthToken() );
});
