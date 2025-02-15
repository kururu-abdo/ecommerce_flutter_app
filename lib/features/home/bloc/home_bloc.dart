
import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/categories/data/models/category.dart';
import 'package:ecommerce_app/features/home/bloc/home_event.dart';
import 'package:ecommerce_app/features/home/bloc/home_state.dart';
import 'package:ecommerce_app/repositories/category_repo.dart';

class HomeBloc  extends Bloc<HomeEvent,HomeViewState> {
    HomeBloc({
      required CategoryRepository categoryRepository
    })
    :_categoryRepo = categoryRepository,
        super(const HomeViewState()) {
    on<LoadHomeCategoriesEvent>(_onLoadCategories);
   
  }
final CategoryRepository _categoryRepo;

    Future<void> _onLoadCategories(
    LoadHomeCategoriesEvent event,
    Emitter<HomeViewState> emit,
  ) async {
    emit(state.copyWith(status: () => HomeViewStatus.loading));
try {
  var categories = await _categoryRepo.getCategories();
emit(state.copyWith(
  status:()=> HomeViewStatus.success , 
categories: ()=> categories!
));
} catch (e) {
  emit(state.copyWith(
  status:()=> HomeViewStatus.failure
  )
  );
}


  
  }
}