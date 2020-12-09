import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/cart.dart';
import 'providers/orders.dart';
import 'providers/products.dart';
import 'utils/app_routes.dart';
import 'views/cart_screen.dart';
import 'views/orders_screen.dart';
import 'views/product_detail_screen.dart';
import 'views/products_overview_screen.dart';

void main() => runApp(MyApp());

///Widget Main
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => Products(),
        ),
        ChangeNotifierProvider(
          create: (_) => Cart(),
        ),
        ChangeNotifierProvider(
          create: (_) => Orders(),
        )
      ],
      child: MaterialApp(
        title: 'Minha Loja',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.deepOrange,
          fontFamily: 'Lato',
        ),
        home: ProductOverviewScreen(),
        routes: {
          AppRoutes.productDetail: (ctx) => ProductDetailScreen(),
          AppRoutes.cart: (ctx) => CartScreen(),
          AppRoutes.orders: (ctx) => OrdersScreen(),
        },
      ),
    );
  }
}
