import 'package:basic_e_commerce_app_using_bloc/features/products/presentation/view/products_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/view/login_view.dart';
import '../../features/cart/presentation/view/cart_view.dart';
import '../../features/product_details/presentation/view/product_details_view.dart';
import 'navigation_service.dart';
import 'route_name.dart';

class AppRouter {
  static GoRouter createRouter({required List<NavigatorObserver> observers}) {
    return GoRouter(
      navigatorKey: NavigationService.navigatorKey,
      initialLocation: AppRoute.splash.path,
      debugLogDiagnostics: kDebugMode,
      observers: observers,
      routes: [
        GoRoute(path: AppRoute.products.path, name: AppRoute.products.name, builder: (context, state) => const ProductsView()),
        GoRoute(
          path: '${AppRoute.productDetails.path}/:id',
          name: AppRoute.productDetails.name,
          builder: (context, state) {
            final productId = state.pathParameters['id']!;
            return ProductDetailsView(productId: productId);
          },
        ),
        GoRoute(path: AppRoute.cart.path, name: AppRoute.cart.name, builder: (context, state) => const CartView()),
        GoRoute(path: AppRoute.login.path, name: AppRoute.login.name, builder: (context, state) => const LoginView()),
      ],
    );
  }
}
