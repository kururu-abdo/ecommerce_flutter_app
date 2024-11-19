import 'dart:developer';

import 'package:ecommerce_app/categories/data/models/category.dart';
import 'package:ecommerce_app/repositories/category_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CategoryState extends StateNotifier {
  final CategoryRepository categoryRepository;

  CategoryState(this.categoryRepository) : super(null);


var isLoading=false;
  Future<List<Category>?> getCategories() async {
    try {
      isLoading= true;
      final categories = await categoryRepository.getCategories();
            isLoading= false;

      return categories;
    } catch (e) {
      log(e.toString());
            isLoading= false;

      rethrow;
    }
  }

}

final categoryStateProvider = StateNotifierProvider<CategoryState,void>((ref) {
  final categoryRepository = ref.watch(categoryRepositoryProvider);
  return CategoryState(categoryRepository);
});