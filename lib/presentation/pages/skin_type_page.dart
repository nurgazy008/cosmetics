import 'package:flutter/material.dart';

class SkinTypePage extends StatelessWidget {
  final List<String> skinTypes = [
    'Жирная',
    'Комбинированная',
    'Нормальная',
    'Сухая',
    'Любой тип',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'По типу кожи',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: ListView.separated(
        itemCount: skinTypes.length,
        separatorBuilder:
            (_, __) => Divider(height: 0, color: Color(0xFFE5E5E5)),
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
              skinTypes[index],
              style: TextStyle(fontSize: 18, color: Colors.black),
            ),
            onTap: () => Navigator.pop(context, skinTypes[index]),
          );
        },
      ),
    );
  }
}
