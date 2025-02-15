import 'package:ecommerce_app/features/orders/bloc/order_bloc.dart';
import 'package:ecommerce_app/features/orders/bloc/order_event.dart';
import 'package:ecommerce_app/features/orders/bloc/order_state.dart';
import 'package:ecommerce_app/features/orders/views/widgets/order_status_widget.dart';
import 'package:ecommerce_app/product/bloc/product_bloc.dart';
import 'package:ecommerce_app/product/bloc/product_event.dart';
import 'package:ecommerce_app/product/bloc/product_state.dart';
import 'package:ecommerce_app/shared/widget/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen>
 {

   @override
  void initState() {
    // TODO: implement initState
    super.initState();
       context
        .read<OrderBloc>()
        .add(  LoadMyOrdersEvent(
         orders: [],
          isCompleted: false, 
          status: _selectedTab
        ));
  }

  int _selectedTab = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(),
body: SizedBox.expand(

  child: Column(
    children: [
SizedBox(width: MediaQuery.sizeOf(context).width,
child:  Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  crossAxisAlignment: CrossAxisAlignment.center,
  // spacing: 5,
  children: [
  
OrderStatusWidget(
  title: "Pending",
  index: 0, 
  selecedIndex: _selectedTab,
  onSelect: (index){
    _selectedTab=index;
    setState(() {
      
    });
     context
        .read<OrderBloc>()
        .add(  LoadMyOrdersEvent(
         orders: [],
          isCompleted: false, 
          status: _selectedTab
        ));
  },
), 
OrderStatusWidget(
  title: "Confirmed",
  index: 1, 
selecedIndex: _selectedTab,
  onSelect: (index){
    _selectedTab=index;
    setState(() {
      
    });
     context
        .read<OrderBloc>()
        .add(  LoadMyOrdersEvent(
         orders: [],
          isCompleted: false, 
          status: _selectedTab
        ));
  },
), 

OrderStatusWidget(
  title: "Shipping",
  index: 2, 
selecedIndex: _selectedTab,
  onSelect: (index){
    _selectedTab=index;
    setState(() {
      
    });
     context
        .read<OrderBloc>()
        .add(  LoadMyOrdersEvent(
         orders: [],
          isCompleted: false, 
          status: _selectedTab
        ));
  },
), 

OrderStatusWidget(
  title: "Delivered",
  index: 3, 
 selecedIndex: _selectedTab,
  onSelect: (index){
    _selectedTab=index;
    setState(() {
      
    });
     context
        .read<OrderBloc>()
        .add(  LoadMyOrdersEvent(
         orders: [],
          isCompleted: false, 
          status: _selectedTab
        ));
  },
), 



   
    
  ],
),
),

      Expanded(
        child: Padding(
          padding: const EdgeInsets.symmetric(
        
            horizontal: 20,  vertical: 25
          ),
          child: BlocBuilder<OrderBloc, OrderState>(
                                  builder: (context, state) {
          if (state.status== ProductViewState.loading) {
            return const Center(child: CircularProgressIndicator());
          }
          
          else if (state.status== ProductViewState.loading) {
            return const Center(child: Text("Error"));
          }else{
          return ListView.builder(
            itemCount: state.orders.length,
             itemBuilder: (BuildContext context, int index) {
              var order = state.orders[index];
        
              return   ListTile(
         trailing: Text("\$${order.total_amount}", 
                style:  const TextStyle(
                  color: Colors.red, 
                  fontWeight: FontWeight.bold
                ),
                
                ),
                title: Text("Order#${order.id}", 
                style: const TextStyle(
                  color: Colors.black
                ),
                
                ),
                subtitle: Text("${order.createdAt}",
                 style: const TextStyle(
                  color: Colors.black
                ),
                
                ),
              ) ;
            
            
            },
            
          );
          }
                                  }
          ),
        ),
      ),
    ],
  ),
)
    );
  }
}