import 'package:firebase_auth/firebase_auth.dart';
import 'package:shop/app/exceptions/auth_exception.dart';
import 'package:shop/app/interfaces/auth_interface.dart';
import 'package:shop/app/repository/auth/firebase/firebase_auth_repository.dart';

class EmailAndPasswordFirebaseAuthRepository extends FirebaseAuthRepository {
  @override
  AuthenticationsMethods method = AuthenticationsMethods.emailAndPassword;

  @override
  create({required String emailTyped, required String passwordTyped}) async {
    try {
      instance.createUserWithEmailAndPassword(email: emailTyped, password: passwordTyped);
    } on FirebaseAuthException catch (error) {
      throw AuthException(error.code);
    } catch (error) {
      throw error;
    }
  }

  @override
  login({required String emailTyped, required String passwordTyped}) async {
    try {
      instance.signInWithEmailAndPassword(email: emailTyped, password: passwordTyped);
    } on FirebaseAuthException catch (error) {
      throw AuthException(error.code);
    } catch (error) {
      throw error;
    }
  }
}