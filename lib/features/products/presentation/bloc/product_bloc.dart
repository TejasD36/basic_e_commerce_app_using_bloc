import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';
import 'product_sort_type.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository repository;

  List<Product> _allProducts = [];

  ProductBloc(this.repository) : super(ProductInitial()) {
    on<LoadProducts>(_onLoadProducts);
    on<RefreshProducts>(_onRefreshProducts);
    on<SortProducts>(_onSortProducts);
  }

  Future<void> _onLoadProducts(LoadProducts event, Emitter<ProductState> emit) async {
    emit(ProductLoading());

    try {
      final products = await repository.getProducts();

      _allProducts = products;

      emit(ProductLoaded(products: products));
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }

  Future<void> _onRefreshProducts(RefreshProducts event, Emitter<ProductState> emit) async {
    try {
      final products = await repository.refreshProducts();

      _allProducts = products;

      emit(ProductLoaded(products: products));
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }

  void _onSortProducts(SortProducts event, Emitter<ProductState> emit) {
    final sortedProducts = List<Product>.from(_allProducts);

    switch (event.sortType) {
      case ProductSortType.priceLowToHigh:
        sortedProducts.sort((a, b) => a.price.compareTo(b.price));
        break;

      case ProductSortType.priceHighToLow:
        sortedProducts.sort((a, b) => b.price.compareTo(a.price));
        break;

      case ProductSortType.nameAZ:
        sortedProducts.sort((a, b) => a.title.compareTo(b.title));
        break;

      case ProductSortType.none:
        break;
    }

    emit(ProductLoaded(products: sortedProducts, selectedSort: event.sortType));
  }
}
