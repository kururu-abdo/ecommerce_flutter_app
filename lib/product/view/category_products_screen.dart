import 'package:ecommerce_app/product/bloc/product_bloc.dart';
import 'package:ecommerce_app/product/bloc/product_event.dart';
import 'package:ecommerce_app/product/bloc/product_state.dart';
import 'package:ecommerce_app/shared/widget/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryProductsScreen extends StatefulWidget {
  final int? categoryId;
  const CategoryProductsScreen({super.key, this.categoryId});

  @override
  State<CategoryProductsScreen> createState() => _CategoryProductsScreenState();
}

class _CategoryProductsScreenState extends State<CategoryProductsScreen>
 {

   @override
  void initState() {
    // TODO: implement initState
    super.initState();
       context
        .read<ProductBloc>()
        .add( LoadCategoryProductEvent(
          categoryId: widget.categoryId! ,
          isCompleted: false
        ));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
body: SizedBox.expand(

  child: Padding(
    padding: const EdgeInsets.symmetric(

      horizontal: 20,  vertical: 25
    ),
    child: BlocBuilder<ProductBloc, ProductState>(
                            builder: (context, state) {
    if (state.status== ProductViewState.loading) {
      return const Center(child: CircularProgressIndicator());
    }
    
    else if (state.status== ProductViewState.loading) {
      return const Center(child: Text("Error"));
    }else{
    
      return   GridView.builder(
                             shrinkWrap: true,
                             physics: const NeverScrollableScrollPhysics(),
                             itemCount: state.prdocuts.length,
                             gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              childAspectRatio: 0.7,
                             ),
                             itemBuilder: (context, index) {
              final product =  state.prdocuts[index];
              return ProductCard(name: product.arName, 
              
              price: product.price,
              isFavorite: product.isFavourite,
              image:product.imageUrl, 
              id: int.parse(product.id!),
              );
                             },
                           );
    }
                            }
    ),
  ),
)
    );
  }
}