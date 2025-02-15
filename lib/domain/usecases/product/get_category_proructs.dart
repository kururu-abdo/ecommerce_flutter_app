import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/usecase/usecase.dart';
import 'package:ecommerce_app/domain/repositories/product_repository2.dart';
import 'package:ecommerce_app/features/home/data/models/product.dart';
import 'package:ecommerce_app/repositories/product_repo.dart';

import '../../../core/error/failure.dart';
import '../../entities/user/user.dart';

class GetCategoryProructs implements UseCase<List<ProductModel>, int> {
  final ProductRepository2 repository;
  GetCategoryProructs(this.repository);

  @override
  Future<Either<Failure, List<ProductModel>>> call(int category) async {
    return await repository.getCategoryProducts(category);
    
  }
}

