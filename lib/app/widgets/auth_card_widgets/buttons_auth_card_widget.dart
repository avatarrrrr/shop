import 'package:flutter/material.dart';
import 'package:shop/app/widgets/auth_card.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ButtonsAuthCardWidget extends StatelessWidget {
  const ButtonsAuthCardWidget({
    Key? key,
    required this.isLoading,
    required this.authenticationMode,
    required this.onSubmit,
    required this.switchAuthenticationMode,
  }) : super(key: key);

  final bool isLoading;
  final AuthMode authenticationMode;
  final void Function(AuthMode) switchAuthenticationMode;
  final void Function() onSubmit;

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final textButtonStyle = ButtonStyle(
      foregroundColor:
          MaterialStateProperty.all(Theme.of(context).primaryColor),
    );
    final isNotRecoverPasswordMode =
        authenticationMode != AuthMode.recoverPassword;

    final showButtonsSubmitAndSwitchAuthentication = isNotRecoverPasswordMode
        ? [
            ElevatedButton(
              child: isLoading
                  ? CircularProgressIndicator(
                      color: Colors.white,
                    )
                  : Text(
                      authenticationMode == AuthMode.login
                          ? appLocalizations.sign
                          : appLocalizations.register,
                    ),
              onPressed: isLoading ? () {} : onSubmit,
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 8,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                if (authenticationMode == AuthMode.login) {
                  switchAuthenticationMode(AuthMode.register);
                } else {
                  switchAuthenticationMode(AuthMode.login);
                }
              },
              child: Text(
                appLocalizations.switchToSignImOrRegisterText(
                  authenticationMode == AuthMode.login
                      ? appLocalizations.register
                      : appLocalizations.sign,
                ),
              ),
              style: textButtonStyle,
            ),
          ]
        : [];

    return Column(
      children: [
        ...showButtonsSubmitAndSwitchAuthentication,
        TextButton(
          onPressed: () {
            if (isNotRecoverPasswordMode) {
              switchAuthenticationMode(AuthMode.recoverPassword);
            } else {
              switchAuthenticationMode(AuthMode.login);
            }
          },
          child: Text(
            isNotRecoverPasswordMode
                ? appLocalizations.passwordForget
                : appLocalizations.cancel,
          ),
          style: textButtonStyle,
        ),
      ],
    );
  }
}
