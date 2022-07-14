import 'package:flutter/material.dart';
import 'package:shop/app/controllers/auth_screen_controller.dart';
import 'package:shop/app/interfaces/auth_interface.dart';
import 'package:shop/app/widgets/auth_card_widgets/buttons_auth_card_widget.dart';
import 'package:shop/app/widgets/auth_card_widgets/text_fields_auth_card_widget.dart';

enum AuthMode {
  register,
  login,
}

class AuthCard extends StatelessWidget {
  final AuthInterface emailAuthProvider;

  AuthCard({
    Key? key,
    required this.emailAuthProvider,
  });

  final _isLoading = ValueNotifier(false);
  final ValueNotifier<AuthMode> _authMode = ValueNotifier(AuthMode.login);
  final controller = AuthScreenController();
  final _form = GlobalKey<FormState>();
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
          child: ValueListenableBuilder(
            valueListenable: _authMode,
            child: SizedBox(height: 20),
            builder: (context, AuthMode authMode, child) {
              return Column(
                children: [
                  TextFieldsAuthCardWidget(
                    authenticationMode: authMode,
                    onSubmit: submit,
                    formData: _authData,
                  ),
                  child!,
                  ValueListenableBuilder(
                    valueListenable: _isLoading,
                    builder: (context, bool isLoading, child) {
                      return ButtonsAuthCardWidget(
                        isLoading: isLoading,
                        authenticationMode: authMode,
                        onSubmit: submit,
                        switchAuthenticationMode: _switchAuthMode,
                      );
                    },
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  void submit() {
    _isLoading.value = true;
    controller.submit(
      auth: emailAuthProvider,
      authMode: _authMode.value,
      data: _authData,
      formKey: _form,
    )
      ..catchError((error) {
        _isLoading.value = false;
        _showErrorDiolog(error.toString());
      })
      ..then(
        (_) {
          _isLoading.value = false;
        },
      );
  }

  void _switchAuthMode() {
    if (_authMode.value == AuthMode.login) {
      _authMode.value = AuthMode.register;
    } else {
      _authMode.value = AuthMode.login;
    }
  }

  void _showErrorDiolog(String message) {
    ScaffoldMessenger.of(_form.currentContext!).hideCurrentSnackBar();
    ScaffoldMessenger.of(_form.currentContext!)
        .showSnackBar(SnackBar(content: Text(message)));
  }
}
