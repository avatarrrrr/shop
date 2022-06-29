import 'package:firebase_auth/firebase_auth.dart';
import 'package:shop/app/interfaces/auth_interface.dart';

abstract class FirebaseAuthRepository implements AuthInterface {
  @override
  bool isLogged = false;

  final instance = FirebaseAuth.instance;

  FirebaseAuthRepository() {
    instance.authStateChanges().listen((event) {
      isLogged = event == null ? false : true;
    });
  }

  @override
  logout() async {
    instance.signOut();
  }

}
