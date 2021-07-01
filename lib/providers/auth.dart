import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:shop/exceptions/auth_exception.dart';

///Responsável pela autenticação do usuário junto ao Firebase.
class Auth extends ChangeNotifier {
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
}
