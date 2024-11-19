import 'package:ecommerce_app/categories/data/models/category.dart';
import 'package:ecommerce_app/categories/providers/category_prodiver.dart';
import 'package:ecommerce_app/categories/view/widget/category_full_width.dart';
import 'package:ecommerce_app/utils/images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dataProvider = FutureProvider.family<List<Category>?, void>((ref, endpoint) async {
  var categories = ref.watch(categoryStateProvider.notifier);
return categories.getCategories();
 
});


class CategoryList extends ConsumerStatefulWidget {
  const CategoryList({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CategoryListState();
}
class _CategoryListState extends ConsumerState<CategoryList> {
  @override
  Widget build(BuildContext context) {
       var categoriesAsyncValue = ref.watch(dataProvider('/categories'));

    return Scaffold(
            backgroundColor: Colors.white,

    appBar: AppBar(
      backgroundColor: Colors.white,
      leading: IconButton(onPressed: (){

      }, icon: const Icon(Icons.arrow_back_ios),
      
      
      ),
      title: const Text('Categories'),
      centerTitle: true,
      actions: const [
        ImageIcon(AssetImage(Images.tuned,),color: Colors.black,)
      ],
    ),
    body:SizedBox.expand(
      child: Padding(padding: const EdgeInsets.all(16)
      ,
      child:  categoriesAsyncValue.when(
          data: (data) => 
          
          
           SizedBox(
                height: 60,
                child: ListView.builder(
                  // scrollDirection: Axis.horizontal,
                  itemCount: data!.length,
                  itemBuilder: (context, index) {
                    final category = data[index];
                    // return const Text("data");
                    return CategoryCardFullWidth(
                      isLoading: false,
                    title: category.nameAr,
                     imageUrl: '', onTap: () {  }, name:category.nameAr,);
                  },
                ),
              )
          
          
          ,
          loading: () =>  SizedBox(
                height: 60,
                child: ListView.builder(
                  // scrollDirection: Axis.horizontal,
                  itemCount: 8,
                  itemBuilder: (context, index) {
                   
                    return CategoryCardFullWidth(
                                            isLoading: true,

                    title: '', imageUrl: '', onTap: () {  }, name: '',);
                  },
                ),
              ),
          error: (error, stack) =>  
          Center(
            child: IconButton(onPressed: (){
            ref.refresh(dataProvider('/categories'));
            }, icon: const Icon(Icons.refresh)),
          )
                  ),
      ),
    )
    );
  }
}