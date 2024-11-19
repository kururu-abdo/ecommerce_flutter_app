import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CategoryCardFullWidth extends StatelessWidget {
  final String title;
  final String imageUrl;
  final VoidCallback onTap;
final bool? isLoading;
  const CategoryCardFullWidth({
    super.key,
    required this.title,
    required this.imageUrl,
    required this.onTap, required name, this.isLoading=false,
  });

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        if (isLoading!) {
          
        return Skeletonizer(
          enabled: true,
          child: GestureDetector(
            onTap:() {},
            child: Card(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 4,
              child: SizedBox(
                height: 120, // Set the height of the card
                child: Row(
                  children: [
                    // // Image Section
                    // ClipRRect(
                    //   borderRadius: const BorderRadius.horizontal(
                    //     left: Radius.circular(12),
                    //   ),
                    //   child: Image.network(
                    //     '',
                    //     width: 120, // Fixed width for the image
                    //     height: double.infinity,
                    //     fit: BoxFit.cover,
                    //   ),
                    // ),
          
                    // Text Section
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              title,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              "Explore now",
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
    
    
        }

        return GestureDetector(
          onTap: onTap,
          child: Card(
            color: Colors.white,
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 4,
            child: SizedBox(
              height: 120, // Set the height of the card
              child: 
              
              
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Image Section
                  // ClipRRect(
                  //   borderRadius: const BorderRadius.horizontal(
                  //     left: Radius.circular(12),
                  //   ),
                  //   child: Image.network(
                  //     '',
                  //     width: 120, // Fixed width for the image
                  //     height: double.infinity,
                  //     fit: BoxFit.cover,
                  //   ),
                  // ),
        
                  // Text Section
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            "Explore now",
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
           
           
            ),
          ),
        );
    
    
      }
    );
  }
}
