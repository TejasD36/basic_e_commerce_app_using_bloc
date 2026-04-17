import '../../domain/entities/cart_item.dart';
import '../../domain/repositories/cart_repository.dart';
import '../datasources/cart_local_data_source.dart';
import '../models/cart_item_model.dart';

class CartRepositoryImpl implements CartRepository {
  final CartLocalDataSource localDataSource;

  CartRepositoryImpl(this.localDataSource);

  @override
  Future<List<CartItem>> getCartItems() async {
    final models = await localDataSource.getCartItems();

    return models.map((e) => e.toEntity()).toList();
  }

  @override
  Future<void> saveCartItems(List<CartItem> items) async {
    final models = items.map(CartItemModel.fromEntity).toList();

    await localDataSource.saveCartItems(models);
  }

  @override
  Future<void> clearCart() async {
    await localDataSource.clearCart();
  }
}
