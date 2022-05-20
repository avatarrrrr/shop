import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'app/app_widget.dart';

Future<void> main() async {
  await dotenv.load();
  runApp(Shop());
}

Future<AppLocalizations> get getAppLocalizationsWithoutContext {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  final preferred = widgetsBinding.window.locales;
  const supported = AppLocalizations.supportedLocales;
  final locale = basicLocaleListResolution(preferred, supported);
  return AppLocalizations.delegate.load(locale);
}
