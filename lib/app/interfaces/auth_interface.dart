import 'dart:async';

import 'package:flutter/foundation.dart';

enum AuthenticationsMethods {
  emailAndPassword,
}

abstract class AuthInterface {
  abstract AuthenticationsMethods method;
  abstract final ValueNotifier<bool> emailVerifield;

  Future<void> create({
    required String emailTyped,
    required String passwordTyped,
  });
  Future<void> login({
    required String emailTyped,
    required String passwordTyped,
  });

  Future<void> logout();

  Future<void> deleteUser();

  Future<void> reloadUserMetadada();

  Future<void> sendVericationEmail();

  Future<void> sendResetPasswordEmail({
    required String emailTyped,
  });
}
