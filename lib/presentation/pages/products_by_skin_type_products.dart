import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../bloc/products/products_bloc.dart';
import '../pages/filter_page.dart';
import '../widgets/products_list.dart';

class ProductsBySkinTypeProductsPage extends StatefulWidget {
  final String skinType;

  const ProductsBySkinTypeProductsPage({required this.skinType});

  @override
  _ProductsBySkinTypeProductsPageState createState() =>
      _ProductsBySkinTypeProductsPageState();
}

class _ProductsBySkinTypeProductsPageState
    extends State<ProductsBySkinTypeProductsPage> {
  String selectedEffect = '';

  final Map<String, String> effectMapping = {
    'Очищение': 'Очищение',
    'Увлажнение': 'Увлажнение',
    'Регенерация': 'Омоложение',
  };

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (_) =>
              GetIt.I<ProductsBloc>()
                ..add(FilterProductsBySkinTypeEvent(widget.skinType)),
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
            'Средства\nдля ${widget.skinType} кожи',
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          _FilterChip(
                            label: 'Очищение',
                            selected: selectedEffect == 'Очищение',
                            onSelected: () => _onEffectSelected('Очищение'),
                          ),
                          SizedBox(width: 8),
                          _FilterChip(
                            label: 'Увлажнение',
                            selected: selectedEffect == 'Увлажнение',
                            onSelected: () => _onEffectSelected('Увлажнение'),
                          ),
                          SizedBox(width: 8),
                          _FilterChip(
                            label: 'Регенерация',
                            selected: selectedEffect == 'Омоложение',
                            onSelected: () => _onEffectSelected('Омоложение'),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(),

                  SizedBox(),
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
                  return Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${state.products.length} продуктов',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[600],
                                ),
                              ),
                              GestureDetector(
                                onTap: () async {
                                  final result = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder:
                                          (_) => FilterPage(
                                            initialSkinType: widget.skinType,
                                          ),
                                    ),
                                  );
                                  if (result != null &&
                                      result is Map<String, String>) {
                                    final effect = result['effect'] ?? '';
                                    final skinType =
                                        result['skinType'] ?? widget.skinType;

                                    setState(() {
                                      selectedEffect = effect;
                                    });

                                    if (effect.isEmpty) {
                                      context.read<ProductsBloc>().add(
                                        FilterProductsBySkinTypeEvent(
                                          _mapSkinTypeForBloc(skinType),
                                        ),
                                      );
                                    } else {
                                      context.read<ProductsBloc>().add(
                                        FilterProductsByEffectEvent(
                                          effect,
                                          _mapSkinTypeForBloc(skinType),
                                        ),
                                      );
                                    }
                                  }
                                },
                                child: Container(
                                  padding: EdgeInsets.all(6),
                                  child: Icon(
                                    Icons.tune,
                                    size: 18,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 16),
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
                  return Expanded(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.error_outline,
                            size: 48,
                            color: Colors.grey,
                          ),
                          SizedBox(height: 16),
                          Text(
                            state.message,
                            style: TextStyle(color: Colors.grey[600]),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  );
                }
                return SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }

  void _onEffectSelected(String effect) {
    setState(() {
      if (selectedEffect == effect) {
        selectedEffect = '';
        context.read<ProductsBloc>().add(
          FilterProductsBySkinTypeEvent(_mapSkinTypeForBloc(widget.skinType)),
        );
      } else {
        selectedEffect = effect;

        context.read<ProductsBloc>().add(
          FilterProductsByEffectEvent(
            effect,
            _mapSkinTypeForBloc(widget.skinType),
          ),
        );
      }
    });
  }

  String _mapSkinTypeForBloc(String skinType) {
    switch (skinType) {
      case 'Жирная':
        return 'жирной';
      case 'Комбинированная':
        return 'комбинированной';
      case 'Нормальная':
        return 'нормальной';
      case 'Сухая':
        return 'сухой';
      case 'Чувствительная':
        return 'чувствительной';
      default:
        return skinType.toLowerCase();
    }
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onSelected;

  const _FilterChip({
    required this.label,
    required this.selected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onSelected,
      child: Container(
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
            fontWeight: selected ? FontWeight.w500 : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
