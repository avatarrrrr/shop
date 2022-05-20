import 'package:shop/main.dart';

class AuthException implements Exception {
  late final Map<String, String> _errors;
  final String _key;

  AuthException(this._key) {
    getAppLocalizationsWithoutContext.then((appLocalizations) {
      _errors['invalid-email'] = appLocalizations.invalidEmail;
      _errors['email-already-in-use'] = appLocalizations.emailAlreadyInUse;
      _errors['weak-password'] = appLocalizations.weakPassword;
    });
  }

  @override
  String toString() {
    if ( _errors.containsKey(_key)) {
      return  _errors[_key]!;
    } else {
      return 'There a error!';
    }
  }
}
