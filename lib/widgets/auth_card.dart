import 'package:flutter/material.dart';

///Controla se o card vai possuir a estrutura pra fazer um cadastro ou registro.
enum AuthMode {
  ///Enum pra fazer o registro.
  register,

  ///Enum para fazer o login.
  login,
}

///Formulário de autenticação do usuário na tela de login
class AuthCard extends StatefulWidget {
  @override
  _AuthCardState createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard> {
  AuthMode _authMode = AuthMode.login;
  final _passwordController = TextEditingController();
  final Map<String, String> _authData = {
    'email': '',
    'password': '',
  };

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        padding: const EdgeInsets.all(16),
        height: 320,
        width: deviceSize.width * 0.75,
        child: Form(
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'E-mail',
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value.isEmpty || !value.contains('@')) {
                    return 'E-mail inválido!';
                  } else {
                    return null;
                  }
                },
                onSaved: (value) => _authData['email'] = value,
              ),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                ),
                obscureText: true,
                validator: (value) {
                  if (value.isEmpty || value.length < 6) {
                    return 'Informe uma senha válida!';
                  } else {
                    return null;
                  }
                },
                onSaved: (value) => _authData['Password'] = value,
              ),
              if (_authMode == AuthMode.register)
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: 'Confirm password',
                  ),
                  obscureText: true,
                  validator: _authMode == AuthMode.register
                      ? (value) {
                          if (value != _passwordController.text) {
                            return 'As senhas devem ser iguais!';
                          } else {
                            return null;
                          }
                        }
                      : null,
                  onSaved: (value) => _authData['password'] = value,
                ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submit,
                child: Text(
                  _authMode == AuthMode.login ? 'Entrar' : 'Registrar',
                ),
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  padding: MaterialStateProperty.all(
                    EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 8,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submit() {}
}
