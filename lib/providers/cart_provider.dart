
import 'dart:async';
import 'dart:developer';

import 'package:ecommerce_app/cart/view/data/models/cart.dart';
import 'package:ecommerce_app/cart/view/data/models/cart_update_model.dart';
import 'package:ecommerce_app/providers/http_client_provider.dart';
import 'package:ecommerce_app/repositories/cart_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class CartProvider extends StateNotifier<List<CartModel>> {
  CartProvider(this.cartRepository):super([]);
    final CartRepository cartRepository;
 Timer? _debounce;
  List<Map<String ,dynamic>>  items =[];
Future<List<CartModel>> getCartFromApi()async{
try {
  var cartList = await cartRepository.getCart();
  state = cartList!;
  items = cartList.map((cartData)=>{ 
'product_id':cartData.productId, 
'quantity':cartData.quantity, 
'price':cartData.price
  }).toList();
  
return state;
} catch (e) {
  log(e.toString());
  state =[];
  return state;
}
}
  Future<void> updateCart(CartUpdateModel model)async{
try {

 // Debounce the update API call
    // if (_debounce?.isActive ?? false) _debounce?.cancel();
    // _debounce = Timer(const Duration(milliseconds: 250), ()async {

  // call api here
   await cartRepository.updateQuanity(model.product, model.quantity);

    // });

} catch (e) {
}
}


  Future<void> addToCart(CartUpdateModel model)async{
try {

 // Debounce the update API call
    // if (_debounce?.isActive ?? false) _debounce?.cancel();
    // _debounce = Timer(const Duration(milliseconds: 250), ()async {

  // call api here
   await cartRepository.addToCart(model.product, model.quantity);

    // });

} catch (e) {
}
}


}

final cartProvider = StateNotifierProvider<CartProvider, List<CartModel>>((ref)  {
  final cartRepo = ref.read(cartRepositoryProvider);

  return CartProvider(cartRepo);
});