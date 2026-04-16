import 'package:hive_ce_flutter/hive_flutter.dart';

import '../../domain/entities/product.dart';

part 'product_model.g.dart';

@HiveType(typeId: 0)
class ProductModel extends Product {
  @HiveField(0)
  final String productId;

  @HiveField(1)
  final String productTitle;

  @HiveField(2)
  final String productDescription;

  @HiveField(3)
  final double productPrice;

  @HiveField(4)
  final String productImageUrl;

  @HiveField(5)
  final double productRating;

  @HiveField(6)
  final bool productInStock;

  const ProductModel({
    required this.productId,
    required this.productTitle,
    required this.productDescription,
    required this.productPrice,
    required this.productImageUrl,
    required this.productRating,
    required this.productInStock,
  }) : super(
         id: productId,
         title: productTitle,
         description: productDescription,
         price: productPrice,
         imageUrl: productImageUrl,
         rating: productRating,
         inStock: productInStock,
       );

  factory ProductModel.fromEntity(Product product) {
    return ProductModel(
      productId: product.id,
      productTitle: product.title,
      productDescription: product.description,
      productPrice: product.price,
      productImageUrl: product.imageUrl,
      productRating: product.rating,
      productInStock: product.inStock,
    );
  }
}
