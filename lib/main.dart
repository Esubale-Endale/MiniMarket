import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_market/bloc/cartBloc/cart_bloc.dart';
import 'package:mini_market/bloc/productBloc/products_bloc.dart';

import 'screens/home_screen.dart';

void main() {
  runApp(const MiniMarketApp());
}

class MiniMarketApp extends StatelessWidget {
  const MiniMarketApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ProductsBloc()),
        BlocProvider(create: (_) => CartBloc()),
      ],

      child: MaterialApp(
        title: 'Mini Market',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF2563EB)),
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            centerTitle: true,
            elevation: 0,
          ),
          // Every text field in the app gets the same rounded outline.
          inputDecorationTheme: InputDecorationTheme(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 12,
            ),
          ),
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
