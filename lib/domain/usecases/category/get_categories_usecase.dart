import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/categories/data/models/category.dart';
import 'package:ecommerce_app/core/error/failure.dart';
import 'package:ecommerce_app/core/usecase/usecase.dart';
import 'package:ecommerce_app/domain/repositories/category_repository2.dart';

class GetCategoriesUsecase implements UseCase<List<Category>, NoParams> {
  final CategoryRepository2 repository;
  GetCategoriesUsecase(this.repository);

  @override
  Future<Either<Failure, List<Category>>> call(NoParams parmas) async {
    return await repository.getCategories();
    
  }
}

