import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/product_bloc.dart';
import '../bloc/product_sort_type.dart';

class ProductSortDropdown extends StatelessWidget {
  const ProductSortDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
      buildWhen: (previous, current) => current is ProductLoaded,
      builder: (context, state) {
        final selectedSort = state is ProductLoaded ? state.selectedSort : ProductSortType.none;

        return DropdownButtonHideUnderline(
          child: DropdownButton<ProductSortType>(
            value: selectedSort,
            icon: const Icon(Icons.sort),
            borderRadius: BorderRadius.circular(12),
            items: const [
              DropdownMenuItem(value: ProductSortType.none, child: Text('Default')),
              DropdownMenuItem(value: ProductSortType.priceLowToHigh, child: Text('Price ↑')),
              DropdownMenuItem(value: ProductSortType.priceHighToLow, child: Text('Price ↓')),
              DropdownMenuItem(value: ProductSortType.nameAZ, child: Text('Name A-Z')),
            ],
            onChanged: (value) {
              if (value == null) return;

              context.read<ProductBloc>().add(SortProducts(value));
            },
          ),
        );
      },
    );
  }
}
