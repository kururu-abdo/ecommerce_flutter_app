import 'dart:developer';

import 'package:ecommerce_app/features/home/data/models/address_model.dart';
import 'package:ecommerce_app/main.dart';
import 'package:ecommerce_app/repositories/address_repo.dart';
import 'package:ecommerce_app/utils/Strings.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../repositories/auth_repo.dart';
class AuthViewModel{
  bool isLoading=false;
}

// Provider for AuthRepository
// final authRepositoryProvider = Provider((ref) => AuthRepository());

// StateNotifier for managing authentication state
class AddressState extends StateNotifier<bool> {
  final AddressRepository addressRepository;

  AddressState(this.addressRepository) : super(false);
    // state=false;
    
 
 Future<String?> addAddress(
    String country , String city , String street , 
    String zip ,  String fullName , String phone
    ,
    double lat ,double lon
    ) async {
    try {
             state= true;

      final user = await addressRepository.addAdress(country, city, street, zip, fullName, phone
      ,
      lat ,lon
      );

             state= false;

      if (user != null) {
        // state = user;
       

        return user;
      } else {
        return 'Registeration Failed';
      }
    } catch (e) {
             state= false;

      return 'Login failed: ${e.toString()}';
    }
  }


Future<List<AddressModel>> getAddresses()async{
  try {
    var myAddresses =await addressRepository.getAddresses();
    
return myAddresses;
  } catch (e) {
    log(e.toString());
    return [];
  }
}



  void logout() {
    state = false;
  }
}

// Provider for AuthState
// final authProvider = StateNotifierProvider<AuthState, User?>((ref) {
//   final authRepository = ref.watch(authRepositoryProvider);
//   return AuthState(authRepository);
// });
// Provider for AuthStateNotifier
final addressesProvider = StateNotifierProvider<AddressState,bool>((ref) {
  final addessRepository = ref.watch(adressRepositoryProvider);
  return AddressState(addessRepository);
});