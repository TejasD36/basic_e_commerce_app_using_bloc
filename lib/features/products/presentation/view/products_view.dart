import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/routes/route_name.dart';
import '../../../cart/presentation/bloc/cart_bloc.dart';
import '../bloc/product_bloc.dart';
import '../widgets/product_card.dart';
import '../widgets/product_sort_dropdown.dart';

class ProductsView extends StatefulWidget {
  const ProductsView({super.key});

  @override
  State<ProductsView> createState() => _ProductsViewState();
}

class _ProductsViewState extends State<ProductsView> {
  @override
  void initState() {
    super.initState();

    context.read<ProductBloc>().add(LoadProducts());
  }

  Future<void> _onRefresh() async {
    context.read<ProductBloc>().add(RefreshProducts());

    await context.read<ProductBloc>().stream.firstWhere((state) => state is ProductLoaded || state is ProductError);
  }

  @override
  Widget build(BuildContext context) {
    final isTablet = MediaQuery.sizeOf(context).width >= 700;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
        actions: const [Padding(padding: EdgeInsets.only(right: 16), child: ProductSortDropdown())],
      ),
      body: RefreshIndicator(
        onRefresh: _onRefresh,
        child: BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            if (state is ProductLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is ProductError) {
              return Center(child: Text(state.message));
            }

            if (state is ProductLoaded) {
              if (state.products.isEmpty) {
                return const Center(child: Text('No products found'));
              }

              return GridView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: state.products.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: isTablet ? 3 : 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.62,
                ),
                itemBuilder: (context, index) {
                  final product = state.products[index];

                  return ProductCard(product: product);
                },
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
      floatingActionButton: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          final itemCount = state is CartLoaded ? state.items.fold<int>(0, (sum, item) => sum + item.quantity) : 0;

          return FloatingActionButton.extended(
            onPressed: () {
              context.push(AppRoute.cart.path);
            },
            icon: Stack(
              clipBehavior: Clip.none,
              children: [
                const Icon(Icons.shopping_cart_outlined),
                if (itemCount > 0)
                  Positioned(
                    top: -6,
                    right: -10,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                      decoration: BoxDecoration(color: Theme.of(context).colorScheme.error, borderRadius: BorderRadius.circular(20)),
                      child: Text(
                        itemCount > 99 ? '99+' : '$itemCount',
                        style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
              ],
            ),
            label: const Text('Cart'),
          );
        },
      ),
    );
  }
}
