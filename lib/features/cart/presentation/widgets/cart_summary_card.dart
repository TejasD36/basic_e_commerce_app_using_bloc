import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/routes/route_name.dart';
import '../bloc/cart_bloc.dart';

class CartSummaryCard extends StatelessWidget {
  final CartLoaded state;

  const CartSummaryCard({required this.state, super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    Widget row(String title, double value, {bool isTotal = false}) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          children: [
            Text(title, style: isTotal ? theme.textTheme.titleMedium : theme.textTheme.bodyMedium),
            const Spacer(),
            Text(
              '₹${value.toStringAsFixed(2)}',
              style: (isTotal ? theme.textTheme.titleMedium : theme.textTheme.bodyMedium)?.copyWith(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      );
    }

    return SafeArea(
      top: false,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          border: Border(top: BorderSide(color: theme.colorScheme.outlineVariant)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            row('Subtotal', state.subtotal),
            row('Tax (5%)', state.tax),
            const Divider(height: 24),
            row('Total', state.total, isTotal: true),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  context.read<CartBloc>().add(const ClearCart());

                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Order placed successfully')));

                  context.go(AppRoute.products.path);
                },
                child: const Text('Checkout'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
