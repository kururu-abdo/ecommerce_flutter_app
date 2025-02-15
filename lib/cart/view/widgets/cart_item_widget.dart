import 'package:ecommerce_app/cart/view/data/models/cart.dart';
import 'package:ecommerce_app/utils/Strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
final cartQuantityProvider = Provider<int>((ref ) {
  return 0;
});
class CartItemWidget extends ConsumerWidget {
  final CartModel item;
  final Function(int, bool) onUpdateQuantity;
  final Function(int) onRemove;

  const CartItemWidget({
    super.key,
    required this.item,
    required this.onUpdateQuantity,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
 var cartQuantityValue=  ref.watch(cartQuantityProvider);
    return 
    
             Card(color: Colors.white,
               margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
               child: Row(
                 children: [
                   // Product Image
                   Container(
                     width: 100,
                     height: 100,
                     decoration: BoxDecoration(
                       image: DecorationImage(
                         image:
                         
                         item.imageUrl==null
                         ||
                                                  item.imageUrl!.isEmpty

                         ?
const AssetImage("assets/images/logo.png"):
                          NetworkImage(
                          
                          "${Strings.BASE_URL}${item.imageUrl}"),
                         fit: BoxFit.cover,
                       ),
                       borderRadius: BorderRadius.circular(10),
                     ),
                   ),
                   Expanded(
                     child: Padding(
                       padding: const EdgeInsets.symmetric(horizontal: 10),
                       child: Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           Text(
                           item.arName.toString(),
                             style: const TextStyle(
                               fontSize: 16,
                               fontWeight: FontWeight.bold,
                             ),
                           ),
                           const SizedBox(height: 8),
                           Text(
                             "\$${item.price!.toStringAsFixed(2)}",
                             style: const TextStyle(
                               fontSize: 14,
                               color: Colors.green,
                             ),
                           ),
                           const SizedBox(height: 8),
                           Row(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             children: [
                               // Quantity Controls
                               Row(
                                 children: [
                                   IconButton(
                                     onPressed: () =>
                                         onUpdateQuantity(item.productId!, false),
                                     icon: const Icon(Icons.remove_circle_outline),
                                   ),
                                   Text(
                                     "${item.quantity}",
                                     style: const TextStyle(fontSize: 16),
                                   ),
                                   IconButton(
                                     onPressed: () =>
                                         onUpdateQuantity(item.productId!, true),
                                     icon: const Icon(Icons.add_circle_outline),
                                   ),
                                 ],
                               ),
                               // Remove Button
                               IconButton(
                                 onPressed: () =>
                                     onRemove(item.productId!),
                                 icon: const Icon(Icons.delete, color: Colors.red),
                               ),
                             ],
                           ),
                         ],
                       ),
                     ),
                   ),
                 ],
               ),
             );
                         
  }
}
