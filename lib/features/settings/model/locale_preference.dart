import 'package:flutter/material.dart';

enum LocalePreference {
  system,
  en,
  ru;

  Locale? get locale => switch (this) {
    system => null,
    en => const Locale('en'),
    ru => const Locale('ru'),
  };

  String get storageCode => switch (this) {
    system => 'system',
    en => 'en',
    ru => 'ru',
  };

  static LocalePreference fromStorageCode(String? code) {
    return switch (code) {
      'en' => en,
      'ru' => ru,
      _ => system,
    };
  }
}
