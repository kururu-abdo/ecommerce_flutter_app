import 'package:ecommerce_app/categories/data/models/category.dart';
import 'package:ecommerce_app/features/home/data/models/address_model.dart';
import 'package:ecommerce_app/features/home/data/models/product.dart';
import 'package:equatable/equatable.dart';

enum CategoriesViewState { initial, loading, success, failure;

String get message {
    switch (this) {
      case CategoriesViewState.success:
        return 'Operation completed successfully!';
      case CategoriesViewState.failure:
        return 'Operation failed. Please try again.';
      case CategoriesViewState.loading:
        return 'Loading... Please wait.';
      default:
        return 'Unknown status.';
    }
  }
 }


final class CategoriesState extends Equatable {
  const CategoriesState({
    this.status = CategoriesViewState.initial,
    this.categories = const [],
 
  });

  final List<Category> categories;
final CategoriesViewState? status;


  CategoriesState copyWith({
    CategoriesViewState Function()? status,
    List<Category> Function()? categories,
   

  }) {
    return CategoriesState(
      status: status!=null? status():this.status,
      categories: categories!=null?categories(): this.categories,
    
      
    );
  }

  @override
  List<Object?> get props => [
        status,
        status,
      
      ];
}