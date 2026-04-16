part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object?> get props => [];
}

class LoadCart extends CartEvent {
  const LoadCart();
}

class AddItem extends CartEvent {
  final Product product;
  final int quantity;

  const AddItem({required this.product, required this.quantity});

  @override
  List<Object?> get props => [product, quantity];
}

class RemoveItem extends CartEvent {
  final String productId;

  const RemoveItem(this.productId);

  @override
  List<Object?> get props => [productId];
}

class UpdateQuantity extends CartEvent {
  final String productId;
  final int quantity;

  const UpdateQuantity({required this.productId, required this.quantity});

  @override
  List<Object?> get props => [productId, quantity];
}

class ClearCart extends CartEvent {
  const ClearCart();
}
