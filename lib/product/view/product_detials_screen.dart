import 'package:ecommerce_app/cart/view/data/models/cart_update_model.dart';
import 'package:ecommerce_app/product/data/models/product_details_model.dart';
import 'package:ecommerce_app/providers/cart_provider.dart';
import 'package:ecommerce_app/providers/product_details_provider.dart';
import 'package:ecommerce_app/providers/product_provider.dart';
import 'package:ecommerce_app/shared/widget/main_button.dart';
import 'package:ecommerce_app/shared/widget/product_card.dart';
import 'package:ecommerce_app/utils/Strings.dart';
import 'package:ecommerce_app/utils/images.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
final productDetailsFutureProvider = FutureProvider.autoDispose.family<ProductDetailsModel, int>((ref, id) async {
  final productDetaildProvider = ref.read(productDetailsProvider.notifier);
 var response =await productDetaildProvider.getProduct(id);
  return response!;
});
final addToCartProvider = FutureProvider.family<void, CartUpdateModel>((ref, product) async {
  final crtProvider =ref.read(cartProvider.notifier);

 crtProvider.addToCart(product);
});
@Deprecated('No longer useful')
class ProductDetailsScreen extends ConsumerStatefulWidget {
  // final Map<String, dynamic> product;
final int? product;
final String? productName;
  const ProductDetailsScreen( {super.key, this.productName, required this.product});

  @override
  ConsumerState<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends ConsumerState<ProductDetailsScreen> {
  final int _currentImageIndex = 0;
 int _quantity = 1;

  void _increaseQuantity() {
    setState(() {
      _quantity++;
    });
  }
Offset _offset =Offset.zero;
  void _decreaseQuantity() {
    if (_quantity > 1) {
      setState(() {
        _quantity--;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
   var productdetailsFutureValue = ref.watch(productDetailsFutureProvider(widget.product!));

return  Scaffold(
  backgroundColor: Colors.white,
appBar: AppBar(

  backgroundColor: Colors.transparent,
  title:  Text("${widget.productName}"),
),
body: 




 SizedBox.expand(
  child: 
  
   productdetailsFutureValue.when(
          data: (data) {

            return 

             SingleChildScrollView(
  padding: const EdgeInsets.all(16),
    child: Column(
      children: [
  
        //Product Photo
        Center(
          child: SizedBox(
            height: MediaQuery.sizeOf(context).height/3,
            child:CarouselSlider.builder(
              
              itemCount: data.images!.length,
              itemBuilder: (context,_,  index) {
                return GestureDetector(
                  
                  
                  
                  child: Image.network(
                    
                    "${Strings.BASE_URL}${data.imageUrl}"));
              }, options: CarouselOptions(),
            ),
          ),
        ), 
  const SizedBox(height: 16,), 
  Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
  
    children: [
      Text("${widget.productName}" , style: Theme.of(context).textTheme.bodyLarge!.copyWith(
        fontWeight: FontWeight.bold
    ),), 
  
      Semantics(
        label: 'product rating',
        value: 'out of 5',
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
          
            Icon(Icons.star ,color: Colors.amber,), 
            Text("(0.0)")
          ],
        ),
      )
    ],
  ),
  const SizedBox(height: 8,), 
  SizedBox(
    width: MediaQuery.sizeOf(context).width,
    child: Text(
      data.desc!
     , // """Top 10 product in the this platform , most of sales was on it so don't miss it ,this product made for you so add it to your cart and checkout your order""", 
  
      maxLines: 3
      , style: Theme.of(context).textTheme.bodyMedium,
      overflow: TextOverflow.ellipsis,
    ),
  )
  , 


  // const SizedBox(height: 24,) , 
  
  // Row(
  //   children: [
  // Text("Size:", 
  // style: Theme.of(context).textTheme.bodyMedium!.copyWith(
  // fontWeight: FontWeight.bold ,fontSize: 18
  // ),
  // ), 
  // SizedBox(
  //   height: 60,
  //   child: ListView(
  //     scrollDirection: Axis.horizontal,
  //     shrinkWrap: true,
  //     children: ['US 1','US 5'].map((data){
  //   return Container(
  //   width: 60,height: 60 , 
  //   margin: const EdgeInsets.all(2),
    
  //   decoration: BoxDecoration(
  //     shape: BoxShape.circle,
  //     color: Theme.of(context).primaryColor, 
    
  //   ),
  //   child: Center(
  //     child: Text(data, style: const TextStyle(
  //       color: Colors.white,
  //       fontSize: 14
  //     ),),
  //   ),
  //   );
    
  //     }).toList(),
  //   ),
  // )
  
  //   ],
  // ),
  

  
  
  // const SizedBox(height: 24,) , 



  // Row(
  //   children: [
  // Text("Color:", 
  // style: Theme.of(context).textTheme.bodyMedium!.copyWith(
  // fontWeight: FontWeight.bold ,fontSize: 18
  // ),
  // ), 
  // SizedBox(
  //   height: 25,
  //   child: ListView(
  //     scrollDirection: Axis.horizontal,
  //     shrinkWrap: true,
  //     physics: const NeverScrollableScrollPhysics(),
  //     children: ['0xFFFF0000','0xFF0000FF', '0xFF008000','0xFFFFFF00', 
      
  //     '0xFF800080'
  //     ].map((data){
  //   return Container(
  //   width: 25,height: 25 , 
  //   margin: const EdgeInsets.all(1),
  //   decoration: BoxDecoration(
  //     shape: BoxShape.circle,
  //     color:Color(int.parse(data))
    
  //   ),
    
  //   );
    
  //     }).toList(),
  //   ),
  // )
  
  //   ],
  // ),
  
  // const SizedBox(height: 16,) , 
  
  
  Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
  Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
       Text("Quantity:"
      ,
       style: Theme.of(context).textTheme.bodyLarge,
      
      ),
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
           IconButton(
                        icon: const Icon(Icons.remove),
                        onPressed: _decreaseQuantity,
                      ),
                      Text(
                        _quantity.toString(),
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: _increaseQuantity,
                      ),
        ],
      ),
    ],
  )
  
    ],
  )
      
      
      
      
      

      //RELATED PRODUCS
,

const Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
children: [
Text("Related products",  style: TextStyle(
  fontWeight: FontWeight.w500
),)

],
),
const SizedBox(height: 16,),
           GridView.builder(
                           shrinkWrap: true,
                           physics: const NeverScrollableScrollPhysics(),
                           itemCount: data.relatedProducts!.length,
                           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            childAspectRatio: 0.7,
                           ),
                           itemBuilder: (context, index) {
            final product = data.relatedProducts![index];
            return ProductCard(name: product.arName, 
            
            price: product.price,
            isFavorite: product.isFavourite,
            image:product.imageUrl, 
            id: int.parse(product.id!),
            );
                           },
                         )
          
          
      
      
      ],
    ),
  );

          } 


