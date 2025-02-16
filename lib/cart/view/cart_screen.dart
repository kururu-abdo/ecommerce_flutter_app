import 'dart:convert';

import 'package:ecommerce_app/cart/view/data/models/cart.dart';
import 'package:ecommerce_app/cart/view/data/models/cart_update_model.dart';
import 'package:ecommerce_app/cart/view/widgets/cart_item_widget.dart';
import 'package:ecommerce_app/checkout/views/checkout.dart';
import 'package:ecommerce_app/providers/cart_provider.dart';
import 'package:ecommerce_app/providers/http_client_provider.dart';
import 'package:ecommerce_app/shared/widget/main_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skeletonizer/skeletonizer.dart';

final dataProvider = FutureProvider.autoDispose.family<List<CartModel>, String>((ref, endpoint) async {
  final crtProvider = ref.read(cartProvider.notifier);
 var data =await crtProvider.getCartFromApi();
  return data;
});
final cartItemsProvider = Provider<List<CartModel>>((ref){
final crtProvider = ref.watch(cartProvider);
return crtProvider;
});
final cartDataUpdateProvider = FutureProvider.family<void, CartUpdateModel>((ref, product) async {
  final crtProvider =ref.read(cartProvider.notifier);

 crtProvider.updateCart(product);
});

final totalProvider = Provider<double>((ref) {
    var cart = ref.watch(cartProvider);
    // cartProvider.
   return cart.fold(
    0.0,
    (total, item) => total + (item.price! * item.quantity!),
    );

});

