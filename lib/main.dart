import 'package:flutter/material.dart';
import 'views/products_overview_screen.dart';
import 'utils/app_routes.dart';
import 'views/product_detail_screen.dart';

void main() => runApp(MyApp());

///Widget Main
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Minha Loja',
        theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.deepOrange,
          fontFamily: 'Lato',
        ),
        home: ProductOverviewScreen(),
        routes: {
          AppRoutes.productDetail: (ctx) => ProductDetailScreen(),
        });
  }
}
