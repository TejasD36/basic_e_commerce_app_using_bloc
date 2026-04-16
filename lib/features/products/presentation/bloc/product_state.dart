part of 'product_bloc.dart';

abstract class ProductState {}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductLoaded extends ProductState {
  final List<Product> products;
  final ProductSortType selectedSort;

  ProductLoaded({required this.products, this.selectedSort = ProductSortType.none});
}

class ProductDetailsLoaded extends ProductState {
  final Product product;

  ProductDetailsLoaded(this.product);
}

class ProductError extends ProductState {
  final String message;

  ProductError(this.message);
}
