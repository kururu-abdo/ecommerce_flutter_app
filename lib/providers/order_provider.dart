import 'package:ecommerce_app/cart/view/data/models/cart.dart';
import 'package:ecommerce_app/repositories/order_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OrderProvider extends StateNotifier<List> {

 OrderProvider( this.orderRepository):super([]);
    final OrderRepository orderRepository;


    Future getOrders()async{
      var orders = await  orderRepository.getOrders();

      state = orders;
    }
 Future<String?> makeOrder(
    String addressId,
    List<Map<String,dynamic>> items,
    double totalAmount, 
   String note
   ) async {
try {
  var result=await orderRepository.makeOrder(addressId, items, totalAmount, note);

return result;
} catch (e) {
 throw e;
}
   }

}


final orderProvider = StateNotifierProvider<OrderProvider, List>((ref) {
  var repo =  ref.watch(orderRepositoryProvider);
  return OrderProvider(repo);
});
