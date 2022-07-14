import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:shop/app/interfaces/auth_interface.dart';
import 'package:shop/app/providers/cart.dart';
import 'package:shop/app/repository/auth/firebase/methods/email_and_password_firebase_auth_repository.dart';
import 'package:shop/app/utils/app_localizations.dart';
import 'package:shop/app/utils/app_routes.dart';
import 'package:shop/app/views/auth_screen.dart';
import 'package:shop/app/views/cart_screen.dart';
import 'package:shop/app/views/orders_screen.dart';
import 'package:shop/app/views/product_detail_screen.dart';
import 'package:shop/app/views/product_form_screen.dart';
import 'package:shop/app/views/products_overview_screen.dart';
import 'package:shop/app/views/products_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Shop extends StatelessWidget {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    late final String appName;
    final List<AuthInterface> authenticationsProviders = [
      EmailAndPasswordFirebaseAuthRepository(_navigatorKey)
    ];

    if (!GetIt.I.isRegistered<GlobalKey<NavigatorState>>()) {
      GetIt.I.registerSingleton(_navigatorKey);
    }

    getAppLocalizationsWithoutContext
        .then((appLocalizations) => appName = appLocalizations.appName);

    return MultiProvider(
      providers: [
        // ChangeNotifierProxyProvider<Auth, Products>(
        //   create: (_) => Products(null, null, []),
        //   update: (context, auth, previousProducts) => Products(
        //     auth.token,
        //     auth.userID,
        //     previousProducts!.items,
        //   ),
        // ),
        // ChangeNotifierProxyProvider<Auth, Orders>(
        //   create: (_) => Orders(null, null, []),
        //   update: (context, auth, previousOrders) =>
        //       Orders(auth.token, auth.userID, previousOrders!.items),
        // ),
        ChangeNotifierProvider(
          create: (_) => Cart(),
        ),
      ],
      child: MaterialApp(
        navigatorKey: _navigatorKey,
        title: appName,
        theme: ThemeData(
          fontFamily: 'Lato',
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.purple)
              .copyWith(secondary: Colors.deepOrange),
        ),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        initialRoute: AppRoutes.auth,
        routes: {
          AppRoutes.auth: (context) =>
              AuthScreen(authProviders: authenticationsProviders),
          AppRoutes.home: (context) => ProductOverviewScreen(),
          AppRoutes.cart: (context) => CartScreen(),
          AppRoutes.productDetail: (context) => ProductDetailScreen(),
          AppRoutes.orders: (context) => OrdersScreen(),
          AppRoutes.products: (context) => ProductsScreen(),
          AppRoutes.productForm: (context) => ProductFormScreen(),
        },
      ),
    );
  }
}
