import 'package:ctech_flutter_test_app/l10n/app_localizations.dart';
import 'package:flutter/widgets.dart';

extension L10nExtension on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this);
}
