import '../models/product_model.dart';

abstract class ProductsLocalDataSource {
  Future<List<ProductModel>> getProducts();
}

class ProductsLocalDataSourceImpl implements ProductsLocalDataSource {
  @override
  Future<List<ProductModel>> getProducts() async {
    await Future.delayed(Duration(milliseconds: 500));

    return [
      ProductModel(
        id: 1,
        name: 'Centella Total Unscented Serum',
        brand: 'COSRX',
        price: 1095,
        imageUrl: 'assets/images/cosrx_serum.png',
        category: 'Сыворотки',
        skinTypes: ['Жирная', 'Комбинированная'],
        effect: 'Увлажнение', // ✅ ҚОСЫЛДЫ
      ),
      ProductModel(
        id: 2,
        name: 'Laneige Revitalizing Toner',
        brand: 'Laneige',
        price: 3095,
        imageUrl: 'assets/images/laneige_toner.png',
        category: 'Тонеры',
        skinTypes: ['Сухая', 'Нормальная'],
        effect: 'Омоложение', // ✅ ҚОСЫЛДЫ
      ),
      ProductModel(
        id: 3,
        name: 'Hada Labo Gokujyun Premium',
        brand: 'Hada Labo',
        price: 1590,
        imageUrl: 'assets/images/hada_labo.png',
        category: 'Лосьоны',
        skinTypes: ['Сухая', 'Чувствительная'],
        effect: 'Питание', // ✅ ҚОСЫЛДЫ
        isOnSale: true,
        salePrice: 1350,
      ),
    ];
  }
}
