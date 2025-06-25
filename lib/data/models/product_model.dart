import '../../domain/entities/product.dart';

class ProductModel extends Product {
  ProductModel({
    required int id,
    required String name,
    required String brand,
    required double price,
    required String imageUrl,
    required String category,
    required List<String> skinTypes,
    bool isOnSale = false,
    double? salePrice,
  }) : super(
          id: id,
          name: name,
          brand: brand,
          price: price,
          imageUrl: imageUrl,
          category: category,
          skinTypes: skinTypes,
          isOnSale: isOnSale,
          salePrice: salePrice,
        );

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      name: json['name'],
      brand: json['brand'],
      price: json['price'].toDouble(),
      imageUrl: json['imageUrl'],
      category: json['category'],
      skinTypes: List<String>.from(json['skinTypes']),
      isOnSale: json['isOnSale'] ?? false,
      salePrice: json['salePrice']?.toDouble(),
    );
  }
}