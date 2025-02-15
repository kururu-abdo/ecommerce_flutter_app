import 'package:ecommerce_app/categories/data/models/category.dart';
import 'package:ecommerce_app/features/home/data/models/address_model.dart';
import 'package:ecommerce_app/features/home/data/models/product.dart';
import 'package:equatable/equatable.dart';

sealed class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

final class LoadHomeCategoriesEvent extends HomeEvent {
  const LoadHomeCategoriesEvent({
    required this.categories,
    required this.isCompleted,
  });

  final List<Category> categories;
  final bool isCompleted;

  @override
  List<Object> get props => [categories, isCompleted];
}


final class LoadHomeAddressModelEvent extends HomeEvent {
  const LoadHomeAddressModelEvent({
    required this.addressModel,
    required this.isCompleted,
  });

  final AddressModel addressModel;
  final bool isCompleted;

  @override
  List<Object> get props => [addressModel, isCompleted];
}


final class LoadHomeTopSalesEvent extends HomeEvent {
  const LoadHomeTopSalesEvent({
    required this.topSales,
    required this.isCompleted,
  });

  final List<ProductModel> topSales;
  final bool isCompleted;

  @override
  List<Object> get props => [topSales, isCompleted];
}
final class LoadHomeBannersEvent extends HomeEvent {
  const LoadHomeBannersEvent({
    required this.banners,
    required this.isCompleted,
  });

  final List<String> banners;
  final bool isCompleted;

  @override
  List<Object> get props => [banners, isCompleted];
}

