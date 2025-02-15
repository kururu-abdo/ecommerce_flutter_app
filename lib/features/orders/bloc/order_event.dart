import 'package:ecommerce_app/categories/data/models/category.dart';
import 'package:ecommerce_app/data/models/order/order_model.dart';
import 'package:ecommerce_app/features/home/data/models/address_model.dart';
import 'package:ecommerce_app/features/home/data/models/product.dart';
import 'package:equatable/equatable.dart';

sealed class OrderEvent extends Equatable {
  const OrderEvent();

  @override
  List<Object> get props => [];
}

final class LoadMyOrdersEvent extends OrderEvent {
  const LoadMyOrdersEvent({
    required this.orders,
    required this.isCompleted,
    this.status
  });
  final int? status;
  final List<OrderModel> orders;
  final bool isCompleted;

  @override
  List<Object> get props => [orders, isCompleted , status!];
}

