import 'dart:convert';

import 'package:ecommerce_app/home/data/models/address_model.dart';
import 'package:ecommerce_app/home/data/models/product.dart';
import 'package:ecommerce_app/home/views/widgets/banner.dart';
import 'package:ecommerce_app/providers/http_client_provider.dart';
import 'package:ecommerce_app/shared/widget/category_card.dart';
import 'package:ecommerce_app/shared/widget/product_card.dart';
import 'package:ecommerce_app/shared/widget/search_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final dataProvider = FutureProvider.family<List<Map<String, dynamic>>, String>((ref, endpoint) async {
  final apiService = ref.read(httpClientProvider);
 var response =await apiService.get(endpoint);
 Iterable data = jsonDecode(response.body) ;
  return data.map((row)=>{
    'ar_name':row['ar_name']
  }).toList();
});
final topSalesProvider = FutureProvider.family<List<ProductModel>, String>((ref, endpoint) async {
  final apiService = ref.read(httpClientProvider);
 var response =await apiService.get(endpoint);
 Iterable data = jsonDecode(response.body) ;
  return data.map((row)=>ProductModel.fromJson(row)).toList();
});
final addressProvider = FutureProvider.family<List<AddressModel>, String>((ref, endpoint) async {
  final apiService = ref.read(httpClientProvider);
 var response =await apiService.get(endpoint);
 Iterable data = jsonDecode(response.body) ;
  return data.map((row)=>AddressModel.fromJson(row)).toList();
});
class HomeScreen extends ConsumerWidget {
   HomeScreen({super.key});
final searchController = TextEditingController();
  @override
  Widget build(BuildContext context , WidgetRef ref) {

        var categoriesAsyncValue = ref.watch(dataProvider('/categories')); // Example endpoint
        var topSalesValueAsync = ref.watch(topSalesProvider('/top_sales')); // Example endpoint
    final addressAsyncValue = ref.watch(addressProvider('/address'));
    return 
    Scaffold(
      backgroundColor: Colors.white,
       appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100), // Custom height for AppBar
        child: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Theme.of(context).primaryColor,
          // title: Image.asset(Images.logo_with_name),
          flexibleSpace: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Delivery to",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    TextButton(
                      onPressed: (){
                        
                      },
                      child: const Text(
                        "Change",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                const Text(
                  'currentAddress',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ],
            ),
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: ()async{
ref.refresh(dataProvider('/categories'));
ref.refresh(topSalesProvider('/top_sales'));
        },
        child: SingleChildScrollView(
           physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
const SizedBox(height: 8,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SearchTextFormField(
                  hintText: 'search',controller:searchController,
                  
                  
                  ),
              ),    const SizedBox(height: 8,),
               const BannerCarousel(),
              const SizedBox(height: 8,),
              // Categories section
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Categories', 
                style: Theme.of(context).textTheme.headlineSmall),
              ), 
                  categoriesAsyncValue.when(
          data: (data) => 
          
          
           SizedBox(
                height: 60,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    final category = data[index];
                    return CategoryCard(
                      
                      name: category['ar_name']);
                  },
                ),
              )
          
          
          ,
          loading: () =>  SizedBox(
                height: 60,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 8,
                  itemBuilder: (context, index) {
                   
                    return const CategoryCard(isLoading: true,name: '',);
                  },
                ),
              ),
          error: (error, stack) =>  
          Center(
            child: IconButton(onPressed: (){
            
            }, icon: const Icon(Icons.refresh)),
          )
                  ),
                  
                  const SizedBox(height: 8,),
                  // Categories section
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Top Products', 
                style: Theme.of(context).textTheme.headlineSmall),
              ), 
                  
                
                
                
                 topSalesValueAsync.when(
          data: (data) => 
          
          
           GridView.builder(
                           shrinkWrap: true,
                           physics: const NeverScrollableScrollPhysics(),
                           itemCount: data.length,
                           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            childAspectRatio: 0.7,
                           ),
                           itemBuilder: (context, index) {
            final product = data[index];
            return ProductCard(name: product.arName, 
            
            price: product.price,
            isFavorite: product.isFavourite,
            );
                           },
                         )
          
          
          ,
          loading: () =>  GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 4,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              childAspectRatio: 0.7,
            ),
            itemBuilder: (context, index) {
              return const ProductCard(isLoading: true, name: '',
              
              
              );
            }
          ),
          error: (error, stack) =>  
          Center(
            child: IconButton(onPressed: (){
            
            }, icon: const Icon(Icons.refresh)),
          )
                  ),
                
                
                
                
                
                
                
                
                
                
                
                
                
                  /*
                  
                  
                   // Products section
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Featured Products', style: Theme.of(context).textTheme.headline6),
              ),
              GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: products.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  childAspectRatio: 0.7,
                ),
                itemBuilder: (context, index) {
                  final product = products[index];
                  return ProductCard(product: product);
                },
              ),
                  */
                  
                  
            ]
          )
        ),
      ),
    );
  }
}