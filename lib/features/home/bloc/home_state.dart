import 'package:ecommerce_app/categories/data/models/category.dart';
import 'package:ecommerce_app/features/home/data/models/address_model.dart';
import 'package:ecommerce_app/features/home/data/models/product.dart';
import 'package:equatable/equatable.dart';

enum HomeViewStatus { initial, loading, success, failure(errorMsg: '') ; 
const HomeViewStatus({this.errorMsg});
final String? errorMsg;

 }


final class HomeViewState extends Equatable {
  const HomeViewState({
    this.status = HomeViewStatus.initial,
    this.categories = const [],
    this.topSales =const [], 
    this.addressModel
  });

  final List<Category> categories;
    final List<ProductModel> topSales;
final AddressModel? addressModel;
final HomeViewStatus? status;


  HomeViewState copyWith({
    HomeViewStatus Function()? status,
    List<Category> Function()? categories,
        List<ProductModel> Function()? topSales,

    AddressModel Function()? addressModel,

  }) {
    return HomeViewState(
      status: status!=null? status():this.status,
      categories: categories!=null?categories(): this.categories,
      topSales: topSales!=null?topSales(): this.topSales , 

      addressModel: addressModel!=null? addressModel():this.addressModel
      
    );
  }

  @override
  List<Object?> get props => [
        status,
        addressModel,
        categories,
        topSales,
      ];
}