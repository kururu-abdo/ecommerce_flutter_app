
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/categories/bloc/categories_event.dart';
import 'package:ecommerce_app/categories/bloc/categories_state.dart';
import 'package:ecommerce_app/categories/data/models/category.dart';
import 'package:ecommerce_app/domain/repositories/product_repository2.dart';
import 'package:ecommerce_app/features/home/bloc/home_event.dart';
import 'package:ecommerce_app/features/home/bloc/home_state.dart';
import 'package:ecommerce_app/product/bloc/product_event.dart';
import 'package:ecommerce_app/product/bloc/product_state.dart';
import 'package:ecommerce_app/repositories/category_repo.dart';

class CategoriesBloc  extends Bloc<CategoriesEvent,CategoriesState> {
    CategoriesBloc({
      required CategoryRepository categoryRepository
    })
    :_categoryRepository = categoryRepository,
        super(const CategoriesState()) {
    on<LoadCategoriesEvent>(_onLoadCategories);
  }
final CategoryRepository _categoryRepository;


   
   
    Future<void> _onLoadCategories(
    LoadCategoriesEvent event,
    Emitter<CategoriesState> emit,
  ) async {
    emit(state.copyWith(status: () => CategoriesViewState.loading));
 

try {
  var result = await _categoryRepository.getCategories2();
         log("EVENT TIGGEREd  ${result.runtimeType}");
result.fold(
        (failure) =>
        emit(state.copyWith(
  status:()=> CategoriesViewState.failure , 
categories: ()=>   []
)
        ),
        (categories) =>emit(state.copyWith(
  status:()=> CategoriesViewState.success , 
  
categories: ()=> categories
)),
      );


} catch (e) {
  emit(state.copyWith(
  status:()=> CategoriesViewState.failure
  )
  );
}


  
  }
}