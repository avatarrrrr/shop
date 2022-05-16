import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'providers/auth.dart';
import 'providers/cart.dart';
import 'providers/orders.dart';
import 'providers/products.dart';
import 'utils/app_routes.dart';
import 'views/auth_home_screen.dart';
import 'views/auth_screen.dart';
import 'views/cart_screen.dart';
import 'views/orders_screen.dart';
import 'views/product_detail_screen.dart';
import 'views/product_form_screen.dart';
import 'views/products_overview_screen.dart';
import 'views/products_screen.dart';

Future<void> main() async {
  await dotenv.load();
  runApp(MyApp());
}

///Widget Main
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, Products>(
          create: (_) => Products(null, null, []),
          update: (context, auth, previousProducts) => Products(
            auth.token,
            auth.userID,
            previousProducts!.items,
          ),
        ),
        ChangeNotifierProxyProvider<Auth, Orders>(
          create: (_) => Orders(null, null, []),
          update: (context, auth, previousOrders) =>
              Orders(auth.token, auth.userID, previousOrders!.items),
        ),
        ChangeNotifierProvider(
          create: (_) => Cart(),
        ),
      ],
      child: MaterialApp(
        title: 'Minha Loja',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.deepOrange,
          fontFamily: 'Lato',
        ),
        routes: {
          AppRoutes.authOrHome: (context) => AuthOrHome(),
          AppRoutes.auth: (context) => AuthScreen(),
          AppRoutes.home: (context) => context.read<Auth>().isAuth
              ? ProductOverviewScreen()
              : AuthScreen(),
          AppRoutes.productDetail: (context) => context.read<Auth>().isAuth
              ? ProductDetailScreen()
              : AuthScreen(),
          AppRoutes.cart: (context) =>
              context.read<Auth>().isAuth ? CartScreen() : AuthScreen(),
          AppRoutes.orders: (context) =>
              context.read<Auth>().isAuth ? OrdersScreen() : AuthScreen(),
          AppRoutes.products: (context) =>
              context.read<Auth>().isAuth ? ProductsScreen() : AuthScreen(),
          AppRoutes.productForm: (context) =>
              context.read<Auth>().isAuth ? ProductFormScreen() : AuthScreen(),
        },
      ),
    );
  }
}
