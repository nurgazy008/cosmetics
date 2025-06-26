class Product {
  final int id;
  final String name;
  final String brand;
  final double price;
  final String imageUrl;
  final String category;
  final List<String> skinTypes;
  final String effect; // ✅ NEW
  final bool isOnSale;
  final double? salePrice;

  Product({
    required this.id,
    required this.name,
    required this.brand,
    required this.price,
    required this.imageUrl,
    required this.category,
    required this.skinTypes,
    required this.effect, // ✅ NEW
    this.isOnSale = false,
    this.salePrice,
  });
}
