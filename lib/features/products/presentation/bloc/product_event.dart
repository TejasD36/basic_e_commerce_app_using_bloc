part of 'product_bloc.dart';

abstract class ProductEvent {}

class LoadProducts extends ProductEvent {}

class RefreshProducts extends ProductEvent {}

class GetProductById extends ProductEvent {
  final String id;

  GetProductById(this.id);
}

class SortProducts extends ProductEvent {
  final ProductSortType sortType;

  SortProducts(this.sortType);
}
