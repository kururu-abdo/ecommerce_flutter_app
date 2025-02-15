import 'dart:convert';
import 'dart:developer';

import 'package:ecommerce_app/features/home/data/models/address_model.dart';
import 'package:ecommerce_app/login/data/models/user.dart';
import 'package:ecommerce_app/shared/result.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// import '../models/user.dart';
import '../providers/http_client_provider.dart';
import 'package:http/http.dart' as http;
class AddressRepository {
  final HttpClient httpClient;

  AddressRepository({required this.httpClient});

 Future<List<AddressModel>> getAddresses()async{
  try {
    var myAddresses =await  httpClient.get('/address');
  log(myAddresses.runtimeType.toString());
    if (myAddresses is Success<dynamic, Exception>) {
      
   Iterable data = 
   jsonDecode(( 
    (myAddresses as Success<dynamic, Exception>).value as http.Response).body);

   return data.map(
(json)=> AddressModel.fromJson(json)

   ).toList();

    }
return [];

  } catch (e) {
    rethrow;
  }
 }
  Future<String?> addAdress(

    String country , String city , String street , 
    String zip ,  String fullName , String phone , 

    double lat ,double lon
  ) async {
    final response = await httpClient.post('/address',
     {
      'name':fullName,
      'country':country ,
      'city':city , 
      'street':street , 
      'zip_code':zip , 
    'phone':phone, 
    'lat':lat , 
    'lon':lon
      
      });
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
final adressRepositoryProvider = Provider((ref) {
  final httpClient = ref.watch(httpClientProvider);
  return AddressRepository(httpClient: httpClient);
});
