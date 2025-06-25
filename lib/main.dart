import 'package:cosmetics/presentation/pages/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/di/injection_container.dart' as di;
import 'presentation/bloc/categories/categories_bloc.dart';
import 'presentation/bloc/products/products_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => di.sl<ProductsBloc>()..add(LoadProductsEvent()),
        ),
        BlocProvider(
          create: (_) => di.sl<CategoriesBloc>()..add(LoadCategoriesEvent()),
        ),
      ],
      child: MaterialApp(
        title: 'Cosmetics Store',
        theme: ThemeData(
          primarySwatch: Colors.green,
          fontFamily: 'SF Pro Display',
        ),
        home: MainScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
