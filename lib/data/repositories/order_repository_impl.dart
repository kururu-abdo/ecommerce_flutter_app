import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/error/failure.dart';
import 'package:ecommerce_app/core/networkchecker/network_info.dart';
import 'package:ecommerce_app/data/data_sources/remote/order/order_remote_datesource.dart';
import 'package:ecommerce_app/data/models/order/order_model.dart';
import 'package:ecommerce_app/data/models/order/order_response.dart';
import 'package:ecommerce_app/domain/repositories/order_respository.dart';

class OrderRepositoryImpl implements OrderRespository {

   final OrderRemoteDatesource? remoteDataSource;
  final NetworkInfo? networkInfo;

  OrderRepositoryImpl({required this.remoteDataSource, required this.networkInfo});

  @override
  Future<Either<Failure, List<OrderModel>>> getMyOrders([int status=0])async {
    return   _convertResponseToListOfOrders(() {
      return  remoteDataSource!.getMyOrders(status);
    });
  }

  Future<Either<Failure, List<OrderModel>>> _convertResponseToListOfOrders(Future<OrderResponse> Function() remoteDataSource)async {
  if (await networkInfo!.isConnected) {

      try {
        final remoteResponse = await remoteDataSource();
        
        return Right(remoteResponse.orders);
      } on Failure catch (failure) {
        return Left(failure);
      }
    } else {

      return Left(NetworkFailure());
    }
  }
  
}