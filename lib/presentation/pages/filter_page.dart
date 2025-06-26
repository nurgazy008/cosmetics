import 'package:flutter/material.dart';

class FilterPage extends StatefulWidget {
  final String initialSkinType;
  const FilterPage({required this.initialSkinType});

  @override
  _FilterPageState createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  late String selectedSkinType;
  late String selectedEffect;

  @override
  void initState() {
    super.initState();
    selectedSkinType = widget.initialSkinType;
    selectedEffect = 'Увлажнение';
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
                _buildSectionHeader('Тип кожи'),
                _buildSkinTypeOptions(),
                SizedBox(height: 24),
                _buildSectionHeader('Эффект средства'),
                _buildEffectOptions(),
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

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _buildSkinTypeOptions() {
    final skinTypes = [
      'Жирная',
      'Комбинированная',
      'Нормальная',
      'Сухая',
      'Чувствительная',
    ];

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: skinTypes.map((type) {
        return ChoiceChip(
          label: Text(type),
          selected: selectedSkinType == type,
          onSelected: (selected) {
            setState(() {
              selectedSkinType = type;
            });
          },
          selectedColor: Colors.black,
          backgroundColor: Color(0xFFF2F2F7),
          labelStyle: TextStyle(
            color: selectedSkinType == type ? Colors.white : Colors.black,
          ),
        );
      }).toList(),
    );
  }

  Widget _buildEffectOptions() {
    final effects = [
      'Увлажнение',
      'Питание',
      'Очищение',
      'Омоложение',
    ];

    return Column(
      children: effects.map((effect) {
        return ListTile(
          title: Text(effect),
          leading: Radio<String>(
            value: effect,
            groupValue: selectedEffect,
            onChanged: (value) {
              setState(() {
                selectedEffect = value!;
              });
            },
            activeColor: Colors.black,
          ),
          onTap: () {
            setState(() {
              selectedEffect = effect;
            });
          },
        );
      }).toList(),
    );
  }
}
