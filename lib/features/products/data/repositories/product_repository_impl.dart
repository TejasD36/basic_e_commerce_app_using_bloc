import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';
import '../datasources/product_local_data_source.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductLocalDataSource localDataSource;

  ProductRepositoryImpl(this.localDataSource);

  @override
  Future<List<Product>> getProducts() async {
    return localDataSource.getProducts();
  }

  @override
  Future<Product> getProductById(String id) async {
    return localDataSource.getProductById(id);
  }

  @override
  Future<List<Product>> refreshProducts() async {
    return localDataSource.refreshProducts();
  }
}
