// catalog_page.dart
import 'package:cosmetics/presentation/pages/products_by_skin_type_products.dart';
import 'package:cosmetics/presentation/pages/skin_type_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../bloc/products/products_bloc.dart';
import '../widgets/products_list.dart';

class CatalogPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Поиск',
                  hintStyle: TextStyle(color: Colors.grey[600]),
                  prefixIcon: Icon(Icons.search, color: Colors.grey[600]),
                  filled: true,
                  fillColor: Color(0xFFF2F2F7),
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 0,
                    horizontal: 16,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 0),
                children: [
                  _MenuItem(
                    title: 'Назначение',
                    onTap: () => _openStub(context, 'Назначение'),
                  ),
                  _MenuItem(
                    title: 'Тип средства',
                    onTap: () => _openStub(context, 'Тип средства'),
                  ),
                  _MenuItem(
                    title: 'Тип кожи',
                    onTap: () async {
                      final selectedSkinType = await Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => SkinTypePage()),
                      );
                      if (selectedSkinType != null) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (_) => ProductsBySkinTypeProductsPage(
                                  skinType: selectedSkinType,
                                ),
                          ),
                        );
                      }
                    },
                  ),
                  _MenuItem(
                    title: 'Линия косметики',
                    onTap: () => _openStub(context, 'Линия косметики'),
                  ),
                  _MenuItem(
                    title: 'Наборы',
                    onTap: () => _openStub(context, 'Наборы'),
                  ),
                  _MenuItem(
                    title: 'Акции 🌸',
                    onTap: () => _openStub(context, 'Акции'),
                    accent: true,
                  ),
                  _MenuItem(
                    title: 'Консультация с косметологом',
                    onTap: () => _openStub(context, 'Консультация'),
                    multiline: true,
                  ),
                  SizedBox(height: 16),
                  _CareRoutineBlock(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _openStub(BuildContext context, String title) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => StubPage(title: title)),
    );
  }
}

class _MenuItem extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final bool accent;
  final bool multiline;
  const _MenuItem({
    required this.title,
    required this.onTap,
    this.accent = false,
    this.multiline = false,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          contentPadding: EdgeInsets.symmetric(
            horizontal: 24,
            vertical: multiline ? 8 : 0,
          ),
          title: Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: accent ? Colors.pink : Colors.black,
              height: multiline ? 1.2 : 1.0,
            ),
          ),
          trailing: Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
          onTap: onTap,
        ),
        Divider(
          height: 0,
          thickness: 0.5,
          indent: 24,
          endIndent: 24,
          color: Color(0xFFE5E5E5),
        ),
      ],
    );
  }
}

class _CareRoutineBlock extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Color(0xFFF8F8F8),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Составим схему идеального\nдомашнего ухода',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              height: 1.3,
            ),
          ),
          SizedBox(height: 8),
          Text(
            '10 вопросов о вашей коже',
            style: TextStyle(fontSize: 14, color: Colors.grey[600]),
          ),
          SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                padding: EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                'Пройти тест',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class StubPage extends StatelessWidget {
  final String title;
  const StubPage({required this.title});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(child: Text('Заглушка для "$title"')),
    );
  }
}

class ProductsByCategoryPage extends StatelessWidget {
  final String categoryType;
  final String title;

  const ProductsByCategoryPage({
    Key? key,
    required this.categoryType,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetIt.I<ProductsBloc>()..add(LoadProductsEvent()),
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
            title,
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              icon: Icon(Icons.tune, color: Colors.black),
              onPressed: () => _showFilters(context),
            ),
          ],
        ),
        body: BlocBuilder<ProductsBloc, ProductsState>(
          builder: (context, state) {
            if (state is ProductsLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is ProductsLoaded) {
              final products = state.products;
              if (products.isEmpty) {
                return Center(child: Text('Нет товаров'));
              }
              return Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: ProductsList(products: products),
              );
            } else if (state is ProductsError) {
              return Center(child: Text(state.message));
            }
            return Container();
          },
        ),
      ),
    );
  }

  void _showFilters(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FilterPage(categoryType: categoryType),
      ),
    );
  }
}


class FilterPage extends StatefulWidget {
  final String categoryType;

  const FilterPage({Key? key, required this.categoryType}) : super(key: key);

