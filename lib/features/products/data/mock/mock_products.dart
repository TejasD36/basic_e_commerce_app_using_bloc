import '../models/product_model.dart';

final mockProducts = [
  ProductModel(
    productId: '1',
    productTitle: 'Wireless Headphones',
    productDescription: 'Premium noise cancelling headphones with deep bass.',
    productPrice: 2999,
    productImageUrl: 'https://picsum.photos/400?1',
    productRating: 4.6,
    productInStock: true,
  ),
  ProductModel(
    productId: '2',
    productTitle: 'Smart Watch',
    productDescription: 'Fitness tracking smart watch with AMOLED display.',
    productPrice: 4999,
    productImageUrl: 'https://picsum.photos/400?2',
    productRating: 4.4,
    productInStock: true,
  ),
  ProductModel(
    productId: '3',
    productTitle: 'Bluetooth Speaker',
    productDescription: 'Portable speaker with powerful sound and battery.',
    productPrice: 1999,
    productImageUrl: 'https://picsum.photos/400?3',
    productRating: 4.2,
    productInStock: false,
  ),
];
