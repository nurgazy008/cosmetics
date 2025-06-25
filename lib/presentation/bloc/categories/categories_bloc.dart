import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../domain/entities/category.dart';

// Events
abstract class CategoriesEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadCategoriesEvent extends CategoriesEvent {}

// States
abstract class CategoriesState extends Equatable {
  @override
  List<Object> get props => [];
}

class CategoriesInitial extends CategoriesState {}

class CategoriesLoading extends CategoriesState {}

class CategoriesLoaded extends CategoriesState {
  final List<Category> categories;
  
  CategoriesLoaded(this.categories);
  
  @override
  List<Object> get props => [categories];
}

// BLoC
class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  CategoriesBloc() : super(CategoriesInitial()) {
    on<LoadCategoriesEvent>(_onLoadCategories);
  }
  
  void _onLoadCategories(LoadCategoriesEvent event, Emitter<CategoriesState> emit) async {
    emit(CategoriesLoading());
    await Future.delayed(Duration(milliseconds: 300));
    
    final categories = [
      Category(id: 1, name: 'Назначение', iconPath: 'assets/icons/purpose.png', skinTypes: []),
      Category(id: 2, name: 'Тип средства', iconPath: 'assets/icons/type.png', skinTypes: []),
      Category(id: 3, name: 'Тип кожи', iconPath: 'assets/icons/skin.png', skinTypes: ['Жирная', 'Сухая', 'Комбинированная']),
      Category(id: 4, name: 'Линии косметики', iconPath: 'assets/icons/lines.png', skinTypes: []),
    ];
    
    emit(CategoriesLoaded(categories));
  }
}