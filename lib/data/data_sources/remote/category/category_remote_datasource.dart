import 'dart:convert';

import 'package:ecommerce_app/core/constants/api.dart';
import 'package:ecommerce_app/data/models/category/category_list_response.dart';
import 'package:ecommerce_app/data/models/user/user_auth_response.dart';
import 'package:ecommerce_app/domain/usecases/user/sign_in_user.dart';
import 'package:http/http.dart' as http;

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failure.dart';

abstract class CategoryRemoteDatasource {
  Future<CategoryListResponseModel> getCategories();
  // Future<AuthenticationResponseModel> signUp(SignUpParams params);
}

class CategoryRemoteDatasourceIml implements CategoryRemoteDatasource {
  final http.Client client;
  CategoryRemoteDatasourceIml({required this.client});

  @override
  Future<CategoryListResponseModel> getCategories() async {
    final response =
        await client.get(Uri.parse('$baseUrl/categories'),
           );
    if (response.statusCode == 200) {
      return categoryListResponseModelFromJson(response.body);
    } else if (response.statusCode == 400 || response.statusCode == 401) {
      throw TimeoutFailure();
    } else {
      throw ServerException();
    }
  }

  // @override
  // Future<AuthenticationResponseModel> signUp(SignUpParams params) async {
  //   final response =
  //       await client.post(Uri.parse('$baseUrl/authentication/local/sign-up'),
  //           headers: {
  //             'Content-Type': 'application/json',
  //           },
  //           body: json.encode({
  //             'firstName': params.firstName,
  //             'lastName': params.lastName,
  //             'email': params.email,
  //             'password': params.password,
  //           }));
  //   if (response.statusCode == 201) {
  //     return authenticationResponseModelFromJson(response.body);
  //   } else if (response.statusCode == 400 || response.statusCode == 401) {
  //     throw CredentialFailure();
  //   } else {
  //     throw ServerException();
  //   }
  // }



}
