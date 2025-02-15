import 'package:ecommerce_app/di/category.dart';
import 'package:ecommerce_app/di/common.dart';
import 'package:ecommerce_app/di/home.dart';
import 'package:ecommerce_app/di/order.dart';
import 'package:ecommerce_app/di/product.dart';
import 'package:get_it/get_it.dart';

GetIt sl = GetIt.instance;

// Main Initialization
Future<void> init() async {
  // // Register features
 registerHomeFeature();
 registerproductFeature();
registerOrderFeature();
registerCategoryFeature();
  // // Register Cubits
  // registerCubits();

  // // Register common dependencies
  registerCommonDependencies();
}