import 'dart:convert';

import 'package:ecommerce_app/core/constants/api.dart';
import 'package:ecommerce_app/data/models/user/user_auth_response.dart';
import 'package:ecommerce_app/domain/usecases/user/sign_in_user.dart';
import 'package:http/http.dart' as http;

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failure.dart';

abstract class UserRemoteDataSource {
  Future<AuthenticationResponseModel> signIn(SignInParams params);
  // Future<AuthenticationResponseModel> signUp(SignUpParams params);
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final http.Client client;
  UserRemoteDataSourceImpl({required this.client});

  @override
  Future<AuthenticationResponseModel> signIn(SignInParams params) async {
    final response =
        await client.post(Uri.parse('$baseUrl/authentication/local/sign-in'),
            headers: {
              'Content-Type': 'application/json',
            },
            body: json.encode({
              'identifier': params.username,
              'password': params.password,
            }));
    if (response.statusCode == 200) {
      return authenticationResponseModelFromJson(response.body);
    } else if (response.statusCode == 400 || response.statusCode == 401) {
      throw CredentialFailure();
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
