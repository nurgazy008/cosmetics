import 'package:flutter/material.dart';

class FilterPage extends StatefulWidget {
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
            fontWeight: FontWeight.bold,
            fontSize: 20,
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
                _buildFilterRow(
                  'Сортировка',
                  selectedSort,
                  () => _selectOption('Сортировка', [
                    'По популярности',
                    'По цене',
                    'По новизне',
                    'По рейтингу',
                  ], (v) => setState(() => selectedSort = v)),
                ),
                _buildFilterRow(
                  'Тип кожи',
                  selectedSkinType,
                  () => _selectOption('Тип кожи', [
                    'Жирная',
                    'Комбинированная',
                    'Нормальная',
                    'Сухая',
                    'Чувствительная',
                  ], (v) => setState(() => selectedSkinType = v)),
                ),
                _buildFilterRow(
                  'Тип средства',
                  selectedProductType,
                  () => _selectOption('Тип средства', [
                    'Все',
                    'Сыворотка',
                    'Крем',
                    'Тонер',
                    'Маска',
                    'Пенка',
                  ], (v) => setState(() => selectedProductType = v)),
                ),
                _buildFilterRow(
                  'Проблема кожи',
                  selectedSkinProblem,
                  () => _selectOption('Проблема кожи', [
                    'Не выбрано',
                    'Акне',
                    'Пигментация',
                    'Морщины',
                    'Сухость',
                  ], (v) => setState(() => selectedSkinProblem = v)),
                ),
                _buildFilterRow(
                  'Эффект средства',
                  selectedEffect,
                  () => _selectOption('Эффект средства', [
                    'Увлажнение',
                    'Питание',
                    'Очищение',
                    'Омоложение',
                  ], (v) => setState(() => selectedEffect = v)),
                ),
                _buildFilterRow(
                  'Линия косметики',
                  selectedBrandLine,
                  () => _selectOption('Линия косметики', [
                    'Все',
                    'Premium',
                    'Basic',
                    'Professional',
                  ], (v) => setState(() => selectedBrandLine = v)),
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
                    'sort': selectedSort,
                    'productType': selectedProductType,
                    'skinProblem': selectedSkinProblem,
                    'brandLine': selectedBrandLine,
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

  Widget _buildFilterRow(String title, String value, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: TextStyle(fontSize: 16, color: Colors.black)),
            Text(value, style: TextStyle(fontSize: 16, color: Colors.grey)),
          ],
        ),
      ),
    );
  }

  void _selectOption(
    String title,
    List<String> options,
    Function(String) onSelected,
  ) async {
    final result = await showModalBottomSheet<String>(
      context: context,
      builder: (context) {
        return ListView(
          children:
              options
                  .map(
                    (option) => ListTile(
                      title: Text(option),
                      onTap: () => Navigator.pop(context, option),
                    ),
                  )
                  .toList(),
        );
      },
    );
    if (result != null) onSelected(result);
  }
}
