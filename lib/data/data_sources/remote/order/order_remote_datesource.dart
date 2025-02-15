import 'dart:convert';
import 'dart:developer';

import 'package:ecommerce_app/core/constants/api.dart';
import 'package:ecommerce_app/core/error/exceptions.dart';
import 'package:ecommerce_app/core/error/failure.dart';
import 'package:ecommerce_app/data/models/order/order_response.dart';
import 'package:ecommerce_app/data/models/product/category_product_response.dart';
import 'package:ecommerce_app/main.dart';
import 'package:ecommerce_app/utils/Strings.dart';
import 'package:http/http.dart';

abstract class OrderRemoteDatesource {
  Future<OrderResponse> getMyOrders([int status=0]);
  // Future<AuthenticationResponseModel> signUp(SignUpParams params);
}
class OrderRemoteDatesourceImpl implements OrderRemoteDatesource {

 final Client client;
  OrderRemoteDatesourceImpl({required this.client});


  @override
 Future<OrderResponse> getMyOrders([int status=0])async {
try {
  log(globalSharedPrefs.getString(Strings.USER_TOKEN).toString());
  final response =
        await client.get(Uri.parse('${Strings.BASE_URL}/orders?status=$status'),
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer ${globalSharedPrefs.getString(Strings.USER_TOKEN)}',
            },
           );
          
    if (response.statusCode == 200) {
   
  
      return orderRepsoneFromJson(response.body);
    } else if (response.statusCode == 400 || response.statusCode == 401) {
      throw CredentialFailure();
    } else {
      throw ServerException();
    }
} catch (e) {

  log(e.toString());
  rethrow;
}
  }
  
}