import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/categories/data/models/category.dart';
import 'package:ecommerce_app/core/error/failure.dart';
import 'package:ecommerce_app/core/networkchecker/network_info.dart';
import 'package:ecommerce_app/data/data_sources/remote/category/category_remote_datasource.dart';
import 'package:ecommerce_app/domain/repositories/category_repository2.dart';

class CategoryRepositoryImpl implements CategoryRepository2 {
  final CategoryRemoteDatasource? categoryRemoteDatasource;
  final NetworkInfo? networkInfo;

  CategoryRepositoryImpl({this.categoryRemoteDatasource, this.networkInfo});
  @override
  Future<Either<Failure, List<Category>>> getCategories() {
    // TODO: implement getCategories
    throw UnimplementedError();
  }
  
}