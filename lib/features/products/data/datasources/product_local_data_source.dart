import '../mock/mock_products.dart';
import '../models/product_model.dart';

class ProductLocalDataSource {
  Future<List<ProductModel>> getProducts() async {
    await Future.delayed(const Duration(milliseconds: 700));
    return mockProducts;
  }

  Future<ProductModel> getProductById(String id) async {
    return mockProducts.firstWhere((product) => product.id == id);
  }

  Future<List<ProductModel>> refreshProducts() async {
    await Future.delayed(const Duration(milliseconds: 1500));
    return mockProducts;
  }
}
