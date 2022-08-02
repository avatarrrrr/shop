import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shop/app/interfaces/auth_interface.dart';
import 'package:shop/app/utils/emit_message.dart';
import 'package:shop/app/utils/validators.dart';

class RecoverPasswordsTextFields extends StatelessWidget with Validators {
  RecoverPasswordsTextFields({
    Key? key,
    required this.authProvider,
    required this.switchToLoginPage,
  }) : super(key: key);
  final AuthInterface authProvider;
  final void Function(String) switchToLoginPage;

  final formKey = GlobalKey<FormState>();

  final emailFieldController = TextEditingController();
  final emailFieldFocusNode = FocusNode();

  final isLoading = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

    return Form(
      key: formKey,
      child: TextFormField(
        focusNode: emailFieldFocusNode,
        controller: emailFieldController,
        decoration: _textFormFieldStyle(
          placeholderText: appLocalizations.emailFieldPlaceholder,
        ),
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.next,
        validator: (textTyped) => emailValidator(
          stringTyped: textTyped,
          currentContext: context,
        ),
        onEditingComplete: () => _submitBehavior(
          messageToThrowToUserOnSucess: appLocalizations.resetPasswordSucess,
        ),
      ),
    );
  }

  InputDecoration _textFormFieldStyle({required String placeholderText}) {
    return InputDecoration(
      labelText: placeholderText,
      suffix: ValueListenableBuilder(
        valueListenable: isLoading,
        child: SizedBox(
          height: 24,
          width: 24,
          child: CircularProgressIndicator(),
        ),
        builder: (context, bool value, child) {
          if (value) {
            return child!;
          } else {
            return SizedBox();
          }
        },
      ),
    );
  }

  void _submitBehavior({required String messageToThrowToUserOnSucess}) {
    emailFieldFocusNode.unfocus();
    if (formKey.currentState!.validate()) {
      _startLoading();
      authProvider.sendResetPasswordEmail(
        emailTyped: emailFieldController.text,
      )
        ..catchError(_errorHandle)
        ..then(
          (_) => _thenHandle(messageToThrowToUserOnSucess),
        );
    }
  }

  void _startLoading() {
    isLoading.value = true;
  }

  void _errorHandle(error) {
    isLoading.value = false;
    throwMessageToUser(message: error.toString());
  }

  void _thenHandle(String messageToUser) {
    isLoading.value = false;
    throwMessageToUser(message: messageToUser);
    switchToLoginPage(emailFieldController.text);
  }
}
