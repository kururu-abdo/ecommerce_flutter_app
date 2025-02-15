import 'package:ecommerce_app/categories/data/models/category.dart';
import 'package:ecommerce_app/features/home/data/models/address_model.dart';
import 'package:ecommerce_app/features/home/data/models/product.dart';
import 'package:equatable/equatable.dart';

enum ProductViewState { initial, loading, success, failure;

String get message {
    switch (this) {
      case ProductViewState.success:
        return 'Operation completed successfully!';
      case ProductViewState.failure:
        return 'Operation failed. Please try again.';
      case ProductViewState.loading:
        return 'Loading... Please wait.';
      default:
        return 'Unknown status.';
    }
  }
 }


final class ProductState extends Equatable {
  const ProductState({
    this.status = ProductViewState.initial,
    this.prdocuts = const [],
    this.topSales =const [], 
    this.addressModel
  });

  final List<ProductModel> prdocuts;
    final List<ProductModel> topSales;
final AddressModel? addressModel;
final ProductViewState? status;


  ProductState copyWith({
    ProductViewState Function()? status,
    List<ProductModel> Function()? products,
        List<ProductModel> Function()? topSales,

    AddressModel Function()? addressModel,

  }) {
    return ProductState(
      status: status!=null? status():this.status,
      prdocuts: products!=null?products(): this.prdocuts,
      topSales: topSales!=null?topSales(): this.topSales , 

      addressModel: addressModel!=null? addressModel():this.addressModel
      
    );
  }

  @override
  List<Object?> get props => [
        status,
        addressModel,
        prdocuts,
        topSales,
      ];
}