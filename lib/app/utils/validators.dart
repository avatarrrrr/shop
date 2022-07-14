import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

mixin Validators {
  String? emailValidator({
    required String? stringTyped,
    required BuildContext currentContext,
  }) {
    if (stringTyped!.isEmpty || !stringTyped.contains('@')) {
      return AppLocalizations.of(currentContext)!.invalidEmail;
    } else {
      return null;
    }
  }

  String? passwordValidator({
    required String? stringTyped,
    required BuildContext currentContext,
  }) {
    if (stringTyped!.isEmpty || stringTyped.length < 6) {
      return AppLocalizations.of(currentContext)!.passwordInvalid;
    } else {
      return null;
    }
  }

  String? confirmPasswordValidator({
    required String? stringTyped,
    required BuildContext currentContext,
    required TextEditingController passwordController,
  }) {
    if (stringTyped != passwordController.text) {
      return AppLocalizations.of(currentContext)!.thePasswordsMustBeTheSame;
    } else {
      return null;
    }
  }
}
