import 'package:flutter/material.dart';

import '../widgets/product_card_widget.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildPromoBanner(),
              _buildCategoriesRow(),
              _buildNewProductsSection(),
              _buildHomeCareSection(),
              _buildSalesSection(),
              _buildCareTypeButtons(),
              _buildHitsSection(),
              SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPromoBanner() {
    return Container(
      height: 200,
      margin: EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: DecorationImage(
          image: AssetImage('assets/images/cream.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.teal.withOpacity(0.8),
              Colors.teal.withOpacity(0.6),
            ],
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              left: 16,
              bottom: 60,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Скидка -15%',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Сыворотка',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  Text(
                    'НА EYE & NECK SERUM',
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ],
              ),
            ),
            Positioned(
              right: 16,
              bottom: 16,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'Перейти к акции',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoriesRow() {
    final categories = [
      {'name': 'Наборы', 'icon': 'assets/images/image 43.png'},
      {'name': 'Для лица', 'icon': 'assets/images/face.png'},
      {'name': 'Для глаз', 'icon': 'assets/images/forEye.png'},
      {'name': 'Для тела', 'icon': 'assets/images/forBody.png'},
      {'name': 'Уход', 'icon': 'assets/images/wash.png'},
    ];

    return Container(
      height: 120, // Еще больше высота
      margin: EdgeInsets.symmetric(horizontal: 16),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          final iconPath = category['icon']!;
          final isImagePath = iconPath.startsWith('assets/');

          return Container(
            width: 90, 
            margin: EdgeInsets.only(right: 16),
            child: Column(
              children: [
                Container(
                  width: 80, 
                  height: 80,
                  decoration: BoxDecoration(
                    color: Color(0xFFF5F5F5),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 8,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child:
                        isImagePath
                            ? Image.asset(
                              iconPath,
                              width: double.infinity,
                              height: double.infinity,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Center(
                                  child: Icon(
                                    Icons.image_not_supported,
                                    size: 35,
                                    color: Colors.grey[400],
                                  ),
                                );
                              },
                            )
                            : Center(
                              child: Text(
                                iconPath,
                                style: TextStyle(fontSize: 35),
                              ),
                            ),
                  ),
                ),
                SizedBox(height: 12),
                Text(
                  category['name']!,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.black87,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildNewProductsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(16),
          child: Text(
            'Новинки',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          height: 280,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 16),
            itemCount: 2,
            itemBuilder: (context, index) {
              return Container(
                width: 160,
                margin: EdgeInsets.only(right: 12),
                child: ProductCardWidget(
                  name:
                      index == 0
                          ? 'Centella Total Unscented Serum'
                          : 'Laneige Revitalizing Toner',
                  brand: index == 0 ? 'Сыворотка' : 'Тонер',
                  price: index == 0 ? '10 195 ₽' : '3095 ₽',
                  imageUrl:
                      index == 0
                          ? 'assets/images/image 36.png'
                          : 'assets/images/image 40.png',
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildHomeCareSection() {
    return Container(
      margin: EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        image: DecorationImage(
          image: AssetImage('assets/images/image 48.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Моя схема домашнего ухода',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildCareStep('Демакияж', 'assets/images/Frame 54.png'),
                _buildCareStep('Очищение', 'assets/images/Frame 54-1.png'),
                _buildCareStep('Сыворотка', 'assets/images/Frame 54-3.png'),
                _buildCareStep('Дневной крем', 'assets/images/Frame 54-2.png'),
              ],
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    'Ответьте на 10 вопросов,\nи мы подберем нужный уход',
                    style: TextStyle(fontSize: 14, color: Colors.black),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  flex: 1,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      padding: EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'Пройти тест',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCareStep(String title, String imagePath) {
    return Column(
      children: [
        Container(
          width: 70,
          height: 70,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 4,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Center(
            child: Image.asset(
              imagePath,
              width: 50,
              height: 50,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                return Icon(Icons.spa, size: 35, color: Colors.grey[400]);
              },
            ),
          ),
        ),
        SizedBox(height: 12),
        Text(
          title,
          style: TextStyle(
            fontSize: 11,
            color: Colors.black87,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildSalesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Text(
                'Акции',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(width: 8),
              Container(width: 20, height: 2, color: Colors.red),
            ],
          ),
        ),
        Container(
          height: 280,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 16),
            itemCount: 2,
            itemBuilder: (context, index) {
              return Container(
                width: 160,
                margin: EdgeInsets.only(right: 12),
                child: ProductCardWidget(
                  name:
                      index == 0
                          ? 'Muse Serum Supreme'
                          : 'Unstress Revitalizing Toner',
                  brand: index == 0 ? 'Сыворотка' : 'Крем',
                  price: index == 0 ? '10 195 ₽' : '1595 ₽',
                  originalPrice: index == 0 ? '12 000 ₽' : '3195 ₽',
                  imageUrl:
                      index == 0
                          ? 'assets/images/image 44.png'
                          : 'assets/images/image 45.png',
                  hasDiscount: true,
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCareTypeButtons() {
    final careTypes = [
      'Для очищения',
      'Для увлажнения',
      'Для питания',
      'Для омоложения',
    ];

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children:
            careTypes.map((type) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 22, vertical: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(
                    4,
                  ), // Очень маленький радиус
                  border: Border.all(color: Color(0xFFE5E5E5), width: 0.5),
                ),
                child: Text(
                  type,
                  style: TextStyle(fontSize: 14, color: Colors.black87),
                ),
              );
            }).toList(),
      ),
    );
  }

  Widget _buildHitsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Text(
                'Хиты',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(width: 8),
              Container(width: 90, height: 2, color: Colors.orange),
            ],
          ),
        ),
        Container(
          height: 280,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 16),
            itemCount: 2,
            itemBuilder: (context, index) {
              return Container(
                width: 160,
                margin: EdgeInsets.only(right: 12),
                child: ProductCardWidget(
                  name:
                      index == 0
                          ? 'Forever Young Total Renewal Serum'
                          : 'Illustrious Mask',
                  brand: index == 0 ? 'Сыворотка' : 'Осветляющая маска',
                  price: index == 0 ? '10 195 ₽' : '1595 ₽',
                  imageUrl:
                      index == 0
                          ? 'assets/images/Group 1.png'
                          : 'assets/images/image 46.png',
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
