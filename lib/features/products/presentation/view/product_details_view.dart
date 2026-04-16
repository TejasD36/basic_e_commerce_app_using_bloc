import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../cart/presentation/bloc/cart_bloc.dart';
import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';

class ProductDetailsView extends StatefulWidget {
  final String productId;

  const ProductDetailsView({required this.productId, super.key});

  @override
  State<ProductDetailsView> createState() => _ProductDetailsViewState();
}

class _ProductDetailsViewState extends State<ProductDetailsView> {
  Product? _product;
  bool _isLoading = true;
  String? _error;
  int _quantity = 1;

  @override
  void initState() {
    super.initState();
    _loadProduct();
  }

  Future<void> _loadProduct() async {
    try {
      final repository = context.read<ProductRepository>();

      final product = await repository.getProductById(widget.productId);

      if (!mounted) return;

      setState(() {
        _product = product;
        _isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  void _incrementQuantity() {
    if (_quantity >= 10) return;

    setState(() {
      _quantity++;
    });
  }

  void _decrementQuantity() {
    if (_quantity <= 1) return;

    setState(() {
      _quantity--;
    });
  }

  void _addToCart() {
    if (_product == null) return;

    context.read<CartBloc>().add(AddItem(product: _product!, quantity: _quantity));

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('${_product!.title} x$_quantity added to cart')));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (_isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (_error != null) {
      return Scaffold(
        appBar: AppBar(),
        body: Center(child: Text(_error!)),
      );
    }

    final product = _product!;

    return Scaffold(
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.all(16),
        child: SizedBox(
          height: 56,
          child: ElevatedButton.icon(
            onPressed: product.inStock ? _addToCart : null,
            icon: const Icon(Icons.shopping_cart_outlined),
            label: Text(product.inStock ? 'Add $_quantity to Cart' : 'Out of Stock'),
          ),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 320,
            actions: [
              IconButton(
                onPressed: () {
                  // TODO cart navigation later
                },
                icon: const Icon(Icons.shopping_cart_outlined),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: CachedNetworkImage(
                imageUrl: product.imageUrl,
                fit: BoxFit.cover,
                placeholder: (_, __) => const Center(child: CircularProgressIndicator()),
                errorWidget: (_, __, ___) => const Icon(Icons.image_not_supported_outlined, size: 48),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 100),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(product.title, style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.surfaceContainerHighest,
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.star_rounded, color: Colors.amber, size: 18),
                            const SizedBox(width: 4),
                            Text(product.rating.toString(), style: theme.textTheme.bodyMedium),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '₹${product.price.toStringAsFixed(0)}',
                    style: theme.textTheme.headlineMedium?.copyWith(color: theme.colorScheme.primary, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: product.inStock ? Colors.green.withValues(alpha: 0.12) : Colors.red.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      product.inStock ? 'In Stock' : 'Out of Stock',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: product.inStock ? Colors.green : Colors.red,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text('Description', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700)),
                  const SizedBox(height: 8),
                  Text(product.description, style: theme.textTheme.bodyLarge?.copyWith(height: 1.6)),
                  const SizedBox(height: 32),
                  Text('Quantity', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      IconButton.filledTonal(onPressed: _decrementQuantity, icon: const Icon(Icons.remove)),
                      Container(
                        width: 56,
                        alignment: Alignment.center,
                        child: Text(_quantity.toString(), style: theme.textTheme.titleLarge),
                      ),
                      IconButton.filled(onPressed: _incrementQuantity, icon: const Icon(Icons.add)),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
