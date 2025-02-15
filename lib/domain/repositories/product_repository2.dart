import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/error/failure.dart';
import 'package:ecommerce_app/features/home/data/models/product.dart';
import 'package:ecommerce_app/product/data/models/product_details_model.dart';

abstract class ProductRepository2 {
  Future<Either<Failure, List<ProductModel>>> getCategoryProducts(int category);
    Future<Either<Failure, ProductDetailsModel>> getProductDetails(int product);

  
  // Future<Either<Failure, User>> signUp(SignUpParams params);
  // Future<Either<Failure, NoParams>> signOut();
  // Future<Either<Failure, User>> getCachedUser();
}
