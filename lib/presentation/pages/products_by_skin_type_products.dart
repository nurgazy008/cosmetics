import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../bloc/products/products_bloc.dart';
import '../pages/filter_page.dart';
import '../widgets/products_list.dart';

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
            'Средства\nдля $skinType кожи',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 22,
              height: 1.2,
            ),
          ),
          centerTitle: false,
          toolbarHeight: 80,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🟡 FILTER CHIPS + ICON ROW
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // ✅ Chips
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          _FilterChip(label: 'Очищение'),
                          SizedBox(width: 8),
                          _FilterChip(label: 'Увлажнение', selected: true),
                          SizedBox(width: 8),
                          _FilterChip(label: 'Регенерация'),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 12),
                  // ✅ Фильтр иконка
                  GestureDetector(
                    onTap: () async {
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => FilterPage(initialSkinType: skinType),
                        ),
                      );
                      if (result is Map<String, String>) {
                        context.read<ProductsBloc>().add(
                          FilterProductsByEffectEvent(
                            result['effect'] ?? '',
                            result['skinType'] ?? skinType,
                          ),
                        );
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        Icons.filter_list,
                        size: 20,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 12),
            // 🟩 PRODUCTS LIST
            BlocBuilder<ProductsBloc, ProductsState>(
              builder: (context, state) {
                if (state is ProductsLoading) {
                  return Expanded(
                    child: Center(child: CircularProgressIndicator()),
                  );
                } else if (state is ProductsLoaded) {
                  return Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            '${state.products.length} продуктов',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: ProductsList(products: state.products),
                          ),
                        ),
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
    return FilterChip(
      label: Text(label),
      selected: selected,
      onSelected: (_) {},
      backgroundColor: Color(0xFFF2F2F7),
      selectedColor: Colors.black,
      labelStyle: TextStyle(
        color: selected ? Colors.white : Colors.black,
        fontSize: 14,
      ),
      shape: StadiumBorder(),
    );
  }
}
