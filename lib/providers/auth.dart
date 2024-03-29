import 'dart:async';
import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import '../data/store.dart';
import '../exceptions/auth_exception.dart';

///Responsável pela autenticação do usuário junto ao Firebase.
class Auth extends ChangeNotifier {
  String _userID;
  String _token;
  DateTime _expiryDate;
  Timer _logoutTimer;

  ///Retorna se o token do usuário ainda é válido ou não.
  bool get isAuth {
    return token != null;
  }

  ///Retona UID do usuário no banco de dados.
  String get userID {
    return isAuth ? _userID : null;
  }

  ///Retorna o token do usuário, se não possuir ou tiver expirado retorna null.
  String get token {
    if (_token != null &&
        _expiryDate != null &&
        _expiryDate.isAfter(
          DateTime.now(),
        )) {
      return _token;
    } else {
      return null;
    }
  }

  Future<void> _authenticate(
      String email, String password, String urlSegment) async {
    final url = Uri.parse(
      "https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key=${dotenv.env['GOOGLE_API_KEY']}",
    );
    final response = await http.post(
      url,
      body: json.encode({
        "email": email,
        "password": password,
        "returnSecureToken": true,
      }),
    );

    var responseBody = json.decode(response.body);

    if (responseBody['error'] != null) {
      throw AuthException(
        responseBody['error']['message'].split(':').first.replaceAll(' ', ''),
      );
    } else {
      _token = responseBody['idToken'];
      _userID = responseBody['localId'];
      _expiryDate = DateTime.now().add(
        Duration(
          seconds: int.parse(
            responseBody['expiresIn'],
          ),
        ),
      );

      Store.saveMap('userData', {
        'token': _token,
        'userID': _userID,
        'expiryDate': _expiryDate.toIso8601String(),
      });

      _autoLogout();
      notifyListeners();
    }
    return Future.value();
  }

  ///Realiza um registro de usuário no firebase, deve ser passado email e senha.
  Future<void> register(String email, String password) async {
    return await _authenticate(email, password, 'signUp');
  }

  ///Realiza o login de usuário no firebase, requerido email e senha.
  Future<void> login(String email, String password) async {
    await _authenticate(email, password, 'signInWithPassword');
  }

  ///Tenta realizar o login a partir dos dados no armazenamento local.
  Future<void> tryAutoLogin() async {
    if (isAuth) {
      return Future.value();
    } else {
      final userData = await Store.readMap('userData');

      if (userData == null) {
        return Future.value();
      } else {
        final expiryDate = DateTime.parse(userData['expiryDate']);

        if (expiryDate.isBefore(DateTime.now())) {
          return Future.value();
        } else {
          _userID = userData['userID'];
          _token = userData['token'];
          _expiryDate = expiryDate;

          _autoLogout();
          notifyListeners();
          return Future.value();
        }
      }
    }
  }

  ///Realiza a saída do usuário no sistema;
  void logout() {
    _token = null;
    _expiryDate = null;
    _userID = null;
    if (_logoutTimer != null) {
      _logoutTimer.cancel();
      _logoutTimer = null;
    }
    Store.remove('userData');
    notifyListeners();
  }

  void _autoLogout() {
    if (_logoutTimer != null) {
      _logoutTimer.cancel();
    }

    final timeToLogout = _expiryDate.difference(DateTime.now()).inSeconds;

    _logoutTimer = Timer(
      Duration(seconds: timeToLogout),
      logout,
    );
  }
}
