import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/categories/data/models/category.dart';
import 'package:ecommerce_app/core/error/failure.dart';

abstract class CategoryRepository2 {
    Future<Either<Failure, List<Category>>> getCategories();

}