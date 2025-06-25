import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../bloc/products/products_bloc.dart';
import '../widgets/products_list.dart';
import '../pages/filter_page.dart';

class ProductsBySkinTypeProductsPage extends StatelessWidget {
  final String skinType;
  const ProductsBySkinTypeProductsPage({required this.skinType});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (_) =>
              GetIt.I<ProductsBloc>()
                ..add(FilterProductsBySkinTypeEvent(skinType)),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(
            'Средства для $skinType кожи',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              icon: Icon(Icons.tune, color: Colors.black),
              onPressed: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => FilterPage()),
                );
                if (result != null && result is Map<String, String>) {
                  final effect = result['effect'] ?? '';
                  final skinType = result['skinType'] ?? this.skinType;
                  context.read<ProductsBloc>().add(FilterProductsByEffectEvent(effect, skinType));
                }
              },
            ),
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  _FilterChip(label: 'Очищение', selected: true),
                  SizedBox(width: 8),
                  _FilterChip(label: 'Увлажнение'),
                  SizedBox(width: 8),
                  _FilterChip(label: 'Регенерация'),
                ],
              ),
            ),
            BlocBuilder<ProductsBloc, ProductsState>(
              builder: (context, state) {
                if (state is ProductsLoading) {
                  return Expanded(
                    child: Center(child: CircularProgressIndicator()),
                  );
                } else if (state is ProductsLoaded) {
                  final products = state.products;
                  return Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 4,
                          ),
                          child: Text(
                            '${products.length} продуктов',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                        ),
                        Expanded(child: ProductsList(products: products)),
                      ],
                    ),
                  );
                } else if (state is ProductsError) {
                  return Expanded(child: Center(child: Text(state.message)));
                }
                return SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool selected;
  const _FilterChip({required this.label, this.selected = false});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: selected ? Colors.black : Color(0xFFF2F2F7),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: selected ? Colors.white : Colors.black,
          fontSize: 14,
        ),
      ),
    );
  }
}
