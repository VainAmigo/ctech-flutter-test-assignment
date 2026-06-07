// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'GitHub Users';

  @override
  String get settings => 'Settings';

  @override
  String get language => 'Language';

  @override
  String get languageSystem => 'System';

  @override
  String get languageEnglish => 'English';

  @override
  String get languageRussian => 'Russian';

  @override
  String get retry => 'Retry';

  @override
  String get unknownError => 'Unknown error';

  @override
  String get loadError => 'Load error';

  @override
  String get loadDataError => 'Failed to load data';

  @override
  String get usersNotFound => 'No users found';

  @override
  String get searchUsersHint => 'Search users...';

  @override
  String get profileLoadError => 'Failed to load profile';

  @override
  String get reposLoadError => 'Failed to load repositories';

  @override
  String get reposNotFound => 'No repositories found';

  @override
  String reposTitle(String login) {
    return 'Repos · $login';
  }

  @override
  String get followers => 'Followers';

  @override
  String get following => 'Following';

  @override
  String get publicRepos => 'Public Repos';

  @override
  String get about => 'About';

  @override
  String get company => 'Company';

  @override
  String get location => 'Location';

  @override
  String get website => 'Website';

  @override
  String get memberSince => 'Member since';

  @override
  String get fork => 'Fork';

  @override
  String get noInternetConnection => 'No internet connection';

  @override
  String get internetConnectionRestored => 'Internet connection restored';
}
