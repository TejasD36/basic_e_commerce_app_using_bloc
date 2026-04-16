enum AppRoute {
  splash('/', 'splash'),
  login('/login', 'login'),
  products('/products', 'products'),
  cart('/cart', 'cart'),
  productDetails('/product', 'productDetails');

  final String path;
  final String name;

  const AppRoute(this.path, this.name);
}
