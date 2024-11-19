// lib/widgets/banner_carousel.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class BannerCarousel extends ConsumerWidget {
  const BannerCarousel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {


  return     Container(
    padding: const EdgeInsets.symmetric(horizontal: 8),
        height: 200, // Adjust the height as needed
        child: PageView.builder(
          itemCount: 3,
          itemBuilder: (context, index) {
            // final banner = banners[index];
            return GestureDetector(
              onTap: () {
                // Handle banner tap, e.g., open banner.link in a WebView or navigate to a screen
              },
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    'http://192.168.43.183:8080/images/products/fadeel.jpg',
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    bottom: 16,
                    left: 16,
                    child: Text(
                     'banner $index',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        backgroundColor: Colors.black54,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      );
   
    /*
    final bannerAsyncValue = ref.watch(bannerProvider);

    return bannerAsyncValue.when(
      data: (banners) =>

       SizedBox(
        height: 200, // Adjust the height as needed
        child: PageView.builder(
          itemCount: banners.length,
          itemBuilder: (context, index) {
            final banner = banners[index];
            return GestureDetector(
              onTap: () {
                // Handle banner tap, e.g., open banner.link in a WebView or navigate to a screen
              },
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    banner.imageUrl,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    bottom: 16,
                    left: 16,
                    child: Text(
                      banner.title,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        backgroundColor: Colors.black54,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
   
      loading: () => SizedBox(
        height: 200,
        child: Center(child: CircularProgressIndicator()),
      ),
      error: (error, stack) => SizedBox(
        height: 200,
        child: Center(child: Text('Failed to load banners')),
      ),
    );

    */
  }
}
