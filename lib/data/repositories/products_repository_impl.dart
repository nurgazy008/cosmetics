import 'package:cosmetics/data/datasources/products_local_datasources.dart';

import '../../domain/entities/product.dart';
import '../../domain/repositories/products_repository.dart';

class ProductsRepositoryImpl implements ProductsRepository {
  final ProductsLocalDataSource localDataSource;

  ProductsRepositoryImpl({required this.localDataSource});

  @override
  Future<List<Product>> getProducts() async {
    return await localDataSource.getProducts();
  }

  @override
  Future<List<Product>> getProductsByCategory(String category) async {
    final products = await localDataSource.getProducts();
    return products.where((product) => product.category == category).toList();
  }

  @override
  Future<List<Product>> getProductsBySkinType(String skinType) async {
    final products = await localDataSource.getProducts();
    return products.where((product) => product.skinTypes.contains(skinType)).toList();
  }

  @override
  Future<List<Product>> searchProducts(String query) async {
    final products = await localDataSource.getProducts();
    return products
        .where((product) =>
            product.name.toLowerCase().contains(query.toLowerCase()) ||
            product.brand.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }
}