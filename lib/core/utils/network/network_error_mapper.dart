import 'package:ctech_flutter_test_app/core/core.dart';
import 'package:ctech_flutter_test_app/l10n/app_localizations.dart';
import 'package:ctech_flutter_test_app/network/network.dart';
import 'package:dio/dio.dart';

class NetworkErrorMapper {
  const NetworkErrorMapper._();

  static AppLocalizations? get _l10n {
    final context = AppMessenger.messengerKey.currentContext;
    if (context == null) return null;
    return AppLocalizations.of(context);
  }

  static void notifyIfNoInternet(Object error) {
    if (!isNoInternet(error)) return;

    final l10n = _l10n;
    if (l10n != null) {
      AppMessenger.showError(l10n.noInternetConnection);
    }
  }

  static String? message(Object? error) {
    if (error == null) return null;

    final l10n = _l10n;
    if (l10n == null) return _fallbackMessage(error);

    if (isNoInternet(error)) {
      return l10n.noInternetConnection;
    }

    return l10n.loadDataError;
  }

  static bool isNoInternet(Object error) {
    if (error is NoInternetException) return true;
    return error is DioException && _isConnectionIssue(error);
  }

  static String _fallbackMessage(Object error) {
    if (isNoInternet(error)) return 'No internet connection';
    return 'Failed to load data';
  }

  static bool _isConnectionIssue(DioException error) {
    return switch (error.type) {
      DioExceptionType.connectionError ||
      DioExceptionType.connectionTimeout ||
      DioExceptionType.sendTimeout ||
      DioExceptionType.receiveTimeout => true,
      _ => false,
    };
  }
}
