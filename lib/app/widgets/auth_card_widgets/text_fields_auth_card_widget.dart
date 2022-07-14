import 'package:flutter/material.dart';
import 'package:shop/app/utils/validators.dart';
import 'package:shop/app/widgets/auth_card.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TextFieldsAuthCardWidget extends StatelessWidget with Validators {
  TextFieldsAuthCardWidget({
    Key? key,
    required this.authenticationMode,
    required this.onSubmit,
    required this.formData,
  }) : super(key: key);

  final void Function() onSubmit;
  final AuthMode authenticationMode;
  final passwordFocusNode = FocusNode();
  final confirmPasswordFocusNode = FocusNode();
  final Map<String, String> formData;
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final isRegisterMode = this.authenticationMode == AuthMode.register;
    final appLocalization = AppLocalizations.of(context)!;

    return Column(
      children: [
        TextFormField(
          decoration: InputDecoration(
            labelText: appLocalization.emailFieldPlaceholder,
          ),
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          onEditingComplete: () => passwordFocusNode.requestFocus(),
          validator: (textTyped) => emailValidator(
            stringTyped: textTyped,
            currentContext: context,
          ),
          onSaved: (value) => formData['email'] = value!,
        ),
        TextFormField(
          focusNode: passwordFocusNode,
          controller: passwordController,
          decoration: InputDecoration(
            labelText: appLocalization.passwordFieldPlaceholder,
          ),
          textInputAction:
              isRegisterMode ? TextInputAction.next : TextInputAction.done,
          obscureText: true,
          onEditingComplete: isRegisterMode
              ? () => confirmPasswordFocusNode.requestFocus()
              : () {
                  passwordFocusNode.unfocus();
                  onSubmit();
                },
          validator: (passwordTyped) => passwordValidator(
            stringTyped: passwordTyped,
            currentContext: context,
          ),
          onSaved: (value) => formData['password'] = value!,
        ),
        if (authenticationMode == AuthMode.register)
          TextFormField(
            focusNode: confirmPasswordFocusNode,
            decoration: InputDecoration(
              labelText:
                  AppLocalizations.of(context)!.confirmPasswordPlaceHolder,
            ),
            obscureText: true,
            onEditingComplete: () {
              confirmPasswordFocusNode.unfocus();
              onSubmit();
            },
            validator: (passwordTyped) => confirmPasswordValidator(
              stringTyped: passwordTyped,
              currentContext: context,
              passwordController: passwordController,
            ),
          ),
      ],
    );
  }
}
