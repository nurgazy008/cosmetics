import '../entities/product.dart';

abstract class ProductsRepository {
  Future<List<Product>> getProducts();
  Future<List<Product>> getProductsByCategory(String category);
  Future<List<Product>> getProductsBySkinType(String skinType);
  Future<List<Product>> searchProducts(String query);
}