class CartScreen extends ConsumerStatefulWidget {
  const CartScreen({super.key});

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends ConsumerState<CartScreen> {
  // Example cart data
  List<Map<String, dynamic>> cartItems = [
    {
      "id": 1,
      "name": "Smartphone",
      "price": 699.0,
      "quantity": 1,
      "image": "https://via.placeholder.com/150",
    },
    {
      "id": 2,
      "name": "Laptop",
      "price": 999.0,
      "quantity": 1,
      "image": "https://via.placeholder.com/150",
    },
    {
      "id": 3,
      "name": "Headphones",
      "price": 199.0,
      "quantity": 1,
      "image": "https://via.placeholder.com/150",
    },
  ];

  // Calculate the total price
  double getTotalPrice() {
    return cartItems.fold(
      0.0,
      (sum, item) => sum + (item["price"] * item["quantity"]),
    );
  }

  // Update the quantity of a product
  void updateQuantity(int productId, bool increase) {

     var cartProviderAsync = ref.watch(dataProvider(''));
      // cartProviderAsync.increase(productId,);
    setState(() {
      final product =
          cartItems.firstWhere((item) => item["id"] == productId);
      if (increase) {
        product["quantity"]++;
      } else {
        if (product["quantity"] > 1) {
          product["quantity"]--;
        }
      }
    });
  }

  // Remove a product from the cart
  void removeFromCart(int productId) {
      var cartProviderAsync = ref.watch(dataProvider(''));
      // cartProviderAsync.remoteProduct(productId);
    setState(() {
      cartItems.removeWhere((item) => item["id"] == productId);
    });
  }

  @override
  Widget build(BuildContext context) {
            var cartProviderAsync = ref.watch(dataProvider('')); // Example endpoint
    var totalPrice = ref.watch(totalProvider);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(backgroundColor: Colors.white,
        title: const Text("Shopping Cart"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: 
            
             cartProviderAsync.when(
          data: (data) => 
          
          
           RefreshIndicator(
            onRefresh: ()async{
                 ref.refresh(dataProvider(''));
            },
             child: ListView.builder(
               // scrollDirection: Axis.horizontal,
               itemCount: data.length,
               itemBuilder: (context, index) {
                 final item = data[index];
                 return 
             CartItemWidget(item: item, 
             onUpdateQuantity: (id,isIncrease){ 
              int productQty = item.quantity!;
              ref.read(cartDataUpdateProvider(CartUpdateModel(product: id, quantity: 
              
              isIncrease?
              productQty+1: productQty-1
              )));
   ref.refresh(dataProvider(''));
             }, onRemove: (id){

             });
               },
             ),
           )
          
          
          ,
          loading: () =>  SizedBox(
                height: 60,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 8,
                  itemBuilder: (context, index) {
                   
                    return 
                    Skeletonizer(
                      enabled: true,
                      child: 
                    
                Card(
                  margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  child: Row(
                    children: [
                      // Product Image
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "  ",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              const Text(
                                "\$ ",
                                style: TextStyle(
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
                                        onPressed:(){},
                                        icon: const Icon(Icons.remove_circle_outline),
                                      ),
                                      const Text(
                                        "    ",
                                        style: TextStyle(fontSize: 16),
                                      ),
                                      IconButton(
                                        onPressed:(){},
                                        icon: const Icon(Icons.add_circle_outline),
                                      ),
                                    ],
                                  ),
                                  // Remove Button
                                  IconButton(
                                    onPressed:(){},
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
                )
            
                    
                    );
                  },
                ),
              ),
          error: (error, stack) =>  
          Center(
            child: IconButton(onPressed: (){
             
          ref.refresh(dataProvider(''));
            }, icon: const Icon(Icons.refresh)),
          )
                  ),
            
            
            
            // ListView.builder(
            //   itemCount: cartItems.length,
            //   itemBuilder: (context, index) {
            //     final item = cartItems[index];
            //     return 

            //     Card(
            //       margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            //       child: Row(
            //         children: [
            //           // Product Image
            //           Container(
            //             width: 100,
            //             height: 100,
            //             decoration: BoxDecoration(
            //               image: DecorationImage(
            //                 image: NetworkImage(item["image"]),
            //                 fit: BoxFit.cover,
            //               ),
            //               borderRadius: BorderRadius.circular(10),
            //             ),
            //           ),
            //           Expanded(
            //             child: Padding(
            //               padding: const EdgeInsets.symmetric(horizontal: 10),
            //               child: Column(
            //                 crossAxisAlignment: CrossAxisAlignment.start,
            //                 children: [
            //                   Text(
            //                     item["name"],
            //                     style: const TextStyle(
            //                       fontSize: 16,
            //                       fontWeight: FontWeight.bold,
            //                     ),
            //                   ),
            //                   const SizedBox(height: 8),
            //                   Text(
            //                     "\$${item["price"].toStringAsFixed(2)}",
            //                     style: const TextStyle(
            //                       fontSize: 14,
            //                       color: Colors.green,
            //                     ),
            //                   ),
            //                   const SizedBox(height: 8),
            //                   Row(
            //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //                     children: [
            //                       // Quantity Controls
            //                       Row(
            //                         children: [
            //                           IconButton(
            //                             onPressed: () =>
            //                                 updateQuantity(item["id"], false),
            //                             icon: const Icon(Icons.remove_circle_outline),
            //                           ),
            //                           Text(
            //                             "${item["quantity"]}",
            //                             style: const TextStyle(fontSize: 16),
            //                           ),
            //                           IconButton(
            //                             onPressed: () =>
            //                                 updateQuantity(item["id"], true),
            //                             icon: const Icon(Icons.add_circle_outline),
            //                           ),
            //                         ],
            //                       ),
            //                       // Remove Button
            //                       IconButton(
            //                         onPressed: () =>
            //                             removeFromCart(item["id"]),
            //                         icon: const Icon(Icons.delete, color: Colors.red),
            //                       ),
            //                     ],
            //                   ),
            //                 ],
            //               ),
            //             ),
            //           ),
            //         ],
            //       ),
            //     );
            
            //   },
            // ),
          ),
          // Total Price and Checkout Button
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Total:",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "\$${totalPrice.toStringAsFixed(2)}",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                MainButton(text:  "Proceed to Checkout",
                
                 onPressed: (){

                   Navigator.of(context).push(

MaterialPageRoute(builder: (_)=> CheckoutScreen(totalCost:
 getTotalPrice(

 ), 
 
 items: ref.watch(cartItemsProvider).map((item)=>item.toJson()).toList(),
 ))
                    );
                 })

                 /*
                ElevatedButton(
                  onPressed: () {
                    // Add checkout logic

                    Navigator.of(context).push(

MaterialPageRoute(builder: (_)=> CheckoutScreen(totalCost: getTotalPrice()))
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: const Text(
                    "Proceed to Checkout",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              */
              ],
            ),
          ),
        ],
      ),
    );
  }
}
