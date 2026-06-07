part of 'locale_cubit.dart';

class LocaleState {
  const LocaleState({this.preference = LocalePreference.system});

  final LocalePreference preference;

  Locale? get locale => preference.locale;
}
