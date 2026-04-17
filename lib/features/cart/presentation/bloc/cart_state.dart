part of 'cart_bloc.dart';

abstract class CartState extends Equatable {
  const CartState();

  @override
  List<Object?> get props => [];
}

class CartLoaded extends CartState {
  final List<CartItem> items;
  final double subtotal;
  final double tax;
  final double total;

  const CartLoaded({this.items = const [], this.subtotal = 0, this.tax = 0, this.total = 0});

  bool get isEmpty => items.isEmpty;

  @override
  List<Object?> get props => [items, subtotal, tax, total];
}

class CartError extends CartState {
  final String message;

  const CartError(this.message);

  @override
  List<Object?> get props => [message];
}
