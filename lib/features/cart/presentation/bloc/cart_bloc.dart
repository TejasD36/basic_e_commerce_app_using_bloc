import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../products/domain/entities/product.dart';
import '../../domain/entities/cart_item.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(const CartLoaded()) {
    on<LoadCart>(_onLoadCart);
    on<AddItem>(_onAddItem);
    on<RemoveItem>(_onRemoveItem);
    on<UpdateQuantity>(_onUpdateQuantity);
    on<ClearCart>(_onClearCart);
  }

  final List<CartItem> _items = [];

  void _onLoadCart(LoadCart event, Emitter<CartState> emit) {
    emit(_buildLoadedState());
  }

  void _onAddItem(AddItem event, Emitter<CartState> emit) {
    final existingIndex = _items.indexWhere((item) => item.product.id == event.product.id);

    if (existingIndex != -1) {
      final existingItem = _items[existingIndex];

      _items[existingIndex] = existingItem.copyWith(quantity: (existingItem.quantity + event.quantity).clamp(1, 10));
    } else {
      _items.add(CartItem(product: event.product, quantity: event.quantity));
    }

    emit(_buildLoadedState());
  }

  void _onRemoveItem(RemoveItem event, Emitter<CartState> emit) {
    _items.removeWhere((item) => item.product.id == event.productId);

    emit(_buildLoadedState());
  }

  void _onUpdateQuantity(UpdateQuantity event, Emitter<CartState> emit) {
    final index = _items.indexWhere((item) => item.product.id == event.productId);

    if (index == -1) return;

    if (event.quantity <= 0) {
      _items.removeAt(index);
    } else {
      _items[index] = _items[index].copyWith(quantity: event.quantity.clamp(1, 10));
    }

    emit(_buildLoadedState());
  }

  void _onClearCart(ClearCart event, Emitter<CartState> emit) {
    _items.clear();

    emit(const CartLoaded());
  }

  CartLoaded _buildLoadedState() {
    final subtotal = _items.fold<double>(0, (sum, item) => sum + item.totalPrice);

    final tax = subtotal * 0.05;
    final total = subtotal + tax;

    return CartLoaded(items: List.unmodifiable(_items), subtotal: subtotal, tax: tax, total: total);
  }
}
