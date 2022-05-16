import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth.dart';
import 'auth_screen.dart';
import 'products_overview_screen.dart';

///Decide se o usuário vai pra tela inicial ou de autenticação baseado no token.
class AuthOrHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<Auth>(
      builder: (context, auth, child) {
        return FutureBuilder(
          future: auth.tryAutoLogin(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            } else {
              if (auth.isAuth) {
                return ProductOverviewScreen();
              } else {
                return AuthScreen();
              }
            }
          },
        );
      },
    );
  }
}
