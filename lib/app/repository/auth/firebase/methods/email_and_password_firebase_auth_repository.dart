import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:shop/app/exceptions/auth_exception.dart';
import 'package:shop/app/interfaces/auth_interface.dart';
import 'package:shop/app/repository/auth/firebase/firebase_auth_repository.dart';

class EmailAndPasswordFirebaseAuthRepository extends FirebaseAuthRepository {
  @override
  AuthenticationsMethods method = AuthenticationsMethods.emailAndPassword;

  EmailAndPasswordFirebaseAuthRepository(GlobalKey<NavigatorState> navigatorKey)
      : super(navigatorKey);

  @override
  create({required String emailTyped, required String passwordTyped}) async {
    await _errorTreat(
      () async => await instance.createUserWithEmailAndPassword(
        email: emailTyped,
        password: passwordTyped,
      ),
    );
  }

  @override
  login({required String emailTyped, required String passwordTyped}) async {
    await _errorTreat(
      () async => await instance.signInWithEmailAndPassword(
        email: emailTyped,
        password: passwordTyped,
      ),
    );
  }

  @override
  Future<void> sendResetPasswordEmail({required String emailTyped}) async {
    await _errorTreat(
      () async => await instance.sendPasswordResetEmail(
        email: emailTyped,
      ),
    );
  }

  Future<void> _errorTreat(dynamic Function() operation) async {
    try {
      await operation();
    } on FirebaseAuthException catch (error) {
      throw AuthException(error.code);
    } catch (error) {
      throw error;
    }
  }
}
