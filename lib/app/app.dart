import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../features/auth/data/datasources/auth_local_data_source.dart';
import '../features/auth/data/repositories/auth_repository_impl.dart';
import '../features/auth/domain/repositories/auth_repository.dart';
import '../features/auth/presentation/bloc/auth_bloc.dart';
import '../features/cart/data/datasources/cart_local_data_source.dart';
import '../features/cart/data/repositories/cart_repository_impl.dart';
import '../features/cart/domain/repositories/cart_repository.dart';
import '../features/cart/presentation/bloc/cart_bloc.dart';
import '../features/products/data/datasources/product_local_data_source.dart';
import '../features/products/data/repositories/product_repository_impl.dart';
import '../features/products/domain/repositories/product_repository.dart';
import '../features/products/presentation/bloc/product_bloc.dart';
import 'routes/app_router.dart';
import 'theme/app_theme.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late final GoRouter _router;

  late final AuthRepository _authRepository;
  late final ProductRepository _productRepository;
  late final CartRepository _cartRepository;
  @override
  void initState() {
    super.initState();

    _authRepository = AuthRepositoryImpl(AuthLocalDataSource());
    _productRepository = ProductRepositoryImpl(ProductLocalDataSource());
    _cartRepository = CartRepositoryImpl(CartLocalDataSource());
    _router = AppRouter.createRouter(observers: const []);
  }

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: _authRepository),
        RepositoryProvider.value(value: _productRepository),
        RepositoryProvider.value(value: _cartRepository),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => AuthBloc(_authRepository)),
          BlocProvider(create: (_) => ProductBloc(_productRepository)),
          BlocProvider(create: (_) => CartBloc(_cartRepository)..add(const LoadCart())),
        ],
        child: MaterialApp.router(
          title: 'E-Commerce App using BLoC and Hive',
          debugShowCheckedModeBanner: false,
          themeMode: ThemeMode.system,
          theme: AppTheme.light,
          darkTheme: AppTheme.dark,
          routerConfig: _router,
        ),
      ),
    );
  }
}
