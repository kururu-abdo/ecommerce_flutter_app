import 'package:ecommerce_app/categories/data/models/category.dart';
import 'package:ecommerce_app/data/models/order/order_model.dart';
import 'package:ecommerce_app/features/home/data/models/address_model.dart';
import 'package:ecommerce_app/features/home/data/models/product.dart';
import 'package:equatable/equatable.dart';

sealed class CategoriesEvent extends Equatable {
  const CategoriesEvent();

  @override
  List<Object> get props => [];
}

final class LoadCategoriesEvent extends CategoriesEvent {
  const LoadCategoriesEvent({
    required this.categories,
    required this.isCompleted,
    this.status
  });
  final int? status;
  final List<Category> categories;
  final bool isCompleted;

  @override
  List<Object> get props => [categories, isCompleted , status!];
}

