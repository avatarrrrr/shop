import 'package:flutter/material.dart';
import 'package:shop/app/interfaces/auth_interface.dart';
import 'package:shop/app/utils/emit_message.dart';
import 'package:shop/app/widgets/auth_card_widgets/buttons_auth_card_widget.dart';
import 'package:shop/app/widgets/auth_card_widgets/email_verification_auth_card_widget.dart';
import 'package:shop/app/widgets/auth_card_widgets/recover_password_text_fields.dart';
import 'package:shop/app/widgets/auth_card_widgets/text_fields_auth_card_widget.dart';

enum AuthMode {
  register,
  login,
  recoverPassword,
}

class AuthCard extends StatelessWidget {
  final AuthInterface emailAuthProvider;
  final Future<void> Function({
    required AuthInterface auth,
    GlobalKey<FormState>? formKey,
    required AuthMode authMode,
    Map<String, String>? data,
  }) onSubmit;

  AuthCard({
    Key? key,
    required this.emailAuthProvider,
    required this.onSubmit,
  });

  final _isLoading = ValueNotifier(false);
  final ValueNotifier<AuthMode> _authMode = ValueNotifier(AuthMode.login);
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
        child: ValueListenableBuilder(
          valueListenable: emailAuthProvider.emailVerifield,
          builder: (context, bool value, child) => !value
              ? EmailVerificationAuthCardWidget(
                  emailAuthProvider: emailAuthProvider,
                )
              : child!,
          child: Form(
            key: _form,
            child: ValueListenableBuilder(
              valueListenable: _authMode,
              child: SizedBox(height: 20),
              builder: (context, AuthMode authMode, child) {
                return Column(
                  children: [
                    authMode == AuthMode.recoverPassword
                        ? RecoverPasswordsTextFields(
                            authProvider: emailAuthProvider,
                            switchToLoginPage: returnToLoginPage,
                          )
                        : TextFieldsAuthCardWidget(
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
      ),
    );
  }

  void returnToLoginPage(String emailTypedOnTheResetPassword) {
    _authData.update('email', (_) => emailTypedOnTheResetPassword);
    _authMode.value = AuthMode.login;
  }

  void submit() {
    _isLoading.value = true;
    onSubmit(
      auth: emailAuthProvider,
      authMode: _authMode.value,
      data: _authData,
      formKey: _form,
    )
      ..catchError((error) {
        _isLoading.value = false;
        throwMessageToUser(message: error.toString());
      })
      ..then(
        (_) {
          _isLoading.value = false;
        },
      );
  }

  void _switchAuthMode(AuthMode authMode) => _authMode.value = authMode;
}
