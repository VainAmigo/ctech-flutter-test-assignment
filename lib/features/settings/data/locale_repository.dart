import 'package:ctech_flutter_test_app/features/settings/model/locale_preference.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleRepository {
  static const _storageKey = 'locale_preference';

  Future<LocalePreference> getPreference() async {
    final prefs = await SharedPreferences.getInstance();
    return LocalePreference.fromStorageCode(prefs.getString(_storageKey));
  }

  Future<void> savePreference(LocalePreference preference) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_storageKey, preference.storageCode);
  }
}
