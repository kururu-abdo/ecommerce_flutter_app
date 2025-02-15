
import 'package:ecommerce_app/providers/http_client_provider.dart';
import 'package:ecommerce_app/repositories/product_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'login_test.mocks.dart';

@GenerateMocks([AuthRepository, HttpClient])
void main() { 
late MockAuthRepository mockAuthRepository;
late MockHttpClient httpClient;
  setUp((){
    httpClient = MockHttpClient(
      
    );
mockAuthRepository = MockAuthRepository(
  
);



    
  });

  //after each test to clean resources
tearDown((){

});
group('login user', (){

test('check user login with provided data', ()async{
var user= await mockAuthRepository.login('abdo@gmail.com', "mmmmmmmm");
//arragne


//act


//verify

expect(user,isNotNull);

});

});

}