import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/categories/data/models/category.dart';
import 'package:ecommerce_app/core/error/failure.dart';
import 'package:ecommerce_app/repositories/category_repo.dart';

import '../../../core/usecase/usecase.dart';

class GetHomeCategoriesUseCase implements UseCase<List<Category>,
 NoParams> {
   final CategoryRepository categoryRepository;
  GetHomeCategoriesUseCase(this.categoryRepository);
  
  @override
  Future<Either<Failure, List<Category>>> call(NoParams params) {

    return   categoryRepository.getCategories2();
  
  
  }

  
}