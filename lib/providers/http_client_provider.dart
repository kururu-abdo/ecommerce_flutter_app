import 'dart:convert';
import 'dart:developer';

import 'package:ecommerce_app/main.dart';
import 'package:ecommerce_app/providers/user_provider.dart';
import 'package:ecommerce_app/shared/result.dart';
import 'package:ecommerce_app/utils/Strings.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

class HttpClient {
  final String baseUrl;
  final http.Client client;
   final Ref? ref;
  final String? authToken;
  HttpClient({this.ref,   required this.baseUrl, http.Client? client ,this.authToken,})
      : client = client ?? http.Client();

  Uri uri(String path) => Uri.parse('$baseUrl$path');
Map<String, String>? headers ={'Content-Type': 'application/json'};
  Future<Result<http.Response ,Exception>> get(String path) async {
    final url = uri(path);
if(authToken!=null){
      headers!['Authorization'] = 'Bearer $authToken';
    }
log(authToken.toString());
     return _request("GET", 
    url, 
    headers: headers , 
    body: null
    );
   
  }

  Future<Result<http.Response ,Exception>> post(String path, 
  Map<String, dynamic>? body) async {
    
    final url = uri(path);
    if(authToken!=null){
      headers!['Authorization'] = 'Bearer $authToken';
    }
     return _request("POST", 
    url, 
    headers: headers , 
    body: body
    );
   
  }
    Future<Result<http.Response ,Exception>> delete(String path, Map<String, dynamic>? body) async {
    final url = uri(path);
    if(authToken!=null){
      headers!['Authorization'] = 'Bearer $authToken';
    }
     return _request("DELETE", 
    url, 
    headers: headers , 
    body: body
    );
   
  }
   Future<Result<http.Response ,Exception>> patch(String path, Map<String, dynamic>? body) async {
    final url = uri(path);
    if(authToken!=null){
      headers!['Authorization'] = 'Bearer $authToken';
    }
    return _request("PATCH", 
    url, 
    headers: headers , 
    body: body
    );
   
  }

Future<Result<http.Response ,Exception>> _request(String method, Uri url,
      {Map<String, String>? headers, Object? body}) async {
  try {
      final combinedHeaders = {
      'Content-Type': 'application/json',
      if (authToken != null) 'Authorization': 'Bearer $authToken',
      ...?headers,
    };

    final request = http.Request(method, url)
      ..headers.addAll(combinedHeaders)
      ..body = body != null ? json.encode(body) : "";

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    // Check for token expiration
    if (response.statusCode == 401) {
      // Handle token expiration and sign out
      _handleTokenExpiration();
      return Failure(Exception('token expired'));
    }
    

    return Success(response);
  } catch ( e) {
    return Failure(Exception(e.toString()));
  }
  }

  void _handleTokenExpiration() {
    final tokenProvider = ref!.read(userProvider.notifier);
    tokenProvider.logout();
  }







}

// Provider for HttpClient
final httpClientProvider = Provider((ref) {
   
//  tokenProvider.getAuthToken();
String? token = globalSharedPrefs.getString(Strings.USER_TOKEN);
  return HttpClient(ref: ref,
    baseUrl: Strings.BASE_URL, authToken: token );
});
