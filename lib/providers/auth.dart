import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

///Responsável pela autenticação do usuário junto ao Firebase.
class Auth extends ChangeNotifier {
  ///Realiza um registro de usuário no firebase, deve ser passado email e senha.
  Future<void> register(String email, String password) async {
    final url = Uri.parse(
      "https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=${dotenv.env['GOOGLE_API_KEY']}",
    );
    final response = await http.post(
      url,
      body: json.encode({
        "email": email,
        "password": password,
        "returnSecureToken": true,
      }),
    );
    print(json.decode(response.body));

    return Future.value();
  }
}
