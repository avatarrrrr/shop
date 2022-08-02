import 'dart:math';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:shop/app/controllers/auth_screen_controller.dart';
import 'package:shop/app/interfaces/auth_interface.dart';

import '../widgets/auth_card.dart';

class AuthScreen extends StatelessWidget {
  final List<AuthInterface> authProviders;
  final contoller = AuthScreenController();

  AuthScreen({
    Key? key,
    required this.authProviders,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color.fromRGBO(215, 177, 255, 0.5),
                        Color.fromRGBO(255, 188, 177, 0.9),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: 20),
                        padding: EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 70,
                        ),
                        transform: Matrix4.rotationZ(-8 * pi / 180)
                          ..translate(-10.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.deepOrange.shade900,
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 8,
                              color: Colors.black26,
                              offset: Offset(0, 2),
                            )
                          ],
                        ),
                        child: Text(
                          AppLocalizations.of(context)!.appName,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 45,
                            fontFamily: 'Anton',
                          ),
                        ),
                      ),
                      ..._generateAuthenticationsOptions(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _generateAuthenticationsOptions() {
    final List<Widget> authsWidgets = [];

    authProviders.forEach((AuthInterface auth) {
      switch (auth.method) {
        case AuthenticationsMethods.emailAndPassword:
          authsWidgets.insert(
            0,
            AuthCard(emailAuthProvider: auth, onSubmit: contoller.submit),
          );
          break;
      }
    });

    return authsWidgets;
  }
}
