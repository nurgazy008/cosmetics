import 'package:flutter/material.dart';
import '../../domain/entities/category.dart';
import '../pages/skin_type_page.dart';

class CategoriesGrid extends StatelessWidget {
  final List<Category> categories;

  const CategoriesGrid({Key? key, required this.categories}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.5,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: categories.length,
      itemBuilder: (context, index) {
        final category = categories[index];
        return GestureDetector(
          onTap: () {
            if (category.name == 'Тип кожи') {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SkinTypePage(),
                ),
              );
            }
          },
          child: Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Color(0xFFF2F2F7),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  _getIconForCategory(category.name),
                  size: 24,
                  color: Colors.black54,
                ),
                Spacer(),
                Text(
                  category.name,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  IconData _getIconForCategory(String categoryName) {
    switch (categoryName) {
      case 'Назначение':
        return Icons.star_outline;
      case 'Тип средства':
        return Icons.category_outlined;
      case 'Тип кожи':
        return Icons.face_outlined;
      case 'Линии косметики':
        return Icons.palette_outlined;
      default:
        return Icons.category;
    }
  }
}