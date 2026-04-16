import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'routes/app_router.dart';
import 'theme/app_theme.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  AppState createState() => AppState();
}

class AppState extends State<App> {
  late final GoRouter _router;

  @override
  void initState() {
    super.initState();

    _router = AppRouter.createRouter(observers: const []);
  }

  @override
  Widget build(BuildContext context) {
    //This is copy pasted from old project which used riverpod
    //final GoRouter router = ref.watch(routerProvider);
    //  final themeMode = ref.watch(themeModeProvider).value ?? ThemeMode.system;

    return LayoutBuilder(
      builder: (context, BoxConstraints constraints) {
        return OrientationBuilder(
          builder: (BuildContext context, Orientation orientation) {
            return MaterialApp.router(
              title: 'E-Commerce App using BLoC and Hive',
              debugShowCheckedModeBanner: false,
              themeMode: ThemeMode.system,
              theme: AppTheme.light,
              darkTheme: AppTheme.dark,
              themeAnimationStyle: TreeSliver.defaultToggleAnimationStyle,
              themeAnimationDuration: const Duration(milliseconds: 300),
              themeAnimationCurve: Curves.easeInOut,
              routerConfig: _router,
            );
          },
        );
      },
    );
  }
}
