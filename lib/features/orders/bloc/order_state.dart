import 'package:ecommerce_app/categories/data/models/category.dart';
import 'package:ecommerce_app/data/models/order/order_model.dart';
import 'package:ecommerce_app/features/home/data/models/address_model.dart';
import 'package:ecommerce_app/features/home/data/models/product.dart';
import 'package:equatable/equatable.dart';

enum OrderViewStatus { initial, loading, success, failure(errorMsg: '') ; 
const OrderViewStatus({this.errorMsg});
final String? errorMsg;

 }


final class OrderState extends Equatable {
  const OrderState({
    this.status = OrderViewStatus.initial,
    this.orders = const [],
    this.topSales =const [], 
    this.addressModel
  });

  final List<OrderModel> orders;
    final List<ProductModel> topSales;
final AddressModel? addressModel;
final OrderViewStatus? status;


  OrderState copyWith({
    OrderViewStatus Function()? status,
    List<OrderModel> Function()? orders,
        List<ProductModel> Function()? topSales,

    AddressModel Function()? addressModel,

  }) {
    return OrderState(
      status: status!=null? status():this.status,
      orders: orders!=null?orders(): this.orders,
      topSales: topSales!=null?topSales(): this.topSales , 

      addressModel: addressModel!=null? addressModel():this.addressModel
      
    );
  }

  @override
  List<Object?> get props => [
        status,
        addressModel,
        orders,
        topSales,
      ];
}