import 'package:flutter_riverpod/flutter_riverpod.dart';


// StateNotifier for product list
class ProductNotifier extends StateNotifier<List> {
  ProductNotifier() : super([]);

  // Fetch products from API
  Future<void> fetchProducts() async {
    try {
      // state = await ProductService.fetchProducts();
    } catch (e) {
      throw Exception('Failed to fetch products');
    }
  }

  // Toggle favorite status
  Future<void> toggleFavorite(int productId) async {
    final productIndex = state.indexWhere((product) => product.id == productId);
    if (productIndex != -1) {
      final product = state[productIndex];
      // final updatedProduct = Product(
      //   id: product.id,
      //   name: product.name,
      //   imageUrl: product.imageUrl,
      //   isFavorite: !product.isFavorite,
      // );

      // Optimistic UI update
      state = [
        ...state.sublist(0, productIndex),
        // updatedProduct,
        ...state.sublist(productIndex + 1),
      ];

      // Send update to the server
      try {
        // await ProductService.toggleFavorite(productId, updatedProduct.isFavorite);
      } catch (e) {
        // Rollback in case of failure
        state = [
          ...state.sublist(0, productIndex),
          product,
          ...state.sublist(productIndex + 1),
        ];
        throw Exception('Failed to update favorite status');
      }
    }
  }
}

// Product provider
final productProvider = StateNotifierProvider<ProductNotifier, List>((ref) {
  return ProductNotifier();
});
