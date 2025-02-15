
import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/categories/data/models/category.dart';
import 'package:ecommerce_app/domain/repositories/order_respository.dart';
import 'package:ecommerce_app/features/home/bloc/home_event.dart';
import 'package:ecommerce_app/features/home/bloc/home_state.dart';
import 'package:ecommerce_app/features/orders/bloc/order_event.dart';
import 'package:ecommerce_app/features/orders/bloc/order_state.dart';
import 'package:ecommerce_app/repositories/category_repo.dart';

class OrderBloc  extends Bloc<OrderEvent,OrderState> {
    OrderBloc({
      required OrderRespository orderRepsoitory
    })
    :_orderRepository = orderRepsoitory,
        super(const OrderState()) {
    on<LoadMyOrdersEvent>(_onLoadMyOrders);
   
  }
final OrderRespository _orderRepository;

    Future<void> _onLoadMyOrders(
    LoadMyOrdersEvent event,
    Emitter<OrderState> emit,
  ) async {
    emit(state.copyWith(status: () => OrderViewStatus.loading));
 

try {
  var result = await _orderRepository.getMyOrders(
    event.status!
  );
 
result.fold(
        (failure) =>
        emit(state.copyWith(
  status:()=> OrderViewStatus.failure , 
orders: ()=>   []
)
        ),
        (orders) =>emit(state.copyWith(
  status:()=> OrderViewStatus.success , 
  
orders: ()=> orders
)),
      );


} catch (e) {
  emit(state.copyWith(
  status:()=> OrderViewStatus.failure
  )
  );
}



  
  }
}