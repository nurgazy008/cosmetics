import '../../domain/entities/product.dart';

Future<List<Product>> getMockProducts() async {
  return [
    Product(
      id: 1,
      name: 'Centella Total Unscented Serum',
      brand: 'COSRX',
      price: 1095,
      imageUrl: '',
      category: 'Сыворотка',
      skinTypes: ['Комбинированная', 'Чувствительная'],
      effect: 'Увлажнение',
    ),
    Product(
      id: 2,
      name: 'Hyaluronic Gel Cream',
      brand: 'Isntree',
      price: 2090,
      imageUrl: '',
      category: 'Крем',
      skinTypes: ['Сухая'],
      effect: 'Питание',
    ),
    Product(
      id: 3,
      name: 'Renewing Foam Cleanser',
      brand: 'CeraVe',
      price: 1490,
      imageUrl: '',
      category: 'Очищение',
      skinTypes: ['Жирная', 'Комбинированная'],
      effect: 'Очищение',
    ),
  ];
}
