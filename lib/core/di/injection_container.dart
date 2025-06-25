import 'package:cosmetics/data/datasources/products_local_datasources.dart';
import 'package:get_it/get_it.dart';
import '../../data/repositories/products_repository_impl.dart';
import '../../domain/repositories/products_repository.dart';
import '../../domain/usecases/get_products.dart';
import '../../presentation/bloc/products/products_bloc.dart';
import '../../presentation/bloc/categories/categories_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // BLoC
  sl.registerFactory(() => ProductsBloc(getProducts: sl()));
  sl.registerFactory(() => CategoriesBloc());

  // Use cases
  sl.registerLazySingleton(() => GetProducts(sl()));

  // Repository
  sl.registerLazySingleton<ProductsRepository>(
    () => ProductsRepositoryImpl(localDataSource: sl()),
  );

  // Data sources
  sl.registerLazySingleton<ProductsLocalDataSource>(
    () => ProductsLocalDataSourceImpl(),
  );
}