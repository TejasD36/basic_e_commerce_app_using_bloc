import 'package:hive_ce_flutter/hive_flutter.dart';

import '../models/cart_item_model.dart';

class CartLocalDataSource {
  static const _boxName = 'cart_box';
  static const _key = 'cart_items';

  Future<Box> get _box async => Hive.openBox(_boxName);

  Future<List<CartItemModel>> getCartItems() async {
    final box = await _box;

    final list = box.get(_key, defaultValue: <CartItemModel>[]);

    return List<CartItemModel>.from(list);
  }

  Future<void> saveCartItems(List<CartItemModel> items) async {
    final box = await _box;
    await box.put(_key, items);
  }

  Future<void> clearCart() async {
    final box = await _box;
    await box.delete(_key);
  }
}
