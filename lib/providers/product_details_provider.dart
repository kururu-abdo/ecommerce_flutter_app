import 'dart:developer';

import 'package:ecommerce_app/product/data/models/product_details_model.dart';
import 'package:ecommerce_app/repositories/product_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


// StateNotifier for product list
class ProductDetailsNotifier extends StateNotifier<ProductDetailsModel?> {
 final ProductRepository productRepository;
  ProductDetailsNotifier(this.productRepository) : super(null);

  // Fetch products from API
  Future<ProductDetailsModel?> getProduct(int product) async {
    try {
      // state = await ProductService.fetchProducts();
      state = await productRepository.getProductDetails(product);

      return state;
    } catch (e) {
      log(e.toString());
      throw Exception('Failed to fetch products');

    }
  }


}

// Product provider
final productDetailsProvider = StateNotifierProvider<ProductDetailsNotifier, ProductDetailsModel?>((ref) {
  var  productRepo = ref.watch(productRepositoryProvider);
  return ProductDetailsNotifier(productRepo);
});
