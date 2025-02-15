import 'package:ecommerce_app/di/di.dart';
import 'package:ecommerce_app/domain/usecases/home/get_home_categories_usecase.dart';
import 'package:ecommerce_app/features/home/bloc/home_bloc.dart';
import 'package:ecommerce_app/repositories/category_repo.dart';

void registerHomeFeature(){


    sl.registerFactory(
        () => HomeBloc(categoryRepository:sl()),
  );
  // Use cases
  sl.registerLazySingleton(() => GetHomeCategoriesUseCase(sl()));
  
  // Repository
  sl.registerLazySingleton<CategoryRepository>(
        () => CategoryRepository(
      httpClient: sl()
    ),
  );
  // Data sources
  // sl.registerLazySingleton<CartRemoteDataSource>(
  //       () => CartRemoteDataSourceSourceImpl(client: sl()),
  // );
  // sl.registerLazySingleton<CartLocalDataSource>(
  //       () => CartLocalDataSourceImpl(sharedPreferences: sl()),
  // );

}