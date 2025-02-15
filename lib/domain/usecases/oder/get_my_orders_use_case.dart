import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/error/failure.dart';
import 'package:ecommerce_app/core/usecase/usecase.dart';
import 'package:ecommerce_app/data/models/order/order_model.dart';
import 'package:ecommerce_app/domain/repositories/order_respository.dart';

class GetMyOrdersUseCase implements UseCase<List<OrderModel>, NoParams> {
  final OrderRespository repository;
  GetMyOrdersUseCase(this.repository);

  @override
  Future<Either<Failure, List<OrderModel>>> call(NoParams params) async {
    return await repository.getMyOrders();
    
  }
}