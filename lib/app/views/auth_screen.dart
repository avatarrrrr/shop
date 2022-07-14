import 'dart:math';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shop/app/repository/auth/firebase/methods/email_and_password_firebase_auth_repository.dart';

import '../widgets/auth_card.dart';

class AuthScreen extends StatelessWidget {
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
                      AuthCard(
                        emailAuthProvider:
                            EmailAndPasswordFirebaseAuthRepository(
                                GetIt.I<GlobalKey<NavigatorState>>()),
                      ),
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
}
