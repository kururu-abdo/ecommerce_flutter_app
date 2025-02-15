import 'package:ecommerce_app/categories/bloc/categories_bloc.dart';
import 'package:ecommerce_app/data/data_sources/remote/category/category_remote_datasource.dart';
import 'package:ecommerce_app/data/data_sources/remote/product/product_remote_data_source.dart';
import 'package:ecommerce_app/data/repositories/category_repository_impl.dart';
import 'package:ecommerce_app/data/repositories/product_repository_impl.dart';
import 'package:ecommerce_app/di/di.dart';
import 'package:ecommerce_app/domain/repositories/category_repository2.dart';
import 'package:ecommerce_app/domain/repositories/product_repository2.dart';
import 'package:ecommerce_app/domain/usecases/category/get_categories_usecase.dart';
import 'package:ecommerce_app/domain/usecases/product/get_category_proructs.dart';
import 'package:ecommerce_app/product/bloc/product_bloc.dart';

void registerCategoryFeature(){

//bloc
 sl.registerFactory(
        () => CategoriesBloc(categoryRepository:sl()),
  );


  // Use cases
  sl.registerLazySingleton(() => GetCategoriesUsecase(sl()));

 // Repository
  sl.registerLazySingleton<CategoryRepository2>(
        () => CategoryRepositoryImpl(
    categoryRemoteDatasource: sl(), 
     networkInfo: sl()
    ),
  );

  // Data sources
  sl.registerLazySingleton<CategoryRemoteDatasource>(
        () => CategoryRemoteDatasourceIml(client: sl()),
  );
}