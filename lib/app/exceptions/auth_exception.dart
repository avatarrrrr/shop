import 'package:shop/app/utils/app_localizations.dart';

class AuthException implements Exception {
  final Map<String, String> _errors = {};
  final String _key;

  AuthException(this._key) {
    getAppLocalizationsWithoutContext.then((appLocalizations) {
      _errors['invalid-email'] = appLocalizations.invalidEmail;
      _errors['email-already-in-use'] = appLocalizations.emailAlreadyInUse;
      _errors['weak-password'] = appLocalizations.weakPassword;
      _errors['user-not-found'] = appLocalizations.userNotFound;
      _errors['wrong-password'] = appLocalizations.wrongPassword;
      _errors['too-many-requests'] = appLocalizations.tooManyRequests;
    });
  }

  @override
  String toString() {
    if (_errors.containsKey(_key)) {
      return _errors[_key]!;
    } else {
      return 'There a error!';
    }
  }
}
