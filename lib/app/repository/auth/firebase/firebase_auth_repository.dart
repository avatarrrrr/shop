import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shop/app/interfaces/auth_interface.dart';
import 'package:shop/app/utils/app_routes.dart';

abstract class FirebaseAuthRepository implements AuthInterface {
  @override
  final ValueNotifier<bool> emailVerifield = ValueNotifier(true);
  final instance = FirebaseAuth.instance;

  FirebaseAuthRepository(GlobalKey<NavigatorState> navigatorKey) {
    instance.userChanges().listen((event) {
      late String? currentRoute;

      navigatorKey.currentState?.popUntil((route) {
        currentRoute = route.settings.name;
        return true;
      });

      if (event == null) {
        emailVerifield.value = true;
      }

      if (currentRoute != AppRoutes.auth && event == null) {
        navigatorKey.currentState?.pushReplacementNamed(AppRoutes.auth);
      } else if (event != null && currentRoute == AppRoutes.auth) {
        if (!event.emailVerified) {
          emailVerifield.value = false;
          sendVericationEmail();
          return;
        } else {
          emailVerifield.value = true;
        }

        navigatorKey.currentState?.pushReplacementNamed(AppRoutes.home);

        final getItInstance = GetIt.I;

        if (!getItInstance.isRegistered<AuthInterface>()) {
          getItInstance.registerSingleton<AuthInterface>(this);
        }
      }
    });
  }

  @override
  deleteUser() async {
    instance.currentUser?.delete();
  }

  @override
  logout() async {
    instance.signOut();
  }

  @override
  reloadUserMetadada() async {
    instance.currentUser?.reload();
  }

  @override
  Future<void> sendVericationEmail() async {
    instance.currentUser?.sendEmailVerification();
  }
}
