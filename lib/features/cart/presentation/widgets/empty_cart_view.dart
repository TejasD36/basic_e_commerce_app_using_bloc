import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/routes/route_name.dart';

class EmptyCartView extends StatelessWidget {
  const EmptyCartView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.shopping_cart_outlined, size: 72),
            const SizedBox(height: 16),
            Text('Your cart is empty', style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 8),
            Text('Add some products to continue shopping', textAlign: TextAlign.center, style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                context.go(AppRoute.products.path);
              },
              child: const Text('Browse Products'),
            ),
          ],
        ),
      ),
    );
  }
}
