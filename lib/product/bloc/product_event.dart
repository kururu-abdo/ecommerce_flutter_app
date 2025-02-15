import 'package:ecommerce_app/categories/data/models/category.dart';
import 'package:ecommerce_app/features/home/data/models/address_model.dart';
import 'package:ecommerce_app/features/home/data/models/product.dart';
import 'package:equatable/equatable.dart';

sealed class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}
final class LoadProductDetailsEvent extends ProductEvent {
  const LoadProductDetailsEvent({
    required this.productModel,
    required this.isCompleted,
  });

  final  ProductModel productModel;
  final bool isCompleted;

  @override
  List<Object> get props => [productModel , isCompleted];
}
final class RefreshProductDetailsEvent extends ProductEvent {
  const RefreshProductDetailsEvent({
    required this.productModel,
    required this.isCompleted,
  });

  final  ProductModel productModel;
  final bool isCompleted;

  @override
  List<Object> get props => [productModel , isCompleted];
}


final class LoadCategoryProductEvent extends ProductEvent {
  const LoadCategoryProductEvent({
    required this.categoryId,
    required this.isCompleted,
  });

  final  int categoryId;
  final bool isCompleted;

  @override
  List<Object> get props => [categoryId , isCompleted];
}

