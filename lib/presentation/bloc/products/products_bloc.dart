import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../domain/entities/product.dart';
import '../../../domain/usecases/get_products.dart';

// Events
abstract class ProductsEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadProductsEvent extends ProductsEvent {}

class FilterProductsBySkinTypeEvent extends ProductsEvent {
  final String skinType;
  FilterProductsBySkinTypeEvent(this.skinType);
  
  @override
  List<Object> get props => [skinType];
}

class FilterProductsByEffectEvent extends ProductsEvent {
  final String effect;
  final String skinType;
  FilterProductsByEffectEvent(this.effect, this.skinType);

  @override
  List<Object> get props => [effect, skinType];
}

// States
abstract class ProductsState extends Equatable {
  @override
  List<Object> get props => [];
}

class ProductsInitial extends ProductsState {}

class ProductsLoading extends ProductsState {}

class ProductsLoaded extends ProductsState {
  final List<Product> products;
  
  ProductsLoaded(this.products);
  
  @override
  List<Object> get props => [products];
}

class ProductsError extends ProductsState {
  final String message;
  
  ProductsError(this.message);
  
  @override
  List<Object> get props => [message];
}

// BLoC
class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final GetProducts getProducts;
  
  ProductsBloc({required this.getProducts}) : super(ProductsInitial()) {
    on<LoadProductsEvent>(_onLoadProducts);
    on<FilterProductsBySkinTypeEvent>(_onFilterProducts);
    on<FilterProductsByEffectEvent>(_onFilterProductsByEffect);
  }
  
  void _onLoadProducts(LoadProductsEvent event, Emitter<ProductsState> emit) async {
    emit(ProductsLoading());
    try {
      final products = await getProducts();
      emit(ProductsLoaded(products));
    } catch (e) {
      emit(ProductsError('Ошибка загрузки товаров'));
    }
  }
  
  void _onFilterProducts(FilterProductsBySkinTypeEvent event, Emitter<ProductsState> emit) async {
    emit(ProductsLoading());
    try {
      final products = await getProducts();
      final filteredProducts = products
          .where((product) => product.skinTypes.contains(event.skinType))
          .toList();
      emit(ProductsLoaded(filteredProducts));
    } catch (e) {
      emit(ProductsError('Ошибка фильтрации товаров'));
    }
  }

  void _onFilterProductsByEffect(FilterProductsByEffectEvent event, Emitter<ProductsState> emit) async {
    emit(ProductsLoading());
    try {
      final products = await getProducts();
      // Если у Product нет поля effect, фильтрация только по skinType
      final filtered = products
          .where((product) =>
              product.skinTypes.contains(event.skinType)
              // && product.effect == event.effect // если появится поле effect
          )
          .toList();
      emit(ProductsLoaded(filtered));
    } catch (e) {
      emit(ProductsError('Ошибка фильтрации товаров'));
    }
  }
}