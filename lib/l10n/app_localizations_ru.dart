// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get appTitle => 'GitHub Users';

  @override
  String get settings => 'Настройки';

  @override
  String get language => 'Язык';

  @override
  String get languageSystem => 'Системный';

  @override
  String get languageEnglish => 'English';

  @override
  String get languageRussian => 'Русский';

  @override
  String get retry => 'Повторить';

  @override
  String get unknownError => 'Неизвестная ошибка';

  @override
  String get loadError => 'Ошибка загрузки';

  @override
  String get loadDataError => 'Не удалось загрузить данные';

  @override
  String get usersNotFound => 'Пользователи не найдены';

  @override
  String get searchUsersHint => 'Поиск пользователей...';

  @override
  String get profileLoadError => 'Не удалось загрузить профиль';

  @override
  String get reposLoadError => 'Не удалось загрузить репозитории';

  @override
  String get reposNotFound => 'Репозитории не найдены';

  @override
  String reposTitle(String login) {
    return 'Repos · $login';
  }

  @override
  String get followers => 'Подписчики';

  @override
  String get following => 'Подписки';

  @override
  String get publicRepos => 'Публичные репозитории';

  @override
  String get about => 'О себе';

  @override
  String get company => 'Компания';

  @override
  String get location => 'Местоположение';

  @override
  String get website => 'Веб-сайт';

  @override
  String get memberSince => 'В команде с';

  @override
  String get fork => 'Fork';

  @override
  String get noInternetConnection => 'Нет подключения к интернету';

  @override
  String get internetConnectionRestored =>
      'Подключение к интернету восстановлено';
}
