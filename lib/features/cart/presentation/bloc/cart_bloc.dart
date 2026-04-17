import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../products/domain/entities/product.dart';
import '../../domain/entities/cart_item.dart';
import '../../domain/repositories/cart_repository.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final CartRepository repository;

  CartBloc(this.repository) : super(const CartLoaded()) {
    on<LoadCart>(_onLoadCart);
    on<AddItem>(_onAddItem);
    on<RemoveItem>(_onRemoveItem);
    on<UpdateQuantity>(_onUpdateQuantity);
    on<ClearCart>(_onClearCart);
  }

  final List<CartItem> _items = [];

  Future<void> _onLoadCart(LoadCart event, Emitter<CartState> emit) async {
    try {
      final savedItems = await repository.getCartItems();

      _items
        ..clear()
        ..addAll(savedItems);

      emit(_buildLoadedState());
    } catch (e) {
      emit(CartError(e.toString()));
    }
  }

  Future<void> _onAddItem(AddItem event, Emitter<CartState> emit) async {
    try {
      final existingIndex = _items.indexWhere((item) => item.product.id == event.product.id);

      if (existingIndex != -1) {
        final existingItem = _items[existingIndex];

        _items[existingIndex] = existingItem.copyWith(quantity: (existingItem.quantity + event.quantity).clamp(1, 10));
      } else {
        _items.add(CartItem(product: event.product, quantity: event.quantity));
      }

      await repository.saveCartItems(_items);

      emit(_buildLoadedState());
    } catch (e) {
      emit(CartError(e.toString()));
    }
  }

  Future<void> _onRemoveItem(RemoveItem event, Emitter<CartState> emit) async {
    try {
      _items.removeWhere((item) => item.product.id == event.productId);

      await repository.saveCartItems(_items);

      emit(_buildLoadedState());
    } catch (e) {
      emit(CartError(e.toString()));
    }
  }

  Future<void> _onUpdateQuantity(UpdateQuantity event, Emitter<CartState> emit) async {
    try {
      final index = _items.indexWhere((item) => item.product.id == event.productId);

      if (index == -1) return;

      if (event.quantity <= 0) {
        _items.removeAt(index);
      } else {
        _items[index] = _items[index].copyWith(quantity: event.quantity.clamp(1, 10));
      }

      await repository.saveCartItems(_items);

      emit(_buildLoadedState());
    } catch (e) {
      emit(CartError(e.toString()));
    }
  }

  Future<void> _onClearCart(ClearCart event, Emitter<CartState> emit) async {
    try {
      _items.clear();

      await repository.clearCart();

      emit(const CartLoaded());
    } catch (e) {
      emit(CartError(e.toString()));
    }
  }

  CartLoaded _buildLoadedState() {
    final subtotal = _items.fold<double>(0, (sum, item) => sum + item.totalPrice);

    final tax = subtotal * 0.05;
    final total = subtotal + tax;

    return CartLoaded(items: List.unmodifiable(_items), subtotal: subtotal, tax: tax, total: total);
  }
}
