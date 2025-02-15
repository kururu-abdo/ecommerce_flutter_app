import 'package:ecommerce_app/data/data_sources/remote/order/order_remote_datesource.dart';
import 'package:ecommerce_app/data/repositories/order_repository_impl.dart';
import 'package:ecommerce_app/di/di.dart';
import 'package:ecommerce_app/domain/repositories/order_respository.dart';
import 'package:ecommerce_app/domain/usecases/oder/get_my_orders_use_case.dart';
import 'package:ecommerce_app/features/orders/bloc/order_bloc.dart';

void registerOrderFeature(){


//bloc
  sl.registerFactory(
        () => OrderBloc(orderRepsoitory:sl()),
  );

 // Use cases
  sl.registerLazySingleton(() => GetMyOrdersUseCase(sl()));

// Repository
  sl.registerLazySingleton<OrderRespository>(
        () => OrderRepositoryImpl(
     remoteDataSource: sl(), 
     networkInfo: sl()
    ),
  );

 // Data sources
  sl.registerLazySingleton<OrderRemoteDatesource>(
        () => OrderRemoteDatesourceImpl(client: sl()),
  );
}