import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/cart_item.dart';
import '../bloc/cart_bloc.dart';

class CartItemTile extends StatelessWidget {
  final CartItem item;

  const CartItemTile({required this.item, super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(item.product.imageUrl, width: 80, height: 80, fit: BoxFit.cover),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.product.title, maxLines: 2, overflow: TextOverflow.ellipsis, style: theme.textTheme.titleSmall),
                  const SizedBox(height: 6),
                  Text(
                    '₹${item.product.price.toStringAsFixed(0)}',
                    style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.primary, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          context.read<CartBloc>().add(UpdateQuantity(productId: item.product.id, quantity: item.quantity - 1));
                        },
                        icon: const Icon(Icons.remove_circle_outline),
                      ),
                      Text(item.quantity.toString(), style: theme.textTheme.titleMedium),
                      IconButton(
                        onPressed: () {
                          context.read<CartBloc>().add(UpdateQuantity(productId: item.product.id, quantity: item.quantity + 1));
                        },
                        icon: const Icon(Icons.add_circle_outline),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: () {
                context.read<CartBloc>().add(RemoveItem(item.product.id));
              },
              icon: Icon(Icons.delete_outline, color: theme.colorScheme.error),
            ),
          ],
        ),
      ),
    );
  }
}
