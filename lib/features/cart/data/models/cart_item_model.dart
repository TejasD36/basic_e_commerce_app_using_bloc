import 'package:hive_ce/hive.dart';

import '../../../products/data/models/product_model.dart';
import '../../domain/entities/cart_item.dart';

part 'cart_item_model.g.dart';

@HiveType(typeId: 1)
class CartItemModel extends HiveObject {
  @HiveField(0)
  final ProductModel product;

  @HiveField(1)
  final int quantity;

  CartItemModel({required this.product, required this.quantity});

  factory CartItemModel.fromEntity(CartItem item) {
    return CartItemModel(product: ProductModel.fromEntity(item.product), quantity: item.quantity);
  }

  CartItem toEntity() {
    return CartItem(product: product, quantity: quantity);
  }
}
