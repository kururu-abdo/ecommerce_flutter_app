import 'dart:convert';

import 'package:ecommerce_app/providers/http_client_provider.dart';
import 'package:ecommerce_app/shared/result.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OrderRepository {
  final HttpClient httpClient;

  OrderRepository({required this.httpClient});

 Future<void> sendOrder(
  
  List<Map<String ,dynamic>>  items , 
  int addressId, 
 double totalAmount , 
 double delivery, 
 double tax, 
 double discount, 
 double grandTotal
 )async{

  try {
    httpClient.post('/order/create', {
      'payment_method':3, 
      'address_id':addressId,
      'total_amount':totalAmount , 
      'delivery':delivery , 
      'tax':tax , 
      'discount':discount , 
      'grand_total':grandTotal, 
      'itmes':items


    });
  } catch (e) {
    
  }
 }
Future getOrders()async{
  var response = await httpClient.get("/orders");
   final result = switch (response) {
     Success(value: final response2) => response2.body , 
     Failure(exception: final exception2) => "failure: $exception2"
    , 
    _=> null
    };
return result;
}
  Future<String?> makeOrder(
    String addressId,
    List<Map<String,dynamic>> items,
    double totalAmount, 
   String note
   ) async {
    final response = await httpClient.post('/orders/create',
  
       {
      // 'total_amount':totalAmount,
      'items':items,
       'note': note, 
       'address_id': addressId
       
       }
    );
  final result = switch (response) {
     Success(value: final response2) => response2.body , 
     Failure(exception: final exception2) => "failure: $exception2"
    , 
    _=> null
    };
return result;

  }



}

// Provider for AuthRepository, depending on the HttpClient provider
final orderRepositoryProvider = Provider((ref) {
  final httpClient = ref.watch(httpClientProvider);
  return OrderRepository(httpClient: httpClient);
});
