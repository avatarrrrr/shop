import 'package:flutter/material.dart';
import 'package:shop/app/interfaces/auth_interface.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EmailVerificationAuthCardWidget extends StatelessWidget {
  EmailVerificationAuthCardWidget({
    Key? key,
    required this.emailAuthProvider,
  }) : super(key: key);

  final AuthInterface emailAuthProvider;
  final ButtonStyle buttonStyle = ElevatedButton.styleFrom(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(30),
    ),
    padding: EdgeInsets.symmetric(
      horizontal: 30,
      vertical: 8,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircularProgressIndicator(),
        SizedBox(height: 20),
        Text(
          AppLocalizations.of(context)!.emailIsNotVerifield,
        ),
        SizedBox(height: 20),
        Text(
          AppLocalizations.of(context)!.resendEmailVerification,
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: () => emailAuthProvider.reloadUserMetadada(),
          child: Text(AppLocalizations.of(context)!.verifyAgain),
          style: buttonStyle,
        ),
        SizedBox(height: 20),
        Text(AppLocalizations.of(context)!.emailWrong),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: () => emailAuthProvider.logout(),
          child: Text(AppLocalizations.of(context)!.cancel),
          style: buttonStyle,
        ),
      ],
    );
  }
}
