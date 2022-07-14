import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:shop/app/interfaces/auth_interface.dart';
import 'package:shop/app/widgets/auth_card.dart';

class AuthScreenController {
  Future<void> submit({
    required AuthInterface auth,
    GlobalKey<FormState>? formKey,
    required AuthMode authMode,
    Map<String, String> data = const {},
  }) async {
    final instanceOfGetIt = GetIt.I;

    if (formKey != null && data.isNotEmpty) {
      if (!formKey.currentState!.validate()) {
        return;
      }

      formKey.currentState!.save();

      if (authMode == AuthMode.login) {
        try {
          await auth.login(
              emailTyped: data["email"]!, passwordTyped: data["password"]!);
        } on Exception catch (error) {
          throw error;
        }
      } else {
        try {
          await auth.create(
              emailTyped: data["email"]!, passwordTyped: data["password"]!);
        } on Exception catch (error) {
          throw error;
        }
      }

      if (!instanceOfGetIt.isRegistered<AuthInterface>()) {
        instanceOfGetIt.registerSingleton(auth);
      }
    }
  }
}
