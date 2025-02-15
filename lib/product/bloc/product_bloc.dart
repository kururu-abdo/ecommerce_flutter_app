
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/categories/data/models/category.dart';
import 'package:ecommerce_app/domain/repositories/product_repository2.dart';
import 'package:ecommerce_app/features/home/bloc/home_event.dart';
import 'package:ecommerce_app/features/home/bloc/home_state.dart';
import 'package:ecommerce_app/product/bloc/product_event.dart';
import 'package:ecommerce_app/product/bloc/product_state.dart';
import 'package:ecommerce_app/repositories/category_repo.dart';

class ProductBloc  extends Bloc<ProductEvent,ProductState> {
    ProductBloc({
      required ProductRepository2 productRepo
    })
    :_productRepository = productRepo,
        super(const ProductState()) {
    on<LoadCategoryProductEvent>(_onLoadCategoryProducts);
    on<LoadProductDetailsEvent>(_onLoadProductDetails);
  }
final ProductRepository2 _productRepository;




 Future<void> _onLoadProductDetails(
    LoadProductDetailsEvent event,
    Emitter<ProductState> emit,
  ) async {
 emit(state.copyWith(status: () => ProductViewState.loading));
try {
//   var result = await _productRepository.getCategoryProducts(
//     event.categoryId
//   );
//          log("EVENT TIGGEREd  ${result.runtimeType}");
// result.fold(
//         (failure) =>
//         emit(state.copyWith(
//   status:()=> ProductViewState.failure , 
// products: ()=>   []
// )
//         ),
//         (products) =>emit(state.copyWith(
//   status:()=> ProductViewState.success , 
  
// products: ()=> products
// )),
//       );


} catch (e) {
  emit(state.copyWith(
  status:()=> ProductViewState.failure
  )
  );
}

  }
    Future<void> _onLoadCategoryProducts(
    LoadCategoryProductEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(state.copyWith(status: () => ProductViewState.loading));
 

try {
  var result = await _productRepository.getCategoryProducts(
    event.categoryId
  );
         log("EVENT TIGGEREd  ${result.runtimeType}");
result.fold(
        (failure) =>
        emit(state.copyWith(
  status:()=> ProductViewState.failure , 
products: ()=>   []
)
        ),
        (products) =>emit(state.copyWith(
  status:()=> ProductViewState.success , 
  
products: ()=> products
)),
      );


} catch (e) {
  emit(state.copyWith(
  status:()=> ProductViewState.failure
  )
  );
}


  
  }
}