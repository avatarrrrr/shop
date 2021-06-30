import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth.dart';

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
  bool isLoading = false;
  final _form = GlobalKey<FormState>();
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
        width: deviceSize.width * 0.75,
        child: Form(
          key: _form,
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
                onSaved: (value) => _authData['password'] = value,
              ),
              if (_authMode == AuthMode.register)
                TextFormField(
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
                ),
              SizedBox(height: 20),
              if (isLoading)
                CircularProgressIndicator()
              else
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
              TextButton(
                onPressed: _switchAuthMode,
                child: Text(
                  """
Alternar para ${_authMode == AuthMode.login ? 'registro' : 'login'}""",
                ),
                style: ButtonStyle(
                  foregroundColor:
                      MaterialStateProperty.all(Theme.of(context).primaryColor),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submit() {
    if (!_form.currentState.validate()) {
      return;
    }
    setState(() => isLoading = true);

    _form.currentState.save();

    var auth = context.read<Auth>();

    if (_authMode == AuthMode.login) {
      auth.login(_authData["email"], _authData["password"]);
    } else {
      auth.register(_authData["email"], _authData["password"]);
    }

    setState(() => isLoading = false);
  }

  void _switchAuthMode() {
    if (_authMode == AuthMode.login) {
      _authMode = AuthMode.register;
    } else {
      _authMode = AuthMode.login;
    }
    setState(() => _authMode);
  }
}
