import 'package:ecommerce_app/data/data_sources/remote/product/product_remote_data_source.dart';
import 'package:ecommerce_app/data/repositories/product_repository_impl.dart';
import 'package:ecommerce_app/di/di.dart';
import 'package:ecommerce_app/domain/repositories/product_repository2.dart';
import 'package:ecommerce_app/domain/usecases/product/get_category_proructs.dart';
import 'package:ecommerce_app/product/bloc/product_bloc.dart';

void registerproductFeature(){

//bloc
 sl.registerFactory(
        () => ProductBloc(productRepo:sl()),
  );


  // Use cases
  sl.registerLazySingleton(() => GetCategoryProructs(sl()));

 // Repository
  sl.registerLazySingleton<ProductRepository2>(
        () => ProductRepositoryImpl(
     remoteDataSource: sl(), 
     networkInfo: sl()
    ),
  );

  // Data sources
  sl.registerLazySingleton<ProductRemoteDataSource>(
        () => ProductRemoteDataSourceImpl(client: sl()),
  );
}