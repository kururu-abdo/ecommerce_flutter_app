import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/error/failure.dart';
import 'package:ecommerce_app/data/models/order/order_model.dart';

abstract class OrderRespository {
    Future<Either<Failure, List<OrderModel>>> getMyOrders([int status=0]);

}