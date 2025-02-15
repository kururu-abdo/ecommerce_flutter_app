import 'package:ecommerce_app/product/view/product_detials_screen.dart';
import 'package:ecommerce_app/utils/Strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ProductCard extends StatelessWidget {
  // final Product product;
  final bool? isLoading;
    final bool? isFavorite;
final String? image;
final int? id;
  final String? name;
   const ProductCard({super.key,
   
   required  this.id,
   this.price=150.0,
   this.isFavorite=false,
    required this.name, this.isLoading=false, this.image});
final double? price;
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {


if (isLoading!) {
  
        return Skeletonizer(
          enabled: true,
          child: Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AspectRatio(
                  aspectRatio: 1.0,
                  child: 
             
                  
                  
                  Image.network(
                          'http://192.168.43.183:8080/images/products/fadeel.jpg', fit: BoxFit.cover),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    name!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text('\$$price', style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    fontSize: 12
                  )),
                ),
                IconButton(
                  icon: const Icon(Icons.favorite_border),
                  onPressed: () {
                    // Implement favorite toggle here
                  },
                ),
              ],
            ),
          ),
        );
     
}

        return 
        GestureDetector(
          onTap: (){
            Navigator.of(context)
            .push(
              CupertinoPageRoute(builder: 
              (_)=> ProductDetailsScreen(
                
                product: id , 

                productName:name ,
                
                
                )
              )
            );
          },
          child: Card(
            color: Colors.white,
                shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
                ),
                elevation: 4,
                child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Product Image
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                  child:  AspectRatio(
                  aspectRatio: 1.0,
                  child:
                       image==null || 
                    image!.isEmpty?
          Image.asset("assets/images/logo.png"):
                   Image.network(
                          '${Strings.BASE_URL}$image', fit: BoxFit.cover),
                ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                     name!,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                "${price.toString()}"  " ر.س",
                    style: const TextStyle(
                      
                      fontWeight: FontWeight.bold,
                      fontSize: 14, color: Colors.green),
                  ),
                ),
              ],
            ),
            // Favorite Icon
            Positioned(
              top: 8,
              right: 8,
              child: 
              AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  transitionBuilder: (child, animation) {
                    return ScaleTransition(scale: animation, child: child);
                  },
                  child: Icon(
                  isFavorite!?
                    Icons.favorite : 
                    Icons.favorite_border,
                    key: 
                    // ValueKey(product["isFavorite"]),
                    ValueKey(name),
                    color: 
                    // product["isFavorite"] ?
                    isFavorite!?
                     Colors.red 
                     
                     : Colors.grey
                    ,
                    size: 28,
                  ),
                ),
            ),
          ],
                ),
              ),
        );
        
        
        
        Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio: 1.0,
                child: Image.network(
                        'http://192.168.43.183:8080/images/products/fadeel.jpg', fit: BoxFit.cover),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  name!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text('\$$price', style: Theme.of(context).textTheme.bodySmall),
              ),
              // IconButton(
              //   icon: const Icon(Icons.favorite_border),
              //   onPressed: () {
              //     // Implement favorite toggle here
              //   },
              // ),
            ],
          ),
        );
     
     
      }
    );
  }
}