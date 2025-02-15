import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/error/failure.dart';
import 'package:ecommerce_app/core/networkchecker/network_info.dart';
import 'package:ecommerce_app/data/data_sources/remote/product/product_remote_data_source.dart';
import 'package:ecommerce_app/data/models/product/category_product_response.dart';
import 'package:ecommerce_app/data/models/product/product_details_response.dart';
import 'package:ecommerce_app/domain/repositories/product_repository2.dart';
import 'package:ecommerce_app/features/home/data/models/product.dart';
import 'package:ecommerce_app/product/data/models/product_details_model.dart';
typedef _CategoryPoructResponse = Future<CategoryProductResponse> Function();
typedef _ProductDetailsResponse = Future<ProductDetailsResponse> Function();

class ProductRepositoryImpl implements ProductRepository2 {
  final ProductRemoteDataSource? remoteDataSource;
  final NetworkInfo? networkInfo;
  ProductRepositoryImpl({this.networkInfo, required this.remoteDataSource});



  @override
  Future<Either<Failure, List<ProductModel>>> getCategoryProducts(int category) async{

  try {
      
        if (await networkInfo!.isConnected) {
              var products = await remoteDataSource!.getCategoryProducts(category);



      try {
        // final remoteResponse = await getDataSource();
        // localDataSource.saveToken(remoteResponse.token);
        // localDataSource.saveUser(remoteResponse.user);
        return Right(products.products);
      } on Failure catch (failure) {
        return Left(failure);
      }
    } else {
          log("EVENT TIGGEREd is not connected");

      return Left(NetworkFailure());
    }
  } catch (e) {
       log("EVENT TIGGEREd $e");
     return Left(NetworkFailure());
  }
  return   _convertCateegoryProdcutResponse(() {
       log("EVENT TIGGEREd  get to the api");
      return  remoteDataSource!.getCategoryProducts(category);
    });
  }

@override
  Future<Either<Failure, ProductDetailsModel>> getProductDetails(int product)async {
  
  try {
      
        if (await networkInfo!.isConnected) {
              var products = await remoteDataSource!.getProductDetails(product);



      try {
        // final remoteResponse = await getDataSource();
        // localDataSource.saveToken(remoteResponse.token);
        // localDataSource.saveUser(remoteResponse.user);
        return Right(products.product);
      } on Failure catch (failure) {
        return Left(failure);
      }
    } else {
          log("EVENT TIGGEREd is not connected");

      return Left(NetworkFailure());
    }
  } catch (e) {
       log("EVENT TIGGEREd $e");
     return Left(NetworkFailure());
  }
  }

















  
    Future<Either<Failure, List<ProductModel>>> _convertCateegoryProdcutResponse(
      _CategoryPoructResponse getDataSource,
      ) async {
    if (await networkInfo!.isConnected) {
          log("EVENT TIGGEREd is connected");

      try {
        final remoteResponse = await getDataSource();
        // localDataSource.saveToken(remoteResponse.token);
        // localDataSource.saveUser(remoteResponse.user);
        return Right(remoteResponse.products);
      } on Failure catch (failure) {
        return Left(failure);
      }
    } else {
          log("EVENT TIGGEREd is not connected");

      return Left(NetworkFailure());
    }
  }

  

}