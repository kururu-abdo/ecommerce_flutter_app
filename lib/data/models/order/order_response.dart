
import 'dart:convert';
import 'dart:developer';

import 'package:ecommerce_app/data/models/order/order_model.dart';
import 'package:ecommerce_app/features/home/data/models/product.dart';
OrderResponse orderRepsoneFromJson(String str) =>
    OrderResponse.fromJson(json.decode(str));

String orderRepsoneToJson(OrderResponse data) =>
    json.encode(data.toJson());
class OrderResponse {
   List<OrderModel> orders;

   OrderResponse({
    required this.orders ,
  });

  factory OrderResponse.fromJson(Map<String, dynamic> json) {
   



    Iterable data = json['orders'];
 
    return OrderResponse(
        orders:
        // List<ProductModel>.from(data)
        
         data.map(
          (item)=> OrderModel.fromJson( item)
        ).toList(),
      );
  }

  Map<String, dynamic> toJson() => {
        "orders": orders.map((product)=> product.toJson()).toList(),
      };
}