,
loading: (){

return 


             Skeletonizer(
              enabled: true,
               child: SingleChildScrollView(
                 padding: const EdgeInsets.all(16),
                   child: Column(
                     children: [
                 
                       //Product Photo
                       Center(
                         child: SizedBox(
                           height: MediaQuery.sizeOf(context).height/3,
                           child: Transform(
                transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001)
                ..rotateX(_offset.dx)
                // ..rotateY(_offset.dy)
                ,
                child: GestureDetector(
                  
                  onPanUpdate: (details){
                    _offset = _offset+=details.delta;
                    setState(() {
                      
                    });
                  },
                  child: Image.asset(Images.appIcon)),
                           ),
                         ),
                       ), 
                 const SizedBox(height: 16,), 
                 Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 
                   children: [
                     Text("${widget.productName}" , style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                       fontWeight: FontWeight.bold
                   ),), 
                 
                     Semantics(
                       label: 'product rating',
                       value: 'out of 5',
                       child: const Row(
                         mainAxisSize: MainAxisSize.min,
                         children: [
                         
                           Icon(Icons.star ,color: Colors.amber,), 
                           Text("(0.0)")
                         ],
                       ),
                     )
                   ],
                 ),
                 const SizedBox(height: 8,), 
                 SizedBox(
                   width: MediaQuery.sizeOf(context).width,
                   child: Text(
                     """Top 10 product in the this platform , most of sales was on it so don't miss it ,this product made for you so add it to your cart and checkout your order""", 
                 
                     maxLines: 3
                     , style: Theme.of(context).textTheme.bodyMedium,
                     overflow: TextOverflow.ellipsis,
                   ),
                 )
                 , 
               
               
                 const SizedBox(height: 24,) , 
                 
                 Row(
                   children: [
                 Text("Size:", 
                 style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                 fontWeight: FontWeight.bold ,fontSize: 18
                 ),
                 ), 
                 SizedBox(
                   height: 60,
                   child: ListView(
                     scrollDirection: Axis.horizontal,
                     shrinkWrap: true,
                     children: ['US 1','US 5'].map((data){
                   return Container(
                   width: 60,height: 60 , 
                   margin: const EdgeInsets.all(2),
                   
                   decoration: BoxDecoration(
                     shape: BoxShape.circle,
                     color: Theme.of(context).primaryColor, 
                   
                   ),
                   child: Center(
                     child: Text(data, style: const TextStyle(
                       color: Colors.white,
                       fontSize: 14
                     ),),
                   ),
                   );
                   
                     }).toList(),
                   ),
                 )
                 
                   ],
                 ),
                 
               
                 
                 
                 const SizedBox(height: 24,) , 
                 Row(
                   children: [
                 Text("Color:", 
                 style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                 fontWeight: FontWeight.bold ,fontSize: 18
                 ),
                 ), 
                 SizedBox(
                   height: 25,
                   child: ListView(
                     scrollDirection: Axis.horizontal,
                     shrinkWrap: true,
                     physics: const NeverScrollableScrollPhysics(),
                     children: ['0xFFFF0000','0xFF0000FF', '0xFF008000','0xFFFFFF00', 
                     
                     '0xFF800080'
                     ].map((data){
                   return Container(
                   width: 25,height: 25 , 
                   margin: const EdgeInsets.all(1),
                   decoration: BoxDecoration(
                     shape: BoxShape.circle,
                     color:Color(int.parse(data))
                   
                   ),
                   
                   );
                   
                     }).toList(),
                   ),
                 )
                 
                   ],
                 ),
                 
                 const SizedBox(height: 16,) , 
                 
                 
                 Row(
                   mainAxisAlignment: MainAxisAlignment.end,
                   children: [
                 Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                      Text("Quantity:"
                     ,
                      style: Theme.of(context).textTheme.bodyLarge,
                     
                     ),
                     Row(
                       mainAxisSize: MainAxisSize.min,
                       children: [
                          IconButton(
                          icon: const Icon(Icons.remove),
                          onPressed: _decreaseQuantity,
                        ),
                        Text(
                          _quantity.toString(),
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: _increaseQuantity,
                        ),
                       ],
                     ),
                   ],
                 )
                 
                   ],
                 )
                     ],
                   ),
                 ),
             );



},
error: (_ , ___)=>Text("$___")

  
  
  
   )

),
bottomNavigationBar: Builder(builder: (_){


  return 
  
 productdetailsFutureValue.when(
          data: (data) {
    return
     Container(
    
      width: MediaQuery.of(context).size.width,
      height: 120,
      padding: const EdgeInsets.all(16),
    decoration:  BoxDecoration(
    color: Colors.white, 
    boxShadow: [
      BoxShadow(
        blurRadius: 8 ,spreadRadius: 4, 
        color: Colors.grey[100]!,
        offset: const Offset(0, 0)
      )
    ]
    ),
    
    child:  Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
     Text("\$${data.price}", style: const TextStyle(
    color: Colors.black ,fontSize: 30, 
    fontWeight: FontWeight.bold
    ),), 
    Builder(
      builder: (context) {
        return
        data.cart!.isNotEmpty?
        TextButton(onPressed: (){}, child: const Text('view cart')):
         MainButton(
        
        width: MediaQuery.sizeOf(context).width*.45,
        text: 'Add to cart', onPressed: ()async{
        
ref.read(addToCartProvider(CartUpdateModel(product: 
widget.product!,
 quantity: 
              
              _quantity
              )));
        ref.watch(productDetailsFutureProvider(widget.product!));
        });
      }
    )
    ],
    ),
    
  );
}
, 
loading: (){

return const SizedBox();
}, 
error: (_,__){
  return const SizedBox();
}
);

}

),



);

   /*
   
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              // Navigate to cart
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Images carousel
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                CarouselSlider(
                  options: CarouselOptions(
                    height: 300,
                    viewportFraction: 1.0,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _currentImageIndex = index;
                      });
                    },
                  ),
                  items: (widget.product['images'] as List<String>? ?? [widget.product['image']])
                    .map((imageUrl) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Image.network(
                            imageUrl,
                            fit: BoxFit.cover,
                            width: double.infinity,
                            errorBuilder: (context, error, stackTrace) =>
                              const Center(child: Icon(Icons.error)),
                            loadingBuilder: (context, child, loadingProgress) =>
                              loadingProgress == null ? child : const Center(child: CircularProgressIndicator()),
                          );
                        },
                      );
                    }).toList(),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AnimatedSmoothIndicator(
                    activeIndex: _currentImageIndex,
                    count: 1, // Update with actual image count
                    effect: const WormEffect(
                      dotWidth: 8,
                      dotHeight: 8,
                      activeDotColor: Colors.blue,
                    ),
                  ),
                ),
              ],
            ),

            // Product details
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.product['name']?.toString() ?? 'No name available',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '\$${widget.product['price']}',
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Description',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.product['description'] ?? 'No description available',
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),

            // Suggested products
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'You may also like',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 200,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 5, // Replace with actual suggested products count
                      itemBuilder: (context, index) {
                        return Card(
                          margin: const EdgeInsets.only(right: 16),
                          child: SizedBox(
                            width: 140,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.network(
                                  'https://via.placeholder.com/140',
                                  height: 120,
                                  width: 140,
                                  fit: BoxFit.cover,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: const [
                                      Text(
                                        'Product Name',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text(
                                        '\$99.99',
                                        style: TextStyle(
                                          color: Colors.green,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, -3),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: () {
                      if (_quantity > 1) {
                        setState(() {
                          _quantity--;
                        });
                      }
                    },
                  ),
                  Text(
                    '$_quantity',
                    style: const TextStyle(fontSize: 16),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      setState(() {
                        _quantity++;
                      });
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  // Add to cart logic
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text(
                  'Add to Cart',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
 
 */
 
  }
}
