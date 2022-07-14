import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Future<AppLocalizations> get getAppLocalizationsWithoutContext {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  final preferred = widgetsBinding.window.locales;
  const supported = AppLocalizations.supportedLocales;
  final locale = basicLocaleListResolution(preferred, supported);
  return AppLocalizations.delegate.load(locale);
}