  @override
  _FilterPageState createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  String selectedSort = 'По популярности';
  String selectedSkinType = 'Жирная';
  String selectedProductType = 'Все';
  String selectedSkinProblem = 'Не выбрано';
  String selectedEffect = 'Увлажнение';
  String selectedBrandLine = 'Все';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Фильтры',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(16),
              children: [
                _buildFilterSection(
                  'Сортировка',
                  selectedSort,
                  ['По популярности', 'По цене', 'По новизне', 'По рейтингу'],
                  (value) => setState(() => selectedSort = value),
                ),
                _buildFilterSection(
                  'Тип кожи',
                  selectedSkinType,
                  [
                    'Жирная',
                    'Комбинированная',
                    'Нормальная',
                    'Сухая',
                    'Чувствительная',
                  ],
                  (value) => setState(() => selectedSkinType = value),
                ),
                _buildFilterSection(
                  'Тип средства',
                  selectedProductType,
                  ['Все', 'Сыворотка', 'Крем', 'Тонер', 'Маска', 'Пенка'],
                  (value) => setState(() => selectedProductType = value),
                ),
                _buildFilterSection(
                  'Проблема кожи',
                  selectedSkinProblem,
                  ['Не выбрано', 'Акне', 'Пигментация', 'Морщины', 'Сухость'],
                  (value) => setState(() => selectedSkinProblem = value),
                ),
                _buildFilterSection(
                  'Эффект средства',
                  selectedEffect,
                  ['Увлажнение', 'Питание', 'Очищение', 'Омоложение'],
                  (value) => setState(() => selectedEffect = value),
                ),
                _buildFilterSection(
                  'Линия косметики',
                  selectedBrandLine,
                  ['Все', 'Premium', 'Basic', 'Professional'],
                  (value) => setState(() => selectedBrandLine = value),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, {
                    'effect': selectedEffect,
                    'skinType': selectedSkinType,
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'Применить фильтры',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterSection(
    String title,
    String selectedValue,
    List<String> options,
    Function(String) onChanged,
  ) {
    return Container(
      margin: EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 12),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Color(0xFFF2F2F7),
              borderRadius: BorderRadius.circular(12),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: selectedValue,
                isExpanded: true,
                icon: Icon(Icons.keyboard_arrow_down, color: Colors.grey),
                style: TextStyle(fontSize: 16, color: Colors.black),
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    onChanged(newValue);
                  }
                },
                items:
                    options.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _applyFilters() {
    // Apply filters logic
    Map<String, String> filters = {
      'sort': selectedSort,
      'skinType': selectedSkinType,
      'productType': selectedProductType,
      'skinProblem': selectedSkinProblem,
      'effect': selectedEffect,
      'brandLine': selectedBrandLine,
    };

    Navigator.pop(context, filters);
  }
}

class ProductsBySkinTypeProductsPage extends StatefulWidget {
  final String skinType;
  const ProductsBySkinTypeProductsPage({required this.skinType});

  @override
  State<ProductsBySkinTypeProductsPage> createState() => _ProductsBySkinTypeProductsPageState();
}

class _ProductsBySkinTypeProductsPageState extends State<ProductsBySkinTypeProductsPage> {
  String selectedEffect = 'Очищение';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GetIt.I<ProductsBloc>()..add(FilterProductsBySkinTypeEvent(widget.skinType)),
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
            'Продукты для кожи типа "${widget.skinType}"',
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          centerTitle: true,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  _FilterChip(
                    label: 'Очищение',
                    selected: selectedEffect == 'Очищение',
                    onTap: () => _onEffectSelected(context, 'Очищение'),
                  ),
                  SizedBox(width: 8),
                  _FilterChip(
                    label: 'Увлажнение',
                    selected: selectedEffect == 'Увлажнение',
                    onTap: () => _onEffectSelected(context, 'Увлажнение'),
                  ),
                  SizedBox(width: 8),
                  _FilterChip(
                    label: 'Регенерация',
                    selected: selectedEffect == 'Регенерация',
                    onTap: () => _onEffectSelected(context, 'Регенерация'),
                  ),
                ],
              ),
            ),
            Expanded(
              child: BlocBuilder<ProductsBloc, ProductsState>(
                builder: (context, state) {
                  if (state is ProductsLoading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is ProductsLoaded) {
                    final products = state.products;
                    if (products.isEmpty) {
                      return Center(child: Text('Нет товаров'));
                    }
                    return Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: ProductsList(products: products),
                    );
                  } else if (state is ProductsError) {
                    return Center(child: Text(state.message));
                  }
                  return Container();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onEffectSelected(BuildContext context, String effect) {
    setState(() {
      selectedEffect = effect;
    });
    // Диспатчим новое событие фильтрации
    context.read<ProductsBloc>().add(FilterProductsByEffectEvent(effect, widget.skinType));
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;
  const _FilterChip({required this.label, this.selected = false, required this.onTap});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
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
          ),
        ),
      ),
    );
  }
}
