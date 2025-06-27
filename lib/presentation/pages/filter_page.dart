import 'package:flutter/material.dart';

class FilterPage extends StatefulWidget {
  final String initialSkinType;
  const FilterPage({required this.initialSkinType});

  @override
  _FilterPageState createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  late String selectedSkinType;
  String selectedEffect = '';
  String selectedSort = 'По популярности';
  String selectedProductType = 'Все';
  String selectedSkinProblem = 'Не выбрано';
  String selectedBrand = 'Все';

  // Map display names to internal values
  final Map<String, String> skinTypeMapping = {
    'жирной': 'Жирная',
    'комбинированной': 'Комбинированная', 
    'нормальной': 'Нормальная',
    'сухой': 'Сухая',
    'чувствительной': 'Чувствительная',
  };

  @override
  void initState() {
    super.initState();
   
    selectedSkinType = _mapSkinType(widget.initialSkinType);
  }

  String _mapSkinType(String skinType) {
   
    String lowerType = skinType.toLowerCase();
    for (String key in skinTypeMapping.keys) {
      if (lowerType.contains(key)) {
        return skinTypeMapping[key]!;
      }
    }
    return 'Жирная';
  }

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
                _buildFilterRow('Сортировка', selectedSort, ['По популярности', 'По цене', 'По рейтингу']),
                SizedBox(height: 20),
                _buildFilterRow('Тип кожи', selectedSkinType, ['Жирная', 'Комбинированная', 'Нормальная', 'Сухая', 'Чувствительная']),
                SizedBox(height: 20),
                _buildFilterRow('Тип средства', selectedProductType, ['Все', 'Сыворотка', 'Тоник', 'Крем', 'Очищающее']),
                SizedBox(height: 20),
                _buildFilterRow('Проблема кожи', selectedSkinProblem, ['Не выбрано', 'Акне', 'Пигментация', 'Морщины', 'Сухость']),
                SizedBox(height: 20),
                _buildFilterRow('Эффект средства', selectedEffect, ['', 'Увлажнение', 'Питание', 'Очищение', 'Омоложение']),
                SizedBox(height: 20),
                _buildFilterRow('Линия косметики', selectedBrand, ['Все', 'Unstress', 'Revitalizing', 'Premium']),
              ],
            ),
          ),
          Padding(
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
                    'brand': selectedBrand,
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

  Widget _buildFilterRow(String title, String selectedValue, List<String> options) {
   
    String displayValue = selectedValue;
    if (title == 'Эффект средства' && selectedValue.isEmpty) {
      displayValue = 'Увлажнение'; 
    }
    
    return GestureDetector(
      onTap: () => _showFilterBottomSheet(title, selectedValue, options),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 0),
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey[200]!, width: 1)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            Row(
              children: [
                Text(
                  displayValue,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(width: 8),
                Icon(Icons.chevron_right, color: Colors.grey[400], size: 20),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showFilterBottomSheet(String title, String currentValue, List<String> options) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 20),
              ...options.map((option) {
                String displayOption = option;
                if (title == 'Эффект средства' && option.isEmpty) {
                  return SizedBox.shrink(); 
                }
                
                return ListTile(
                  title: Text(
                    displayOption,
                    style: TextStyle(fontSize: 16),
                  ),
                  trailing: currentValue == option 
                    ? Icon(Icons.check, color: Colors.black)
                    : null,
                  onTap: () {
                    setState(() {
                      switch (title) {
                        case 'Сортировка':
                          selectedSort = option;
                          break;
                        case 'Тип кожи':
                          selectedSkinType = option;
                          break;
                        case 'Тип средства':
                          selectedProductType = option;
                          break;
                        case 'Проблема кожи':
                          selectedSkinProblem = option;
                          break;
                        case 'Эффект средства':
                          selectedEffect = option;
                          break;
                        case 'Линия косметики':
                          selectedBrand = option;
                          break;
                      }
                    });
                    Navigator.pop(context);
                  },
                );
              }).toList(),
            ],
          ),
        );
      },
    );
  }
}